(require 'cl)
(require 'recentf)
(setq recentf-auto-cleanup 'never) ; for TRAMP - never re-check file list for cleanup
(recentf-mode 1)
(setq recentf-max-saved-items 50)
(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let* ((file-assoc-list
	  (mapcar (lambda (x)
		    (cons (file-name-nondirectory x)
			  x))
		  recentf-list))
         (filename-list-no-duplicates
	  (remove-duplicates file-assoc-list
			     :test #'string= :key #'cdr))
	 (filename-list
	  (remove-duplicates (mapcar #'car file-assoc-list)
			     :test #'string=))
	 (filename (ido-completing-read "Choose recent file: "
					filename-list
					nil
					t)))
    (when filename
      (find-file (cdr (assoc filename
			     file-assoc-list))))))

(global-set-key "\C-x\C-r" 'recentf-ido-find-file)

(provide 'mp-recent)
