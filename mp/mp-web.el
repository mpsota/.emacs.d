(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

(add-hook 'web-mode-hook (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2) ;;CSS offset indentation
(setq web-mode-code-indent-offset 2) ;; Script/code offset indentation (for JavaScript, Java, PHP, Ruby, VBScript, Python, etc.)
(setq web-mode-enable-current-element-highlight t)
;; (local-set-key (kbd "RET") 'newline-and-indent)
(provide 'mp-web)
