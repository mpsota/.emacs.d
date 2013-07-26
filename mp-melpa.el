;(require 'package)
;(require 'melpa)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ;; ("marmalade" . "http://marmalade-repo.org/packages/")
                         ))
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)
;(list-packages)
; (when (not package-archive-contents) (package-refresh-contents))

(defvar *used-packages* '(magit))

;; check if the packages is installed; if not, install it.
;(mapc (lambda (package)
 ;       (or (package-installed-p package)
  ;          (when (y-or-n-p (format "Package %s is missing. Install it? " package)) 
   ;             (package-install package))))
; *used-packages*)

(provide 'mp-melpa)
