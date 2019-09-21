;; https://github.com/magnars/.emacs.d/blob/master/setup-slime-js.el
;; (push "~/.emacs.d/js2/" load-path)
;; to make it work: npm install -g swank-js
;; install npm install -g eslint babel-eslint eslint-plugin-react
;; add ~/.eslinttc -> https://github.com/yannickcr/eslint-plugin-react#user-content-recommended-configuration
(push "~/.emacs.d/slime-js/" load-path)
(require 'tern)
(require 'company-tern)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . js2-mode))
(require 'company)

; (add-hook 'after-init-hook 'global-company-mode)


(eval-after-load 'company
  '(add-to-list 'company-backends 'company-tern))



;; (require 'setup-slime-js)
(setq js2-strict-missing-semi-warning nil)
(setq js2-missing-semi-one-line-override t)
(setq import-js-project-root "/home/spec/end/source-repos/grc/ie-frontend/")

;(global-set-key [f5] 'slime-js-reload)
;(add-hook 'js2-mode-hook
;          (lambda ()
;            (slime-js-minor-mode 1)))

;(add-hook 'css-mode-hook
;          (lambda ()
;            (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)
;            (define-key css-mode-map "\C-c\C-r" 'slime-js-embed-css)))

;(add-hook 'after-init-hook
;	  #'(lambda ()
;	      (when (locate-library "slime-js")
;		(require 'setup-slime-js))))

;(add-hook 'css-mode-hook
;          (lambda ()
;            (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)
;            (define-key css-mode-map "\C-c\C-r" 'slime-js-embed-css)))

;(setf slime-js-target-url "http://localhost:8080")
;(slime-setup '(slime-js slime-repl))
                                        ;(setq slime-complete-symbol-function 'slime-simple-complete-symbol)
(require 'nodejs-repl)
(require 'js-comint)
;; Use node as our repl
(setq inferior-js-program-command "babel-node")
;; (setq inferior-js-program-arguments '("--interactive"))
 (add-hook 'js2-mode-hook '(lambda ()
			    (local-set-key "\C-x\C-e" 'js-send-last-sexp)
			    (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
			    (local-set-key "\C-cb" 'js-send-buffer)
			    (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
			    (local-set-key "\C-cl" 'js-load-file-and-go)
			    ))
(setq inferior-js-mode-hook
      (lambda ()
        ;; We like nice colors
        (ansi-color-for-comint-mode-on)
        ;; Deal with some prompt nonsense
        (add-to-list 'comint-preoutput-filter-functions
                     (lambda (output)
                       (replace-regexp-in-string ".*1G\.\.\..*5G" "..."
                     (replace-regexp-in-string ".*1G.*3G" "&gt;" output))))
(provide 'mp-js)
