;; Tabbar-window.el --- "Window Tabs" for tabbar-mode: Tab-set is
;; specific to each window, and tabbar is hidden when only a
;; single tab exists for that window. Requires that tabbar.el and
;; aquamacs-tabbar.el be loaded first.

;; Author: Nathaniel Cunningham <nathaniel.cunningham@gmail.com>
;; Maintainer: Nathaniel Cunningham <nathaniel.cunningham@gmail.com>
;; Created: February 2008
;; (C) Copyright 2008, the Aquamacs Project
;; Revision: $Id: tabbar-window.el,v 1.64 2009/03/02 21:04:51 davidswelt Exp $

(defvar tabbar-window-alist nil)
(defvar tabbar-window-cache nil) 

(defun window-number (window)
  "Return window ID as a number."
  (let ((window-string (format "%s" window)))
    (string-to-number
     (nth 1 (split-string window-string "\\(<window \\| on \\)" )))))

(defun window-number-list ()
  "Return IDs of all windows as list of numbers."
  (let (window-numbers)
    (walk-windows
     #'(lambda (window)
	 (push (window-number window) window-numbers)) 'nomini t)
    window-numbers))

(defun tabbar-window-update-alist (window)
  "Update the list of windows and corresponding buffers to be
shown in tabs.  Add a tabset for current window if it does not
yet exist, and update list of tabs to include the currently
displayed buffer"
  (let* ((wnumber (window-number window))
	 (wbuffer (window-buffer window))
	 (window-elt (assq wnumber tabbar-window-alist))
	 (tabbar-buffers-list (funcall tabbar-buffer-list-function)))
    ;; only include buffers that should have tabs (ignore tooltip windows, etc.)
    (when (memq wbuffer tabbar-buffers-list)
      (if window-elt
	  ;;if so, check whether window-buffer is listed for this window
	  (let ((window-buffer-list (cdr window-elt)))
	    (unless (memq wbuffer window-buffer-list)
	      ;;add this buffer if not
	      (setq tabbar-window-alist
		    (cons (cons wnumber (append window-buffer-list (list wbuffer)))
			  (assq-delete-all wnumber tabbar-window-alist)))))
	;; if not, add (window-number . '((buffer-window))) to the alist
	(push (cons wnumber (list wbuffer)) tabbar-window-alist))))
  tabbar-window-alist)

(defun window-number-get-window (wnumber)
  "Return IDs of all windows as list of numbers."
  (let (window-id)
    (walk-windows
     #'(lambda (window)
	 (when (eq wnumber (window-number window))
	   (setq window-id window))) 'nomini t)
    window-id))

(defun tabbar-window-cleanup-alist ()
  "Remove from tabbar-window-alist any elements (windows OR
buffers) that no longer exist, or buffers that don't get tabs.
Displayed buffers always get tabs."
  (let ((tabbar-buffers-list (funcall tabbar-buffer-list-function))
	(wnumber-list (window-number-list)))
    ;; loop through alist
    (dolist (elt tabbar-window-alist)
      (let* ((wnumber (car elt))
	     (blist (cdr elt))
	     (newlist blist)
	     newelt)
	;; remove entire elt from alist
	(setq tabbar-window-alist (remove elt tabbar-window-alist))
	;; if the window still exists, delete any buffers as needed
	(when (memq wnumber wnumber-list)
	  ;; for extant windows, loop through buffers
	  ;; delete any that aren't listed by
	  ;; (tabbar-buffer-list-function) 
	  ;; later, make this UNLESS they're displayed in that window
	  (dolist (thisbuffer blist)
	    (unless (member thisbuffer tabbar-buffers-list)
	      (setq newlist (remove thisbuffer newlist))))
	  (when newlist
	    (setq newelt (cons wnumber newlist)))
	  ;; replace elt with newelt -- at END to preserve alist order
	  (setq tabbar-window-alist (append tabbar-window-alist (list newelt))) )
	)))
  tabbar-window-alist)

(defun tabbar-tabset-names ()
  "Return list of strings giving names of all tabsets"
  (let (tabset-names)
    (mapatoms
     #'(lambda (symbol)
	 (push (symbol-name symbol) tabset-names))
     tabbar-tabsets)
    tabset-names))

(defun tabbar-window-update-tabsets ()
  "Update tab sets from tabbar-window-alist.
Return the current tabset, which corresponds to (selected-window)."
  ;; run tabbar-window-update-alist for all windows
  (walk-windows 'tabbar-window-update-alist 'nomini t)
  ;; run tabbar-window-cleanup-alist to remove defunct entries (this
  ;; seems to be changing tabbar-window-cache the same way it changes
  ;; tabbar-window-alist ! )
  (tabbar-window-cleanup-alist)
  ;; if the alist has changed, update the tab sets (compare against cache)
  (unless (equal tabbar-window-alist tabbar-window-cache) ;having problems with cache
    ;; cycle through alist.
    (dolist (elt tabbar-window-alist)
      ;; for each window group:
      (let* ((groupnum (car elt))
	     (groupname (number-to-string groupnum))
	     (buflist (cdr elt))
	     (tabset (tabbar-get-tabset groupname)))
	;; if the corresponding tabset already exists
	(if tabset
	    ;; add tabs for any buffers that arent't listed in this group in cache
	    (let ((old-buflist (cdr (assoc groupnum tabbar-window-cache))))
	      (dolist (buf buflist)
		(unless (memq buf old-buflist)
		  (tabbar-add-tab tabset buf t)
		  ;;Update the tabs display
		  (tabbar-set-template tabset nil))))
	  ;; if tabset doesn't exist, create new containing first buffer
	  (tabbar-make-tabset groupname (car buflist))
	  ;; then add any remaining buffers
	  (dolist (buf (cdr buflist))
	    (tabbar-add-tab tabset buf t))
	  ;;Update the tabs display
	  (tabbar-set-template tabset nil))))
    ;; cycle through tabsets
    (dolist (tabset-name (tabbar-tabset-names))
      (let* ((tabset (tabbar-get-tabset tabset-name))
	     (tabset-number (string-to-number tabset-name))
	     (tabset-alist-elt (assq tabset-number tabbar-window-alist)))
	(if tabset-alist-elt
	    ;; if there is a corresponding window in tabbar-window-alist,
	    ;; cycle through tabs
	    (let ((buflist (cdr tabset-alist-elt)))
	      (dolist (tab (tabbar-tabs tabset))
		;; delete any tabs for buffers not listed with this window
		(unless (memq (car tab) buflist)
		  (tabbar-delete-tab tab))))
	  ;;if no corresponding window in tabbar-window-alist,
	  ;;delete all containted tabs and tabset
	  (dolist (tab (tabbar-tabs tabset))
	    (tabbar-delete-tab tab))
	  (tabbar-delete-tabset tabset))))
    ;; duplicate tabbar-window-alist, so we can detect changes (have
    ;; to ensure that changes within tabbar-window-alist don't affect
    ;; tabbar-window cache)
    (setq tabbar-window-cache (copy-alist tabbar-window-alist)))
  (number-to-string (window-number (selected-window))))

(defun tabbar-window-tabs ()
  "Return the buffers to display on the tab bar, in a tab set."
  (let ((tabset (tabbar-get-tabset (tabbar-window-update-tabsets))))
    (tabbar-select-tab-value (current-buffer) tabset)
    tabset))

(defun tabbar-window-button-label (name)
  ;; Use empty string for HOME button, so it doesn't show up.
  "Return a label for button NAME.
That is a pair (ENABLED . DISABLED), where ENABLED and DISABLED are
respectively the appearance of the button when enabled and disabled.
They are propertized strings which could display images, as specified
by the variable `tabbar-button-label'."
  (if (eq name 'home)
      (cons "" "")
    (tabbar-button-label name)))

(defun tabbar-window-tab-label (tab)
  "Return a label for TAB.
That is, a string used to represent it on the tab bar."
  (let ((label (format " %s " (tabbar-tab-value tab))))
    ;; Unless the tab bar auto scrolls to keep the selected tab
    ;; visible, shorten the tab label to keep as many tabs as possible
    ;; in the visible area of the tab bar.
    (if tabbar-auto-scroll-flag
        label
      (tabbar-shorten
       label (max 1 (/ (window-width)
                       (length (tabbar-view
                                (tabbar-current-tabset)))))))))

(defun tabbar-window-help-on-tab (tab)
  "Return the help string shown when mouse is onto TAB."
  (format "%s" (buffer-name (tabbar-tab-value tab))))

(defun tabbar-window-select-tab (event tab &optional prefix)
  "On mouse EVENT, select TAB."
  (let ((mouse-button (event-basic-type event))
	(one-buffer-one-frame-inhibit t)
        (buffer (tabbar-tab-value tab)))
    (cond
     ((eq mouse-button 'mouse-3)
      (popup-menu tabbar-context-menu-map event prefix))
     (t
      (switch-to-buffer buffer)))
    ))

(defun tabbar-window-track-killed ()
  "Hook run just before actually killing a buffer.
In Tabbar mode, try to switch to a buffer in the current tab bar,
after the current buffer has been killed.  Try first the buffer in tab
after the current one, then the buffer in tab before.  On success, put
the sibling buffer in front of the buffer list, so it will be selected
first."
  (and (eq header-line-format tabbar-header-line-format)
       (eq tabbar-current-tabset-function 'tabbar-window-tabs)
       (eq (current-buffer) (window-buffer (selected-window)))
       (let ((bl (tabbar-tab-values (tabbar-current-tabset)))
             (b  (current-buffer))
             found sibling)
         (while (and bl (not found))
           (if (eq b (car bl))
               (setq found t)
             (setq sibling (car bl)))
           (setq bl (cdr bl)))
         (when (and (setq sibling (or (car bl) sibling))
                    (buffer-live-p sibling))
           ;; Move sibling buffer in front of the buffer list.
           (save-current-buffer
             (switch-to-buffer sibling))))))

;;; Tab bar window setup
;;
(defun tabbar-window-init ()
  "Initialize tab bar data for tab grouping by window.
Run as `tabbar-init-hook'."
  (setq tabbar-window-alist nil
	tabbar-window-cache nil
        tabbar-current-tabset-function 'tabbar-window-tabs
        tabbar-tab-label-function 'tabbar-window-tab-label
        tabbar-select-tab-function 'tabbar-window-select-tab
        tabbar-help-on-tab-function 'tabbar-window-help-on-tab
        tabbar-button-label-function 'tabbar-window-button-label
        tabbar-home-function nil
        tabbar-home-help-function nil
	tabbar-home-button-value nil
        )
  (add-hook 'kill-buffer-hook 'tabbar-window-track-killed))

(defun tabbar-window-quit ()
  "Quit tab bar \"tabbar-window\" mode.
Run as `tabbar-quit-hook'."
  (setq tabbar-window-alist nil
	tabbar-window-cache nil
        tabbar-current-tabset-function nil
        tabbar-tab-label-function nil
        tabbar-select-tab-function nil
        tabbar-help-on-tab-function nil
        tabbar-button-label-function nil
        tabbar-home-function nil
        tabbar-home-help-function nil
	tabbar-home-button-value nil
        )
  (remove-hook 'kill-buffer-hook 'tabbar-window-track-killed))

;;-----------------------------------------------
(remove-hook 'tabbar-init-hook 'tabbar-buffer-init)
(remove-hook 'tabbar-quit-hook 'tabbar-buffer-quit)
(remove-hook 'kill-buffer-hook 'tabbar-buffer-track-killed)

(add-hook 'tabbar-init-hook 'tabbar-window-init)
(add-hook 'tabbar-quit-hook 'tabbar-window-quit)

(run-hooks 'tabbar-init-hook)
