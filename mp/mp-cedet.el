(semantic-mode 1)
(global-ede-mode 1)                      ; Enable the Project management system
;(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion
;(global-srecode-minor-mode 1)            ; Enable template insertion menu
(global-semantic-idle-scheduler-mode 1)

(defun add-semantic-to-autocomplete ()
  (add-to-list 'ac-sources 'ac-source-semantic))

(add-hook 'c-mode-common-hook 'add-semantic-to-autocomplete)
(add-hook 'c++-mode-common-hook 'add-semantic-to-autocomplete)


(provide 'mp-cedet)
