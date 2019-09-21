
(autoload 'jedi:setup "jedi" nil t)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
g(setq jedi:complete-on-dot t)

;; (autoload 'python-mode "python-mode" "Python Mode." t)
;; (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; (add-to-list 'interpreter-mode-alist '("python" . python-mode))
;; (setq interpreter-mode-alist
;;       (cons '("python" . python-mode)
;; 	    interpreter-mode-alist)
;;       python-mode-hook
;;       '(lambda () (progn
;; 		    (set-variable 'py-indent-offset 4)
;; 		    (set-variable 'py-smart-indentation nil)
;; 		    (set-variable 'indent-tabs-mode nil) 
;; 		    ;;(highlight-beyond-fill-column)
;;                     (define-key python-mode-map "\C-m" 'newline-and-indent)
;; 		    (pabbrev-mode)
;; 		    (abbrev-mode))))
;; 
;; ;; Initialize Pymacs                                                                   ;; ;; ;; ;; ;; ;;                         
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;; Initialize Rope                                                                                             
;(pymacs-load "ropemacs" "rope-")
;(setq ropemacs-enable-autoimport t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                         
;;; Auto-completion                                                                                            
;;;  Integrates:                                                                                               
;;;   1) Rope                                                                                                  
;;;   2) Yasnippet                                                                                             
;;;   all with AutoComplete.el                                                                                 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                         
;; (defun prefix-list-elements (list prefix)
;;   (let (value)
;;     (nreverse
;;      (dolist (element list value)
;;       (setq value (cons (format "%s%s" prefix element) value))))))
;; (defvar ac-source-rope
;;   '((candidates
;;      . (lambda ()
;;          (prefix-list-elements (rope-completions) ac-target))))
;;   "Source for Rope")
;; (defun ac-python-find ()
;;   "Python `ac-find-function'."
;;   (require 'thingatpt)
;;   (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
;;     (if (null symbol)
;;         (if (string= "." (buffer-substring (- (point) 1) (point)))
;;             (point)
;;           nil)
;;       symbol)))
;; (defun ac-python-candidate ()
;;   "Python `ac-candidates-function'"
;;   (let (candidates)
;;     (dolist (source ac-sources)
;;       (if (symbolp source)
;;           (setq source (symbol-value source)))
;;       (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
;;              (requires (cdr-safe (assq 'requires source)))
;;              cand)
;;         (if (or (null requires)
;;                 (>= (length ac-target) requires))
;;             (setq cand
;;                   (delq nil
;;                         (mapcar (lambda (candidate)
;;                                   (propertize candidate 'source source))
;;                                 (funcall (cdr (assq 'candidates source)))))))
;;         (if (and (> ac-limit 1)
;;                  (> (length cand) ac-limit))
;;             (setcdr (nthcdr (1- ac-limit) cand) nil))
;;         (setq candidates (append candidates cand))))
;;     (delete-dups candidates)))
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;                  (auto-complete-mode 1)
;;                  (set (make-local-variable 'ac-sources)
;;                       (append ac-sources '(ac-source-rope) '(ac-source-yasnippet)))
;;                  (set (make-local-variable 'ac-find-function) 'ac-python-find)
;;                  (set (make-local-variable 'ac-candidate-function) 'ac-python-candidate;; ;; ;; ;; ;; ;; )
;;                  (set (make-local-variable 'ac-auto-start) nil)))

;; ;;Ryan's python specific tab completion                                                                        
;; (defun ryan-python-tab ()
;;   ; Try the following:                                                                 ;; ;;                         
;;   ; 1) Do a yasnippet expansion                                                                                
;;   ; 2) Do a Rope code completion                                                                               
  ; 3) Do an indent                                                                                            
;;   (interactive)
;;   (if (eql (ac-start) 0)
;;       (indent-for-tab-command)))
;; 
;; (defadvice ac-start (before advice-turn-on-auto-start activate)
;;   (set (make-local-variable 'ac-auto-start) t))
;; (defadvice ac-cleanup (after advice-turn-off-auto-start activate)
;;   (set (make-local-variable 'ac-auto-start) nil))
;; 
;; (define-key python-mode-map "\t" 'ryan-python-tab)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                         
;;; End Auto Completion                                                                                        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;; Python + auto-completion
;(require 'smart-operator)
;; ;; Auto Syntax Error Hightlight
;; (when (load "flymake" t)
;;   (defun flymake-pyflakes-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;; 		       'flymake-create-temp-inplace))
;; 	   (local-file (file-relative-name
;; 			temp-file
;; 			(file-name-directory buffer-file-name))))
;;       (list "pyflakes" (list local-file))))
;;   (add-to-list 'flymake-allowed-file-name-masks
;; 	       '("\\.py\\'" flymake-pyflakes-init)))
;; (add-hook 'find-file-hook 'flymake-find-file-hook)
;; 
;; 
;; ;(setq ipython-command "/usr/bin/ipython")
;; ;(require 'ipython)
;; ;(setq py-python-command-args '("-colors" "LightBG"))
;; ;(define-key py-mode-map "C-c !" 'py-shell)
;; 

(provide 'my-python)
