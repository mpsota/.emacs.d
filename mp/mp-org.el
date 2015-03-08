;;;; Org-mode settings

;; default mode
;(add-to-list 'load-path (expand-file-name "~/.svn/org-mode/lisp"))
(setq default-major-mode 'org-mode)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(global-font-lock-mode 1)
(setq org-completion-use-ido t)
(add-hook 'org-load-hook
  (lambda ()
    (define-key org-mode-map [(control tab)] 'swbuff-switch-to-next-buffer)
    (define-key org-mode-map [tab] 'org-cycle)
))

;; Line wrapping
(setq org-startup-truncated nil)

;; Select with shift
;(setq org-support-shift-select t)

(require 'org-install)

(define-key mode-specific-map [?a] 'org-agenda)

(eval-after-load "org"
  '(progn
     (define-prefix-command 'org-todo-state-map)
     (define-key org-mode-map "\C-cx" 'org-todo-state-map)
     (define-key org-todo-state-map "x"
       #'(lambda nil (interactive) (org-todo "CANCELLED")))
     (define-key org-todo-state-map "d"
       #'(lambda nil (interactive) (org-todo "DONE")))
     (define-key org-todo-state-map "f"
       #'(lambda nil (interactive) (org-todo "DEFERRED")))
     (define-key org-todo-state-map "l"
       #'(lambda nil (interactive) (org-todo "DELEGATED")))
     (define-key org-todo-state-map "s"
       #'(lambda nil (interactive) (org-todo "STARTED")))
     (define-key org-todo-state-map "w"
       #'(lambda nil (interactive) (org-todo "WAITING")))
     ;; (define-key org-agenda-mode-map "\C-n" 'next-line)
     ;; (define-key org-agenda-keymap "\C-n" 'next-line)
     ;; (define-key org-agenda-mode-map "\C-p" 'previous-line)
     ;; (define-key org-agenda-keymap "\C-p" 'previous-line)))
     ))

(require 'remember)


(add-hook 'remember-mode-hook 'org-remember-apply-template)

(define-key global-map (kbd "C-M-r") 'remember)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ac-sources (quote (ac-source-yasnippet ac-source-imenu ac-source-abbrev ac-source-words-in-buffer ac-source-files-in-current-dir ac-source-filename)) t)
 '(column-number-mode t)
 '(display-time-mode t)
 '(org-agenda-custom-commands (quote (("d" todo "DELEGATED" nil) ("c" todo "DONE|DEFERRED|CANCELLED" nil) ("w" todo "WAITING" nil) ("W" agenda "" ((org-agenda-ndays 21))) ("A" agenda "" ((org-agenda-skip-function (lambda nil (org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]"))) (org-agenda-ndays 1) (org-agenda-overriding-header "Today's Priority #A tasks: "))) ("u" alltodo "" ((org-agenda-skip-function (lambda nil (org-agenda-skip-entry-if (quote scheduled) (quote deadline) (quote regexp) "<[^>
]+>"))) (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
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
 '(org-remember-templates (quote ((116 "* TODO %?
  %u" "~/todo.org" "Tasks") (110 "* %u %?" "~/notes.org" "Notes"))))
 '(org-reverse-note-order t)
 '(remember-annotation-functions (quote (org-remember-annotation)))
 '(remember-handler-functions (quote (org-remember-handler)))
 '(show-paren-mode t))



;; open Org-mode file unfold
;; TODO feature request, keep the file as it was when visited last time
(setq org-startup-folded "unfold")

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ac-sources (quote (ac-source-yasnippet ac-source-imenu ac-source-abbrev ac-source-words-in-buffer ac-source-files-in-current-dir ac-source-filename)) t)
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
 '(org-agenda-custom-commands (quote (("d" todo "DELEGATED" nil) ("c" todo "DONE|DEFERRED|CANCELLED" nil) ("w" todo "WAITING" nil) ("W" agenda "" ((org-agenda-ndays 21))) ("A" agenda "" ((org-agenda-skip-function (lambda nil (org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]"))) (org-agenda-ndays 1) (org-agenda-overriding-header "Today's Priority #A tasks: "))) ("u" alltodo "" ((org-agenda-skip-function (lambda nil (org-agenda-skip-entry-if (quote scheduled) (quote deadline) (quote regexp) "<[^>
]+>"))) (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
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
 '(org-remember-templates (quote ((116 "* TODO %?
  %u" "~/todo.org" "Tasks") (110 "* %u %?" "~/notes.org" "Notes"))))
 '(org-reverse-note-order t)
 '(remember-annotation-functions (quote (org-remember-annotation)))
 '(remember-handler-functions (quote (org-remember-handler)))
 '(show-paren-mode t))



;(unless (boundp 'org-export-latex-classes)
;  (setq org-export-latex-classes nil))

(eval-after-load 'org-export-latex
'(progn (add-to-list 'org-export-latex-classes
             `("aghdpl" "\\documentclass{aghdpl}"
               ("\\part{%s}" . "\\part*{%s}")
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
(add-to-list 'org-export-latex-classes
	     '("my-report" "\\documentclass[11pt]{report}" 
	       ;("\\part{%s}" . "\\part*{%s}") 
	       ("\\chapter{%s}" . "\\chapter*{%s}") 
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       

))))
(setq org-export-latex-title-command "ble")
  
             
             ;  
             ;  ))



 ;("aghdpl" "\\documentclass{aghdpl}" ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}") ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
 ;("article" "\\documentclass[11pt]{article}" ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}") ("\\paragraph{%s}" . "\\paragraph*{%s}") ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
 ;("report" "\\documentclass[11pt]{report}" ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}") ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
 ;("book" "\\documentclass[11pt]{book}" ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}") ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
 ;("beamer" "\\documentclass{beamer}" org-beamer-sectioning))

;;presentation - beamer:
; Make babel results blocks lowercase
(setq org-babel-results-keyword "results")

(defun bh/display-inline-images ()
  (condition-case nil
      (org-display-inline-images)
    (error nil)))

(org-babel-do-load-languages
 (quote org-babel-load-languages)
 (quote ((emacs-lisp . t)
         (dot . t)
         (ditaa . t)
         (R . t)
         (python . t)
         (ruby . t)
         (gnuplot . t)
         (clojure . t)
         (sh . t)
         (ledger . t)
         (org . t)
         (plantuml . t)
         (latex . t))))

; Do not prompt to confirm evaluation
; This may be dangerous - make sure you understand the consequences
; of setting this -- see the docstring for details
(setq org-confirm-babel-evaluate nil)

; Use fundamental mode when editing plantuml blocks with C-c '
(add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))

(setq org-export-latex-listings 'minted)
(setq org-export-latex-custom-lang-environments
      '(
	(emacs-lisp "common-lispcode")
	))
(setq org-export-latex-minted-options
      '(("frame" "lines")
	("fontsize" "\\scriptsize")
	("linenos" "")))
(setq org-latex-to-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
	"pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
	"pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(setq org-todo-keywords
       '((sequence "TODO" "STARTED" "FIXME" "IMPROVE" "VERIFY" "|" "DONE" )))

(setq org-todo-keyword-faces
           '(("TODO" . org-warning) ("STARTED" . "yellow")))

(defun org-mode-reftex-setup ()
  (load-library "reftex")
  ;(and (buffer-file-name)
;	     (file-exists-p (buffer-file-name))
;	     (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation))

(add-hook 'org-mode-hook 'org-mode-reftex-setup)
;(LaTeX-command "latex -shell-escape")
(eval-after-load "tex" 
  '(setcdr (assoc "LaTeX" TeX-command-list)
          '("%`%l%(mode) -shell-escape%' %t"
          TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")
    )
  )

(defun TeX-toggle-escape nil (interactive)
  (setq LaTeX-command
        (if (string= LaTeX-command "latex") "latex -shell-escape" "latex")))

(add-hook 'LaTeX-mode-hook
          '(lambda ()
             (define-key LaTeX-mode-map "\C-c\C-t\C-x" 'TeX-toggle-escape)))

(setq org-export-latex-listings 'minted
      org-export-latex-minted-options
      '(("frame" "lines")
        ("fontsize" "\\scriptsize")
        ("linenos" "false")))

(setq org-export-latex-hyperref-format "\\ref{%s}")
(setq org-latex-default-figure-position "!htb")
;;; use org-bullets, bullets as UTF-8 characters
;; (require 'org-bullets)
;; (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(unless (boundp 'org-latex-classes)
  (setq org-latex-classes '()))

(add-to-list 'org-latex-classes
             '("mp-report" "\\documentclass[12pt]{report}"
               ("\\chapter{%s}" . "\\chapter*{%s}")
 	       ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

;(setq org-latex-pdf-process (quote ("texi2dvi --pdf --clean --verbose
;--batch %f" "bibtex %b" "texi2dvi --pdf --clean --verbose --batch %f"
;"texi2dvi --pdf --clean --verbose --batch %f")))

(provide 'mp-org)
