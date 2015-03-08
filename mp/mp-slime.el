;;;;
;;;; slime
;;;;

;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;(add-to-list 'load-path "~/.software/slime/")
(require 'slime-autoloads)
;(setq inferior-lisp-program "/usr/local/bin/sbcl")
(setq inferior-lisp-program "lw")
(setq slime-contribs '(slime-fancy))

;(setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
(setq slime-lisp-implementations '())
(add-to-list 'slime-lisp-implementations '(ccl ("~/.svn/ccl/lx86cl")))
(add-to-list 'slime-lisp-implementations '(lw ("lw-console")))
(add-to-list 'slime-lisp-implementations '(sbcl ("sbcl")))

;(slime-setup)
;; (slime-setup '(slime-fancy ));;slime-asdf slime-tramp

(defvar *my-server*
 "/ssh:fractal1:")

(defun server-home()
  (interactive)
  (find-file (concat *my-server* "~/")))

(setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)

(add-hook 'slime-connected-hook
          (lambda ()
            ))

;; Common Lisp Mode
(add-to-list 'auto-mode-alist '("\\.lisp$" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.svhd$" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.cl$" . lisp-mode))
 
(make-directory "/tmp/slime-fasls/" t)

(eval-after-load "slime"
  '(progn 
     (setq slime-complete-symbol*-fancy t
	   slime-complete-symbol-function 'slime-fuzzy-complete-symbol
	   slime-when-complete-filename-expand t
	   slime-truncate-lines nil
	   slime-autodoc-use-multiline-p t
	   ;;load fasls
	   slime-load-failed-fasl 'always
	   slime-compile-file-options '(:fasl-directory "/tmp/slime-fasls/"))
     ;(setq lisp-simple-loop-indentation 2
	;   lisp-loop-keyword-indentation 2
         ;  lisp-loop-forms-indentation 2
	 ;  )
     (add-hook 'slime-connected-hook 
	       (lambda () 
		 (define-key slime-repl-mode-map (kbd "C-c ;")
		   'slime-insert-balanced-comments)
		 (define-key slime-repl-mode-map (kbd "C-c M-;")
		   'slime-remove-balanced-comments)
		 (define-key slime-mode-map (kbd "C-c ;")
		   'slime-insert-balanced-comments)
		 (define-key slime-mode-map (kbd "C-c (")
		   'slime-remove-balanced-comments)
		 (define-key slime-mode-map (kbd "C-c C-c")
		   'slime-compile-defun)
		 (define-key slime-mode-map (kbd "TAB")
		   'slime-indent-and-complete-symbol)
		 (define-key slime-mode-map (kbd "^q") 'slime-selector)
		 (define-key slime-repl-mode-map (kbd "^q") 'slime-selector)
		 (define-key slime-mode-map (kbd "<f10>")
		   (lambda () (interactive) (slime-inspect "*")))
		 (define-key slime-mode-map (kbd "<f12>") 'slime-selector)
		 (define-key slime-repl-mode-map (kbd "<f12>") 'slime-selector)
		 (define-key slime-mode-map (kbd "<f6>") 'slime-eval-buffer)
		 (define-key slime-mode-map (kbd "<f7>") 'slime-eval-defun)
		 (define-key slime-mode-map (kbd "C-c h") 'hs-hide-block)
                 (define-key slime-mode-map (kbd "C-c s") 'hs-show-block)
  

		 (define-key slime-mode-map (kbd "RET") 'newline-and-indent)
		 (define-key slime-mode-map (kbd "C-c C-k") 'slime-compile-and-load-file)
		 (global-set-key "\C-c \C-k" 'slime-compile-and-load-file)
		 (define-key slime-mode-map (kbd "C-j") 'newline)
		 ;; trunk on remote machine
		 ;(push (list ".*"
                 ;       (lambda (filename)
                 ;         filename)
                 ;       (lambda (filename)
                 ;         filename))
                 ; slime-filename-translations)
                 ;(push (slime-create-filename-translator :machine-instance "fractal1" ;; good one
                 ;                                        :username "user")
                 ;      slime-filename-translations)
		 ;(push (list "[machine-instance]"
		 ;	     (lambda (filename)
		 ;	       (subseq filename (length *my-server*)))
		 ; 	     (lambda (filename)
		 ;	       (concat *my-box-tramp-path* filename)))
		 ;      slime-filename-translations)
		 ))))

(set-language-environment "UTF-8")
(setq slime-net-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(setq slime-repl-history-remove-duplicates t)
(setq slime-repl-history-trim-whitespaces t)

(defun lw ()
  (interactive)
  (slime 'lw)
  ;(global-log4slime-mode 1)
)

(defun sbcl ()
  (interactive)
  (slime 'sbcl)
  ;(global-log4slime-mode 1)
)

;(load "~/quicklisp/log4slime-setup.el")


; (require 'js-expander)

(provide 'mp-slime)
