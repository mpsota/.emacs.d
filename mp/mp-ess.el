
;;; ESS for emacs
;;
;; default.el in Vincent Goulet's distribution
;; https://svn.fsg.ulaval.ca/svn-pub/vgoulet/emacs-modified/macos/tags/Emacs-23.3-modified-3/default.el
;; Load ESS and activate the nifty feature showing function arguments
;; in the minibuffer until the call is closed with ')'.
;(require 'ess-site)
;(require 'ess-eldoc)            ; Slows cursor movements slightly?
;; Following the "source is real" philosophy put forward by ESS, one
;; should not need the command history and should not save the
;; workspace at the end of an R session. Hence, both options are
;; disabled here.
(setq-default inferior-R-args "--no-restore-history --no-save ")
;;
;; Set code indentation following the standard in R sources.
;; http://ess.r-project.org/Manual/ess.html#Indenting
;; https://svn.r-project.org/ESS/trunk/lisp/ess-custom.el
;; ESS provides: DEFAULT, OWN, GNU, BSD, K&R, C++, RRR, CLB.
;;                                 DEF GNU BSD K&R C++ RRR CLB
;; ess-indent-level                  2   2   8   5   4   4   2
;; ess-continued-statement-offset    2   2   8   5   4   4   4
;; ess-brace-offset                  0   0  -8  -5  -4   0   0
;; ess-arg-function-offset           2   4   0   0   0   4   0
;; ess-expression-offset             4   2   8   5   4   4   4
;; ess-else-offset                   0   0   0   0   0   0   0
;; ess-close-brace-offset            0   0   0   0   0   0   2
;;(setq ess-default-style 'C++) ; Vincent's recommendation
(setq ess-default-style 'RRR)   ; Common R chosen
;;
;; Automagically delete trailing whitespace when saving R script
;; files. One can add other commands in the ess-mode-hook below.
;; (add-hook 'ess-mode-hook                     ; Turned off 2012-10-20
;;    '(lambda()
;;       (add-hook 'write-file-functions
;;             (lambda ()
;;                          (ess-nuke-trailing-whitespace)))
;;       (setq ess-nuke-trailing-whitespace-p t)))
;;
;; Key assignment for delete trailing whitespace            ; M-p to nuke trailing whitespace
(add-hook 'ess-mode-hook (setq ess-nuke-trailing-whitespace-p t))
(define-key ess-mode-map (kbd "M-p") 'ess-nuke-trailing-whitespace)
;;
;; Underscore preservation in ESS
;; http://www.r-bloggers.com/a-small-customization-of-ess/
(setq ess-S-assign-key (kbd "C-="))
(ess-toggle-S-assign-key t)     ; enable above key definition
;; leave my underscore key alone!
(ess-toggle-underscore nil)
;;
;; Smart TAB completion in R and S scripts, similarly to iESS behavior. ; Since 12.04
(setq ess-tab-complete-in-script t)
(setq ess-first-tab-never-complete t)
;; http://ergoemacs.org/emacs/reclaim_keybindings.html
;; (define-key ess-mode-map (kbd "<tab>")     'ess-complete-object-name)
;; (define-key ess-mode-map (kbd "<backtab>") 'comint-dynamic-complete-filename)    ; This does not work.
;;
;; Must-haves for ESS
;; http://www.emacswiki.org/emacs/CategoryESS
;; (setq ess-eval-visibly-p t)      ; slow
(setq ess-eval-visibly-p nil)   ; fast
;; Otherwise C-c C-r (eval region) takes forever
;; It causes commands to be invisible, and leaves junk like + + + > > >
;; Fix http://old.nabble.com/cat-a-%22%5Cn%22-when-ess-eval-visibly-p-is-nil--td32684429.html
(setq ess-ask-for-ess-directory nil)
;;  otherwise you are prompted each time you start an interactive R session
;;
;; (require 'ess-eldoc) ;; to show function arguments while you are typing them ;; Vincent's default.el
;;
;; Auto-scrolling of R console to bottom and Shift key extension
;; http://www.kieranhealy.org/blog/archives/2009/10/12/make-shift-enter-do-a-lot-in-ess/
;; Adapted with one minor change from Felipe Salazar at
;; http://www.emacswiki.org/emacs/EmacsSpeaksStatistics
;; (setq ess-ask-for-ess-directory nil)         ; Stated above
(setq ess-local-process-name "R")
(setq ansi-color-for-comint-mode 'filter)
(setq comint-prompt-read-only t)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)
;;
(defun my-ess-start-R ()
  (interactive)
  (if (not (member "*R*" (mapcar (function buffer-name) (buffer-list))))
      (progn
        (delete-other-windows)
        (setq w1 (selected-window))
        (setq w1name (buffer-name))
        (setq w2 (split-window w1 nil t))
        (R)
        (set-window-buffer w1 "*R*")    ; R on the left
        (set-window-buffer w2 w1name))))
;;        (set-window-buffer w2 "*R*")
;;        (set-window-buffer w1 w1name))))
(defun my-ess-eval ()
  (interactive)
  (my-ess-start-R)
  (if (and transient-mark-mode mark-active)
      (call-interactively 'ess-eval-region)
    (call-interactively 'ess-eval-line-and-step)))
;;
(add-hook 'ess-mode-hook
          '(lambda()
             (local-set-key [(shift return)] 'my-ess-eval)))
(add-hook 'inferior-ess-mode-hook
          '(lambda()
             (local-set-key [C-up] 'comint-previous-input)
             (local-set-key [C-down] 'comint-next-input)))
(add-hook 'Rnw-mode-hook
          '(lambda()
             (local-set-key [(shift return)] 'my-ess-eval)))
;; (require 'ess-site) ;; This is present in the top.
;;
;; ess-R-object-popup.el
;; Replacing R Object Tooltips in ESS (http://www.sigmafield.org/2009/10/01/r-object-tooltips-in-ess/)
;; http://sheephead.homelinux.org/2010/03/02/1807/  ; Official
;; https://gist.github.com/318365           ; git
(require 'ess-R-object-popup)           ; Not compatible with ess 12.09? No ESS process error
;;


;;
;; *.r.txt and *.R.txt files activate r-mode            ; Obsolete. Just set TextEdit.app for .R in Finder
;; Maybe useful for result files, open with ESS (emacs) or TextEdit.app (GUI) automatically
;; (setq auto-mode-alist
;;       (cons '("\\.r\\.txt$" . r-mode) auto-mode-alist))
;; (setq auto-mode-alist
;;       (cons '("\\.R\\.txt$" . r-mode) auto-mode-alist))
;;
;; ess-trace-bug.el                     ; filtering ++++ > ??? Not working
;; http://code.google.com/p/ess-tracebug/
(require 'ess-tracebug)
;; (setq ess-use-tracebug t)                    ; permanent activation
(setq ess-tracebug-prefix "\M-t")               ; activate with M-t
;;
;; ESS: highlighting lines that are too long            ; disabled for R Markdown
;; http://emacs-fu.blogspot.jp/2008/12/highlighting-lines-that-are-too-long.html
;; (add-hook 'ess-mode-hook
;;   (lambda ()
;;     (font-lock-add-keywords nil
;;       '(("^[^\n]\\{80\\}\\(.*\\)$" 1 font-lock-warning-face t)))))
;;
;; knitr support                        ; Hacked on 2012-07-02 by K
;; http://sjp.co.nz/posts/emacs-ess-knitr/
;; http://constantmindmapping.wordpress.com/2012/06/12/knitr-and-emacs/
(require 'ess-knitr)
;; Hack shown below added to ess-knitr.el
;; Hack by Kazuki Yoshida on 2012-07-02
;; (defun ess-knit2html ()
;;   "Run knit2html R function on the current .Rmd file"
;;   (interactive)
;;   (ess-swv-run-in-R "require(knitr) ; require(markdown) ; knit2html"))
;; Hack ends here
;;
;; *.Rmd files invoke r-mode                    ; Temporary fix for R markdown files
(setq auto-mode-alist
      (cons '("\\.Rmd$" . r-mode) auto-mode-alist))

(require 'icicles)
(icy-mode 1)
