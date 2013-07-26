(require 'ido)                      ; ido is part of emacs 
(ido-mode t)                        ; for both buffers and files
(setq 
   ido-ignore-buffers               ; ignore these guys
   '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido")
   ido-ignore-files
   '( "\\`#" "\\`*fasl"  "64ufasl")
   ido-work-directory-list '("~/" "~/Desktop" "~/Documents")
   ido-case-fold  t                 ; be case-insensitive
   ido-use-filename-at-point nil    ; don't use filename at point (annoying)
   ido-use-url-at-point nil         ;  don't use url at point (annoying)
   ido-enable-flex-matching t       ; be flexible
   ido-max-prospects 6              ; don't spam my minibuffer
   ido-confirm-unique-completion nil) ; not wait for RET, even with unique completion

;; Support functions for `stesla-rotate-buffers'.  From the EmacsWiki.

(defvar stesla-hated-buffers '("todo.org" "KILL" "*Apropos*" "*Completions*" "*grep*" "*scratch*"
                                ".newsrc-dribble" ".bbdb" "sent-mail" "*vc*"
                               "*Compile-Log*" "*Help*" "*Messages*" "*JDEE bsh*" "*slime-events*" 
			       "*inferior-lisp*" "*compilation*"))  

(global-set-key "\M-x" (lambda ()
			 (interactive)
			 (call-interactively
			  (intern
			   (ido-completing-read
			    "M-x "
			    (all-completions "" obarray 'commandp))))))

;; sort ido filelist by mtime instead of alphabetically
;(add-hook 'ido-make-file-list-hook 'ido-sort-mtime)
;(add-hook 'ido-make-dir-list-hook 'ido-sort-mtime)
;(defun ido-sort-mtime ()
;  (setq ido-temp-list
;	(sort ido-temp-list 
;	      (lambda (a b)
;		(let ((a-tramp-file-p (string-match-p ":\\'" a))
;		      (b-tramp-file-p (string-match-p ":\\'" b)))
;		  (cond
;		   ((and a-tramp-file-p b-tramp-file-p)
;		    (string< a b))
;		   (a-tramp-file-p nil)
;		   (b-tramp-file-p t)
;		   (t (time-less-p
;		       (sixth (file-attributes (concat ido-current-directory b)))
;		       (sixth (file-attributes (concat ido-current-directory a))))))))
;	      ))
;  (ido-to-end  ;; move . files to end (again)
;   (delq nil (mapcar
;	      (lambda (x) 
;		(and (char-equal (string-to-char x) ?.)
;		     x))
;	      ido-temp-list))))


(defvar stesla-hated-buffer-regexps '("^ " "*Buffer" "^\\*trace" "^\\*tramp"))

 (setq iswitchb-buffer-ignore (append stesla-hated-buffer-regexps  stesla-hated-buffers))

 (defmacro stesla-buffer-regexp-mapcar (regexp buffers)
  "Find BUFFERS whose name matches REGEXP"
  `(mapcar (lambda (this-buffer)
             (if (string-match ,regexp (buffer-name this-buffer))
                 this-buffer))
           ,(if (symbolp buffers) (symbol-value buffers) buffers)))

 (defmacro stesla-hated-buffer-from-regexps (regexps)
  "Generate a one-dimensional list of buffers that match REGEXPS"
  (append
   '(append)
   (mapcar (lambda (regexp)
             `(delete nil (stesla-buffer-regexp-mapcar ,regexp
                                                       (buffer-list))))
           (if (symbolp regexps) (symbol-value regexps) regexps))))

 (defun stesla-delete-from-list (delete-these from-list)
  "Delete DELETE-THESE from FROM-LIST."
  (cond
   ((car delete-these)
    (if (member (car delete-these) from-list)
        (stesla-delete-from-list (cdr delete-these)
                                (delete (car delete-these) from-list))
      (stesla-delete-from-list (cdr delete-these) from-list)))
   (t from-list)))

 (defun stesla-hated-buffers ()
  "List of buffers I never want to see."
  (delete nil
          (append
           (mapcar 'get-buffer stesla-hated-buffers)
           (stesla-hated-buffer-from-regexps stesla-hated-buffer-regexps))))

 ;; `stesla-rotate-buffers': Like `bury-buffer' but with the capability to
 ;; exclude certain specified buffers.

 (defun stesla-rotate-buffers (&optional n)
  "Switch to the Nth next buffer.  Negative arguments move backwards."
  (interactive)
  (unless n
    (setq n 1))
  (let ((my-buffer-list
         (stesla-delete-from-list (stesla-hated-buffers)
                                 (buffer-list (selected-frame)))))
    (switch-to-buffer
     (if (< n 0)
         (nth (+ (length my-buffer-list) n)
              my-buffer-list)
       (bury-buffer)
       (nth n my-buffer-list)))))

 ;; Windows-style C-TAB and C-M-TAB to switch buffers.

 (global-set-key (kbd "C-<tab>") 'stesla-rotate-buffers)
 (global-set-key (kbd "C-M-<tab>") (lambda ()
                                    (interactive)
                                    (stesla-rotate-buffers -1)))

(provide 'mp-ido)
