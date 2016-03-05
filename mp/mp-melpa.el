;(require 'package)
;(require 'melpa)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")))
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)
;(list-packages)
; (when (not package-archive-contents) (package-refresh-contents))

(defvar *used-packages* '(auto-complete clojure-mode color-theme dash ess fuzzy graphviz-dot-mode js2-mode js2-refactor magit multiple-cursors org org-bullets pastebin
                                        popup s smart-compile tabbar undo-tree w3m yasnippet auto-complete-c-headers slime scpaste helm iedit better-registers web-mode))

;; check if the packages is installed; if not, install it.
(mapc (lambda (package)
       (or (package-installed-p package)
          (when (y-or-n-p (format "Package %s is missing. Install it? " package))
             (package-install package))))
 *used-packages*)

(provide 'mp-melpa)
