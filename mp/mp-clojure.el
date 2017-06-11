(require 'clojure-mode)
;; swank-clojure
; (add-to-list 'load-path "~/opt/swank-clojure/src/emacs")
; (add-to-list 'load-path "~/opt/swank-clojure/")
; (add-to-list 'load-path "~/opt/slime")
;(swank-clojure-config
 (setq swank-clojure-jar-path "~/.clojure/clojure.jar")
(setq swank-clojure-extra-classpaths
      (list "~/.clojure/clojure-contrib.jar"));)
(require 'swank-clojure-autoload)
;; slime
(eval-after-load "slime"
  '(progn (slime-setup '(slime-repl))))

(add-to-list 'load-path "~/opt/slime")
(require 'slime)
(slime-setup)
;; Example for sbcl to put in your .emacs:
(add-to-list 'slime-lisp-implementations '(sbcl ("sbcl")))

;;Java doc
(setq slime-browse-local-javadoc-root "/usr/share/doc/javadoc/")

(defun slime-browse-local-javadoc (ci-name)
  "Browse local JavaDoc documentation on Java class/Interface at point."
  (interactive (list (slime-read-symbol-name "Class/Interface name: ")))
  (when (not ci-name)
    (error "No name given"))
  (let ((name (replace-regexp-in-string "\\$" "." ci-name))
	(path (concat (expand-file-name slime-browse-local-javadoc-root) "/docs/api/")))
    (with-temp-buffer
      (insert-file-contents (concat path "allclasses-noframe.html"))
      (let ((l (delq nil
		     (mapcar #'(lambda (rgx)
				 (let* ((r (concat "\\.?\\(" rgx "[^./]+\\)[^.]*\\.?$"))
					(n (if (string-match r name)
					       (match-string 1 name)
					     name)))
				   (if (re-search-forward (concat "<A HREF=\"\\(.+\\)\" +.*>" n "<.*/A>") nil t)
				       (match-string 1)
				     nil)))
			     '("[^.]+\\." "")))))
	(if l
	    (browse-url (concat "file://" path (car l)))
	  (error (concat "Not found: " ci-name)))))))

(add-hook 'slime-connected-hook #'(lambda ()
				    (define-key slime-mode-map		(kbd "C-c b")	'slime-browse-local-javadoc)
				    (define-key slime-repl-mode-map	(kbd "C-c b")	'slime-browse-local-javadoc)))
(defun slime-java-describe (symbol-name)
  "Get details on Java class/instance at point."
  (interactive (list (slime-read-symbol-name "Java Class/instance: ")))
  (when (not symbol-name)
    (error "No symbol given"))
  (save-excursion
    (set-buffer (slime-output-buffer))
    (unless (eq (current-buffer) (window-buffer))
      (pop-to-buffer (current-buffer) t))
    (goto-char (point-max))
    (insert (concat "(show " symbol-name ")"))
    (when symbol-name
      (slime-repl-return)
      (other-window 1))))


(defun slime-javadoc (symbol-name)
  "Get JavaDoc documentation on Java class at point."
  (interactive (list (slime-read-symbol-name "JavaDoc info for: ")))
  (when (not symbol-name)
    (error "No symbol given"))
  (set-buffer (slime-output-buffer))
  (unless (eq (current-buffer) (window-buffer))
    (pop-to-buffer (current-buffer) t))
  (goto-char (point-max))
  (insert (concat "(javadoc " symbol-name ")"))
  (when symbol-name
    (slime-repl-return)
    (other-window 1)))

(add-hook 'slime-connected-hook (lambda ()
				  (interactive)
				  (slime-redirect-inferior-output)
				  (define-key slime-mode-map (kbd "C-c d") 'slime-java-describe)
				  (define-key slime-repl-mode-map (kbd "C-c d") 'slime-java-describe)
				  (define-key slime-mode-map (kbd "C-c D") 'slime-javadoc)
				  (define-key slime-repl-mode-map (kbd "C-c D") 'slime-javadoc)))


(setf eldoc-mode 1)
(provide 'mp-clojure)
