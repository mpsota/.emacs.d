;(require 'init-auto-complete)
;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-files")
(require 'auto-complete)
(require 'auto-complete-config)

(ac-config-default)

(defun slime-ac-hook () ;; not used for now
  (require 'ac-slime)
  (add-hook 'slime-mode-hook 'set-up-slime-ac)
  (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
  (define-globalized-minor-mode real-global-auto-complete-mode
    auto-complete-mode (lambda ()
                         (if (not (minibufferp (current-buffer)))
                             (auto-complete-mode 1))))
  (real-global-auto-complete-mode t)
  (when (require 'auto-complete-config nil 'noerror)
    (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
    (setq ac-comphist-file  "~/.emacs.d/ac-comphist.dat")
    (ac-config-default))
  )
(provide 'mp-ac)

;;  (require 'yasnippet)
;;  (yas-global-mode 1)

;;  (add-to-list 'achead:include-directories "/usr/include/c++/4.8")
;;  (add-to-list 'achead:include-directories "/usr/include/x86_64-linux-gnu/c++/4.8")
;;  (add-to-list 'achead:include-directories "/usr/include/c++/4.8/backward")
;;  (add-to-list 'achead:include-directories "/usr/lib/gcc/x86_64-linux-gnu/4.8/include")
;;  (add-to-list 'achead:include-directories "/usr/local/include")
;;  (add-to-list 'achead:include-directories "/usr/lib/gcc/x86_64-linux-gnu/4.8/include-fixed")
;;  (add-to-list 'achead:include-directories "/usr/include/x86_64-linux-gnu")
;;  (add-to-list 'achead:include-directories "/usr/include")
;;
;;  )
