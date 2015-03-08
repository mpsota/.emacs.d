;https://github.com/magnars/.emacs.d/blob/master/setup-slime-js.el
;(push "~/.emacs.d/js2/" load-path)
(push "~/.emacs.d/slime-js/" load-path)
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(require 'setup-slime-js)

(global-set-key [f5] 'slime-js-reload)
(add-hook 'js2-mode-hook
          (lambda ()
            (slime-js-minor-mode 1)))

(add-hook 'css-mode-hook
          (lambda ()
            (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)
            (define-key css-mode-map "\C-c\C-r" 'slime-js-embed-css)))

(add-hook 'after-init-hook
	  #'(lambda ()
	      (when (locate-library "slime-js")
		(require 'setup-slime-js))))

(add-hook 'css-mode-hook
          (lambda ()
            (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)
            (define-key css-mode-map "\C-c\C-r" 'slime-js-embed-css)))

(setf slime-js-target-url "http://localhost:8080")
;(slime-setup '(slime-js slime-repl))
;(setq slime-complete-symbol-function 'slime-simple-complete-symbol) 
(provide 'mp-js)
