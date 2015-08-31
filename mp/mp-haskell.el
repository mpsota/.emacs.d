(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

(provide 'mp-haskell)
