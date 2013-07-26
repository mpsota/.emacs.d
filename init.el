;;;; Emacs config file
;;;; Author: Michał Psota <michal@lisp.pl>
;;;; URL: http://github.com/mpsota

(setq debug-on-error t)
(push "~/.emacs.d/" load-path)
(push "~/.emacs.d/packages-not-in-melpa/" load-path)
(require 'mp-melpa)
(require 'mp-settings)
(require 'mp-recent)
;; (setq initial-buffer-choice "~/todo.org")

;; (add-to-list 'load-path "~/.emacs.d/color-theme/")
;; (require 'color-theme)
;; (color-theme-initialize)
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward
      uniquify-separator ":")
(require 'mp-colors)
(faces_x)

(require 'mp-ido)
(require 'tabbar-init)
(autoload 'tabbar-mode "tabbar" "tabbar mode." t)
(require 'smart-compile)
(setq compilation-ask-about-save nil
      compilation-window-height 15)
(require 'mp-shell)
(require 'mp-slime) 
(require 'fuzzy)
;popmenu
;; (require 'mp-ac) ;auto-complete mode

;; (require 'undo-tree)
;; (global-undo-tree-mode)
(require 'ergo-movement-mode)
(ergo-movement-mode 1)
(require 'mp-w3m)
(require 'mp-org)
(require 'mp-js)
;; (require 'mp-clojure)
;; (require 'mp-php)
;; (require 'mp-erlang)
;; (require 'mp-python)

(require 'yasnippet) ;; not yasnippet-bundle
;(yas/initialize)
;(yas/load-directory "~/.emacs.d/yasnippet/snippets")

(require 'mp-erc)
(require 'paste2)
(require 'light-symbol)
(light-symbol-mode t)

(require 'ess-site)
(require 'graphviz-dot-mode)
(setq max-specpdl-size 60000)
(setq max-lisp-eval-depth 10000)
(setq-default fill-column 110)
(add-hook 'org-mode-hook '(lambda ()
                            (auto-fill-mode 1)))
(require 'magit)
(require 'magit-svn)
(require 'binview)
(require 'mp-utilities)
(dotfile .emacs "./.emacs.d/init.el")

(when (file-exists-p "mp-private.el")
  (require 'mp-private))

;;; EOF
(setq display-time-24hr-format t)
(display-time)
