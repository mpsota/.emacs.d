;;;;
;;;; html
;;;;

;; (require 'zencoding-mode)
(defun --setup-simplezen ()
  (require 'simplezen)
  (set (make-local-variable 'yas-fallback-behavior)
       '(apply simplezen-expand-or-indent-for-tab)))

(add-hook 'sgml-mode-hook '--setup-simplezen)
;; (add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes

(add-to-list 'auto-mode-alist '("\\.tmpl$" . html-mode))

(provide 'mp-html)
