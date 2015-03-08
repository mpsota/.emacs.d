(require 'cc-mode)

;(defconst my-cc-style
;  '("cc-mode"
;    (c-offsets-alist . ((innamespace . [0])))))

;(c-add-style "my-cc-mode" my-cc-style)

(defun my-c-mode-hook ()
   "Hook for running C file..."
   ;;don't indent braces
   (c-set-offset 'substatement-open 0)
   (c-set-offset 'statement-case-open 0)
   (c-set-offset 'case-label '+)
   (setq tab-width 2)
   (setq c-basic-offset 2)
   (setq c-auto-newline nil)
;  (setq c-indent-comments-syntactically-p t)
   ;; make sure spaces are used instead of tabs
   (setq indent-tabs-mode nil)
   t)

(add-hook 'c-mode-hook 'my-c-mode-hook)

(defun my-c++-mode-hook ()
   "Hook for running C++ file..."
   ;;don't indent braces
   (c-set-offset 'substatement-open 0)
   (c-set-offset 'statement-case-open 0)
   (c-set-offset 'case-label 0)
   (setq tab-width 2)
   (setq c-basic-offset 2)
   (setq c-auto-newline nil)
;  (setq c-indent-comments-syntactically-p t)
   ;; make sure spaces are used instead of tabs
   (setq indent-tabs-mode nil)
   (c-set-offset 'innamespace [0])
   t)

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

(provide 'mp-c-c++)
