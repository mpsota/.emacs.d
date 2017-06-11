(setq inhibit-splash-screen t)
(setq line-number-mode t)
(setq column-number-mode t)
;; Text and the such
;; Use colors to highlight commands, etc.
(global-font-lock-mode t)
;; Disable the welcome message
(setq inhibit-startup-message t)
;; Format the title-bar to always include the buffer name
(setq frame-title-format "emacs - %b")
;; Make the mouse wheel scroll Emacs
(mouse-wheel-mode t)
;; Always end a file with a newline
(setq require-final-newline t)
;; Stop emacs from arbitrarily adding lines to the end of a file when the
;; cursor is moved past the end of it:
(setq next-line-add-newlines nil)
;; Flash instead of that annoying bell
(setq visible-bell t)
;; scroll-bar on the left, like in old emacs
(set-scroll-bar-mode 'left)
;; Remove icons toolbar
(if (> emacs-major-version 20)
    (tool-bar-mode -1))
;; Use y or n instead of yes or not
(fset 'yes-or-no-p 'y-or-n-p)
;; nr kolumn
(setq column-number-mode t)
;; additional M-x
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
;przewijanei normalne
(setq scroll-conservatively 1)
;lepsze zarzadzanie bufforami
;; (iswitchb-mode t)
;; make cursor movement keys under right hand's home-row.
(global-set-key (kbd "M-i") 'previous-line) ; was tab-to-tab-stop
(global-set-key (kbd "M-j") 'backward-char) ; was indent-new-comment-line
(global-set-key (kbd "M-k") 'next-line) ; was kill-sentence
(global-set-key (kbd "M-l") 'forward-char)  ; was downcase-word
;; type parens in pairs with Hyper and right hands's home-row
;(setq w32-pass-lwindow-to-system nil
;      w32-pass-rwindow-to-system nil
;      w32-pass-apps-to-system nil
;      w32-lwindow-modifier 'super ;; Left Windows key
;      w32-rwindow-modifier 'super ;; Right Windows key
;      w32-apps-modifier 'hyper)


;; Lets use windows key!
(global-set-key (kbd "s-u") 'delete-backward-char)
(global-set-key (kbd "s-o") 'delete-forward-char)

(global-set-key (kbd "M-s-j") (lambda () (interactive) (insert "{}") (backward-char 1)))
(defun insert-left-parenthesis ()
  (interactive) (insert "("))
(defun insert-right-parenthesis ()
  (interactive) (insert ")"))
(global-set-key (kbd "s-j") 'insert-left-parenthesis)
(global-set-key (kbd "s-k") 'insert-right-parenthesis)
;; or: ?
(global-set-key (kbd "M-u") 'insert-left-parenthesis)
(global-set-key (kbd "M-o") 'insert-right-parenthesis)

(global-set-key (kbd "C-M-j") 'backward-sexp)
(global-set-key (kbd "C-M-l") 'forward-sexp)


;; undo
(global-set-key (kbd "M-c") 'undo)  ; was capitalize-word
;; microsoft natural ergo keyboard
(global-set-key (kbd "<XF86Forward>") 'other-window)
(global-set-key (kbd "<XF86Back>") (lambda ()
				     (interactive)
				     (other-window -1)))
;; resizing window
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)
(when (fboundp 'winner-mode)
      (winner-mode 1))
;;chop mode
;(require 'chop)
;(global-set-key (kbd "M-<up>") 'chop-move-up)
;(global-set-key (kbd "M-<down>") 'chop-move-down)

;; Google Search
(defun search-google ()
  "Prompt for a query in the minibuffer, launch the web browser and query google."
  (interactive)
  (let ((search (read-from-minibuffer "Google Search: ")))
    (browse-url (concat "http://www.google.com/search?q=" search))))

;wlaczone nawiasy
(show-paren-mode t)

;;split window
(defun my-split-window-vertically ()
    (interactive)
    (split-window-vertically)
    (set-window-buffer (next-window) (other-buffer))
    (select-window (next-window)))

(defun my-split-window-horizontally ()
    (interactive)
    (split-window-horizontally)
    (set-window-buffer (next-window) (other-buffer))
    (select-window (next-window)))

(global-set-key "\C-x2" 'my-split-window-vertically)
(global-set-key "\C-x3" 'my-split-window-horizontally)

(defadvice my-window-splitting-advice
    (after split-window-vertically first () activate)
    (set-window-buffer (next-window) (other-buffer)))

;;full screen na starcie:
(defun toggle-fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
			 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
(if window-system
 (toggle-fullscreen))

;; Highlighting
;; highlight region between point and mark
(transient-mark-mode t)

(global-set-key [f2] 'kmacro-start-macro)
(global-set-key [f3] 'kmacro-end-macro)
(global-set-key [f4] 'kmacro-call-macro)

(global-set-key [f5] 'revert-buffer)
(global-set-key [f6] 'smart-compile)
(global-set-key [f7] 'replace-string)
(global-set-key [f8] 'next-error)
(global-set-key [f9] 'find-file)
;; (global-set-key [f10] 'shell-command)
(global-set-key [f11] 'term)

(global-set-key [help] 'info)



;(global-set-key [f10] 'delete-frame)
;; (global-set-key "\M-0" 'buffer-menu)
;; (global-set-key [(control menu)] 'popup-mode-menu)
(global-set-key [(shift insert)] 'clipboard-yank)
(global-set-key [(shift delete)] 'clipboard-kill-region)
(global-set-key [(control insert)] 'clipboard-kill-ring-save)
;(global-set-key [(control x) r j] 'bookmark-jump)

;; (global-set-key [(control tab)] `other-window)
;; (defun switch-to-other-buffer () (interactive) (switch-to-buffer (other-buffer)))
(global-set-key [(meta g)] 'goto-line)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;; Make C-h a to search in all symbols, not only in interactive functions.
(define-key help-map "a" 'apropos)

(defun stop-using-minibuffer () ;http://trey-jackson.blogspot.com/2010/04/emacs-tip-36-abort-minibuffer-when.html
  "kill the minibuffer when you click mouse outside it eg. C-x-f"
  (when (and (>= (recursion-depth) 1) (active-minibuffer-window))
    (abort-recursive-edit)))

(add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)

(defun pretty-greek ()
  (let ((greek '("alpha" "beta" "gamma" "delta" "epsilon" "zeta" "eta" "theta" "iota" "kappa" "lambda" "mu" "nu" "xi" "omicron" "pi" "rho" "sigma_final" "sigma" "tau" "upsilon" "phi" "chi" "psi" "omega")))
    (loop for word in greek
          for code = 97 then (+ 1 code)
          do  (let ((greek-char (make-char 'greek-iso8859-7 code)))
                (font-lock-add-keywords nil
                                        `((,(concatenate 'string "\\(^\\|[^a-zA-Z0-9]\\)\\(" word "\\)[a-zA-Z]")
                                           (0 (progn (decompose-region (match-beginning 2) (match-end 2))
                                                     nil)))))
                (font-lock-add-keywords nil
                                        `((,(concatenate 'string "\\(^\\|[^a-zA-Z0-9]\\)\\(" word "\\)[^a-zA-Z]")
                                           (0 (progn (compose-region (match-beginning 2) (match-end 2)
                                                                     ,greek-char)
                                                     nil)))))))))

(add-hook 'lisp-mode-hook 'pretty-greek)
;; (add-hook 'emacs-lisp-mode-hook 'pretty-greek)

;; w3m as link-opener
 (setq browse-url-browser-function 'browse-url-generic
       browse-url-generic-program "firefox")

(defun choose-browser (url &rest args)
  (interactive "sURL: ")
  (if (y-or-n-p "Use external browser? ")
      (browse-url-generic url)
      (progn
        (my-split-window-horizontally)
        (w3m-browse-url url)
        ;; (select-window (previous-window))

        )))

(setq browse-url-browser-function 'choose-browser)

;;fullscreen
    (defun toggle-fullscreen (&optional f)
      (interactive)
      (let ((current-value (frame-parameter nil 'fullscreen)))
           (set-frame-parameter nil 'fullscreen
                                (if (equal 'fullboth current-value)
                                    (if (boundp 'old-fullscreen) old-fullscreen nil)
                                    (progn (setq old-fullscreen current-value)
                                           'fullboth)))))

    (global-set-key [f12] 'toggle-fullscreen)

;;hs-hide/show-mode

(defvar hs-special-modes-alist
  (mapcar 'purecopy
  '((lisp-mode "(" ")" "/[*/]" nil)
    (c-mode "{" "}" "/[*/]" nil nil)
    (c++-mode "{" "}" "/[*/]" nil nil)
    (bibtex-mode ("@\\S(*\\(\\s(\\)" 1))
    (java-mode "{" "}" "/[*/]" nil nil)
    (js-mode "{" "}" "/[*/]" nil))))

(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)

(setq-default indent-tabs-mode nil)

(setf select-active-regions nil)
(setf mouse-drag-copy-region t)
(setf x-select-enable-primary t)
(setf x-select-enable-clipboard nil)

(setf mouse-yank-at-click 'mouse-2)
(setf x-select-enable-clipboard-manager nil)

;; magit
(global-set-key "\C-xg" 'magit-status)
(setq magit-last-seen-setup-instructions "1.4.0")



;;; (custom-set-variables
;;;  ;; custom-set-variables was added by Custom.
;;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;;  ;; Your init file should contain only one such instance.
;;;  ;; If there is more than one, they won't work right.
;;;  '(ac-sources (quote (ac-source-yasnippet ac-source-imenu ac-source-abbrev ac-source-words-in-buffer ac-source-files-in-current-dir ac-source-filename)) t)
;;;  '(column-number-mode t)
;;;  '(display-time-mode t)
;;;  '(erc-generate-log-file-name-function (quote erc-generate-log-file-name-long))
;;;  '(erc-insert-timestamp-function (quote erc-insert-timestamp-left))
;;;  '(erc-log-channels-directory "~/.erc-logs")
;;;  '(erc-log-mode t)
;;;  '(erc-log-write-after-send t)
;;;  '(erc-part-reason (quote erc-part-reason-normal))
;;;  '(erc-save-buffer-on-part t)
;;;  '(erc-timestamp-format "[%H:%M:%S] ")
;;;  '(erc-timestamp-format-left "
;;; [%a %b %e %Y]
;;; ")
;;;  '(erc-timestamp-format-right nil)
;;;  '(latex-run-command "latex --shell-escape")
;;;  '(org-agenda-custom-commands (quote (("d" todo "DELEGATED" nil) ("c" todo "DONE|DEFERRED|CANCELLED" nil) ("w" todo "WAITING" nil) ("W" agenda "" ((org-agenda-ndays 21))) ("A" agenda "" ((org-agenda-skip-function (lambda nil (org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]"))) (org-agenda-ndays 1) (org-agenda-overriding-header "Today's Priority #A tasks: "))) ("u" alltodo "" ((org-agenda-skip-function (lambda nil (org-agenda-skip-entry-if (quote scheduled) (quote deadline) (quote regexp) "<[^>
;;; ]+>"))) (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
;;;  '(org-agenda-files (quote ("~/todo.org")))
;;;  '(org-agenda-ndays 7)
;;;  '(org-agenda-show-all-dates t)
;;;  '(org-agenda-skip-deadline-if-done t)
;;;  '(org-agenda-skip-scheduled-if-done t)
;;;  '(org-agenda-start-on-weekday nil)
;;;  '(org-deadline-warning-days 14)
;;;  '(org-default-notes-file "~/notes.org")
;;;  '(org-fast-tag-selection-single-key (quote expert))
;;;  '(org-remember-store-without-prompt t)
;;;  '(org-remember-templates '((116 "* TODO %? %u" "~/todo.org" "Tasks") (110 "* %u %?" "~/notes.org" "Notes"))) ;"
;;;  '(org-reverse-note-order t)
;;;  '(remember-annotation-functions (quote (org-remember-annotation)))
;;;  '(remember-handler-functions (quote (org-remember-handler)))
;;;  '(safe-local-variable-values (quote ((Package . FAST) (Base . 10) (Syntax . ANSI-Common-Lisp) (Syntax . Common-Lisp))))
;;;  '(show-paren-mode t)
;;;  '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.

 '(default ((t (:foreground "wheat" :background "black" :family "Bitstream Vera Sans Mono" :foundry "bitstream" :slant normal :weight normal :height 98 :width normal))))
 '(flyspell-duplicate ((t (:foreground "Gold3" :underline t :weight normal))))
 '(flyspell-incorrect ((t (:foreground "OrangeRed" :underline t :weight normal))))
 '(font-lock-comment-face ((t (:foreground "SteelBlue1"))))
 '(font-lock-function-name-face ((t (:foreground "gold"))))
 '(font-lock-keyword-face ((t (:foreground "springgreen"))))
 '(font-lock-type-face ((t (:foreground "PaleGreen"))))
 '(font-lock-variable-name-face ((t (:foreground "Coral"))))
 '(font-lock-warning-face ((t (:foreground "#FF0000" :bold t))))
 '(menu ((((type x-toolkit)) (:background "light slate gray" :foreground "wheat" :box (:line-width 2 :color "grey75" :style released-button)))))
 '(mode-line ((t (:foreground "black" :background "light slate gray"))))
 '(tool-bar ((((type x w32 mac) (class color)) (:background "light slate gray" :foreground "wheat" :box (:line-width 1 :style released-button))))))

;; grep
;; (grep-compute-defaults)
(setq grep-command "grep -nH *.lisp -e \"\"")

(setq scroll-conservatively 10000
      scroll-step 1)

;; warning about big files - 100MB
(setq large-file-warning-threshold 100000000)

;; scpaste.el
 (autoload 'scpaste "scpaste" "Paste the current buffer." t nil)
 (setq scpaste-http-destination "https://antoszka.pl/p"
       scpaste-scp-destination "k:/var/www/antoszka.pl/p")
;; save minibuffer across sessions
(savehist-mode 1)
(setq savehist-additional-variables '(search-ring regexp-search-ring))
;; (setq savehist-file "~/.emacs.d/tmp/savehist")

;; dont warn about undo
(setq warning-suppress-types '())
(add-to-list 'warning-suppress-types '(undo discard-info))
;; Ctrl-K with no kill
(defun delete-line-no-kill ()
  (interactive)
  (delete-region
   (point)
   (save-excursion (move-end-of-line 1) (point)))
  ;;(delete-char 1)
  )
(global-set-key (kbd "C-S-k") 'delete-line-no-kill)

(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)

(setq ediff-split-window-function 'split-window-horizontally)

;;; better registers

;; (make-variable-buffer-local 'register-alist) ; it's global by default
;; (defface register-marker-face '((t (:background "grey")))
;;   "Used to mark register positions in a buffer."
;;   :group 'faces)
;; (defun set-register (register value)
;;   "Set Emacs register named REGISTER to VALUE.  Returns VALUE.
;;     See the documentation of `register-alist' for possible VALUE."
;;   (let ((aelt (assq register register-alist))
;;         (sovl (intern (concat "point-register-overlay-"
;;                               (single-key-description register))))
;;         )
;;     (when (not (boundp sovl))
;;       (set sovl (make-overlay (point)(point)))
;;       (overlay-put (symbol-value sovl) 'face 'register-marker-face)
;;       (overlay-put (symbol-value sovl) 'help-echo
;;                    (concat "Register: `"
;;                            (single-key-description register) "'")))
;;     (delete-overlay (symbol-value sovl))
;;     (if (markerp value)
;;         ;; I'm trying to avoid putting overlay on newline char
;;         (if (and (looking-at "$")(not (looking-back "^")))
;;             (move-overlay (symbol-value sovl) (1- value) value)
;;           (move-overlay (symbol-value sovl) value (1+ value))))
;;     (if aelt
;;         (setcdr aelt value)
;;       (push (cons register value) register-alist))
;;     value))

;; special bindings

(global-set-key (kbd "M-.") (defun insert-bullet-command (arg)
                              (interactive "P")
                              (insert-char ?\u2022)))

;;(global-set-key [(super shift right)] (defun insert-right-arrow-command (arg)
;;                                        (interactive "P")
;;                                        (insert-char ?\u2192 arg)))

;;(global-set-key [(super shift left)] (defun insert-left-arrow-command (arg)
;;                                       (interactive "P")
;;                                      (insert-char ?\u2190 arg)))

;; neo tree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; slime like navigation for elisp
;(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
;  (require 'elisp-slime-nav)
;  (add-hook hook 'turn-on-elisp-slime-nav-mode))


(defun my-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my-minibuffer-exit-hook ()
  (setq gc-cons-threshold 800000))

(add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)

(windmove-default-keybindings)
(provide 'mp-settings)
