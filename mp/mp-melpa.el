;(require 'package)
                                        ;(require 'melpa)
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;(list-packages)
(unless package-archive-contents
  (package-refresh-contents))

(defvar *used-packages* '(auto-complete clojure-mode color-theme dash ess fuzzy graphviz-dot-mode js2-mode js2-refactor magit multiple-cursors org org-bullets pastebin
                                        popup s smart-compile tabbar w3m yasnippet auto-complete-c-headers slime scpaste helm iedit better-registers web-mode restclient imenu-anywhere projectile flycheck nix-mode nixos-options ))

;; check if the packages is installed; if not, install it.
(mapc (lambda (package)
        (or (package-installed-p package)
            (when t ;(y-or-n-p (format "Package %s is missing. Install it? " package))
              (package-install package))))
      *used-packages*)

(provide 'mp-melpa)
