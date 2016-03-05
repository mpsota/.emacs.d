;;;; Emacs config file
;;;; Author: Michał Psota <michal@lisp.pl>
;;;; URL: http://github.com/mpsota

;; (setq debug-on-error nil)
(push "~/.emacs.d/mp/" load-path)
(push "~/.emacs.d/packages-not-in-melpa/" load-path)
(require 'mp-melpa)
(require 'mp-settings)
(require 'mp-recent)
;; (setq initial-buffer-choice "~/todo.org")

;; (add-to-list 'load-path "~/.emacs.d/color-theme/")
;; (require 'color-theme)
;; (color-theme-initialize)
; (require 'uniquify)
;(setq uniquify-buffer-name-style 'post-forward
;      uniquify-separator ":")
(require 'mp-colors)
(faces-x)
(setq ispell-dictionary "american")
;;;;
(require 'mp-ido)
(require 'tabbar-init)
(autoload 'tabbar-mode "tabbar" "tabbar mode." t)
;;; (require 'smart-compile)
;;; (setq compilation-ask-about-save nil
;;;       compilation-window-height 15)
(require 'mp-shell)
(require 'mp-slime)
;; (require 'mp-sly)
;;(require 'fuzzy)

;; (defun c-c++-ac-mode ()
;(require 'mp-ac) ;auto-complete mode
;(require 'mp-yasnippet)
;(require 'mp-cedet)
;; )
;; Auto complete just for C&C++
;;(add-hook 'c++-mode-hook #'c-c++-ac-mode)
;;(add-hook 'c-mode-hook #'c-c++-ac-mode)

;; Edit multiple regions in the same way simultaneously.
(require 'iedit) ;; C-;

;; (require 'undo-tree)
;; (global-undo-tree-mode)
;;(require 'ergo-movement-mode)
;;(ergo-movement-mode 1)
(require 'mp-w3m)
(require 'mp-org)
;; (require 'mp-js)
(require 'mp-html)
(require 'mp-web)
;; (require 'mp-clojure)
;; (require 'mp-php)
;; (require 'mp-erlang)
(require 'mp-python)

(require 'mp-c-c++)
;; (require 'mp-erc)
(require 'paste2)
(require 'light-symbol)
(light-symbol-mode t)

(require 'ess-site)
(require 'ess-eldoc)
;;(require 'auto-complete)

(require 'graphviz-dot-mode)
(setq max-specpdl-size 60000)
(setq max-lisp-eval-depth 10000)
(setq-default fill-column 110)
(add-hook 'org-mode-hook '(lambda ()
                            (auto-fill-mode 1)))
(require 'magit)
(require 'binview)
(require 'mp-utilities)
;; (require 'mp-haskell)

(dotfile .emacs "./.emacs.d/init.el")

(when (file-exists-p "~/.emacs.d/mp/mp-private.el")
  (require 'mp-private))

;;; EOF
(setq display-time-24hr-format t)
(display-time)
(setq ediff-diff-options "-w")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-sources
   (quote
    (ac-source-yasnippet ac-source-imenu ac-source-abbrev ac-source-words-in-buffer ac-source-files-in-current-dir ac-source-filename)) t)
 '(better-registers-use-C-r nil)
 '(column-number-mode t)
 '(display-time-mode t)
 '(erc-generate-log-file-name-function (quote erc-generate-log-file-name-long))
 '(erc-insert-timestamp-function (quote erc-insert-timestamp-left))
 '(erc-log-channels-directory "~/.erc-logs")
 '(erc-log-mode t)
 '(erc-log-write-after-send t)
 '(erc-part-reason (quote erc-part-reason-normal))
 '(erc-save-buffer-on-part t)
 '(erc-timestamp-format "[%H:%M:%S] ")
 '(erc-timestamp-format-left "[%a %b %e %Y]")
 '(erc-timestamp-format-right nil)
 '(org-agenda-custom-commands
   (quote
    (("d" todo "DELEGATED" nil)
     ("c" todo "DONE|DEFERRED|CANCELLED" nil)
     ("w" todo "WAITING" nil)
     ("W" agenda ""
      ((org-agenda-ndays 21)))
     ("A" agenda ""
      ((org-agenda-skip-function
        (lambda nil
          (org-agenda-skip-entry-if
           (quote notregexp)
           "\\=.*\\[#A\\]")))
       (org-agenda-ndays 1)
       (org-agenda-overriding-header "Today's Priority #A tasks: ")))
     ("u" alltodo ""
      ((org-agenda-skip-function
        (lambda nil
          (org-agenda-skip-entry-if
           (quote scheduled)
           (quote deadline)
           (quote regexp)
           "<[^>
]+>")))
       (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
 '(org-agenda-files (quote ("~/todo.org")))
 '(org-agenda-ndays 7)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-deadline-warning-days 14)
 '(org-default-notes-file "~/notes.org")
 '(org-fast-tag-selection-single-key (quote expert))
 '(org-remember-store-without-prompt t)
 '(org-remember-templates
   (quote
    ((116 "* TODO %?
  %u" "~/todo.org" "Tasks")
     (110 "* %u %?" "~/notes.org" "Notes"))))
 '(org-reverse-note-order t)
 '(remember-annotation-functions (quote (org-remember-annotation)))
 '(remember-handler-functions (quote (org-remember-handler)))
 '(safe-local-variable-values
   (quote
    ((eval progn
           (unless
               (boundp
                (quote org-latex-classes))
             (setq org-latex-classes
                   (quote nil)))
           (add-to-list
            (quote org-latex-classes)
            (quote
             ("mp-report" "\\documentclass[12pt]{report}"
              ("\\chapter{%s}" . "\\chapter*{%s}")
              ("\\section{%s}" . "\\section*{%s}")
              ("\\subsection{%s}" . "\\subsection*{%s}")
              ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))))
     (eval put
           (quote defclass*)
           (quote common-lisp-indent-function)
           (quote
            (4 &lambda &body)))
     (Package . CCL)
     (Package . CL-FAD)
     (eval put
           (quote debug)
           (quote common-lisp-indent-function)
           0)
     (eval put
           (quote deftype*)
           (quote common-lisp-indent-function)
           (quote
            (4 &lambda &body)))
     (eval put
           (quote defun*)
           (quote common-lisp-indent-function)
           (quote
            (4 &lambda &body)))
     (eval put
           (quote defstruct*)
           (quote common-lisp-indent-function)
           (quote
            ((&whole 4 &rest
                     (&whole 2 &rest 1))
             &rest
             (&whole 2 &rest 1))))
     (eval put
           (quote defstatic*)
           (quote common-lisp-indent-function)
           (quote
            (4 2 2)))
     (eval put
           (quote defshared*)
           (quote common-lisp-indent-function)
           (quote
            (4 2 2)))
     (eval put
           (quote defvar*)
           (quote common-lisp-indent-function)
           (quote
            (4 2 2)))
     (Package . GLISP)
     (Package . LALR)
     (Package . SGML)
     (Syntax . Common-Lisp)
     (Package . CL-USER)
     (Package . HUNCHENTOOT)
     (Syntax . COMMON-LISP)
     (Base . 10)
     (Syntax . ANSI-Common-Lisp))))
 '(show-paren-mode t))
(require 'better-registers)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "wheat" :background "black" :family "Bitstream Vera Sans Mono" :foundry "bitstream" :slant normal :weight normal :height 98 :width normal))))
 '(flyspell-duplicate ((t (:foreground "Gold3" :underline t :weight normal))))
 '(flyspell-incorrect ((t (:foreground "OrangeRed" :underline t :weight normal))))
 '(font-lock-comment-face ((t (:foreground "SteelBlue1"))))
 '(font-lock-function-name-face ((t (:foreground "gold"))))
 '(font-lock-keyword-face ((t (:foreground "springgreen"))))
 '(font-lock-type-face ((t (:foreground "PaleGreen"))))
 '(font-lock-variable-name-face ((t (:foreground "Coral"))))
 '(font-lock-warning-face ((t (:foreground "#FF0000" :bold t))))
 '(menu ((((type x-toolkit)) (:background "light slate gray" :foreground "wheat" :box (:line-width 2 :color "grey75" :style released-button)))))
 '(mode-line ((t (:foreground "black" :background "light slate gray"))))
 '(tool-bar ((((type x w32 mac) (class color)) (:background "light slate gray" :foreground "wheat" :box (:line-width 1 :style released-button))))))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(font-lock-add-keywords
 'c++-mode
 '(("^[^\n]\\{80\\}\\(.*\\)$"
    1 font-lock-warning-face prepend)))
