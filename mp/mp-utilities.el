(defun un-camelcase-string (s &optional sep start)
  "Convert CamelCase string S to lower case with word separator SEP.
Default for SEP is a hyphen \"-\".

If third argument START is non-nil, convert words after that
index in STRING."
  (interactive)
  (let ((case-fold-search nil))
    (while (string-match "[A-Z]" s (or start 1))
      (setq s (replace-match (concat (or sep "-") 
				     (downcase (match-string 0 s))) 
			     t nil s)))
    (downcase s)))



(defun  un-camelcase-string ()
  "Toggles the symbol at point between C-style naming,
    e.g. `hello_world_string', and camel case,
    e.g. `HelloWorldString'."
  (interactive)
  (let* ((symbol-pos (bounds-of-thing-at-point 'symbol))
	 case-fold-search symbol-at-point cstyle regexp func)
    (unless symbol-pos
      (error "No symbol at point"))
    (save-excursion
      (narrow-to-region (car symbol-pos) (cdr symbol-pos))
      (setq regexp "\\([A-Z]\\)"
	    func (lambda (s)
		     (concat (if (= (match-beginning 1)
				    (car symbol-pos))
				 ""
			       "-")
			     (downcase s))))
      (goto-char (point-min))
      (while (re-search-forward regexp nil t)
	(replace-match (funcall func (match-string 1)) t nil))
      (widen))))

;(defun ble (x)
;  (interactive)
;  (setq frame-title-format x))
;(defun my-set-frame-name ()
;  "Prompt the user for a window title, and set the current frame's title to that string."
;  (interactive)
;  (let ((title (read-string "Enter window title: " "emacs (")))
;    (when (string-match "\\`emacs ([^)]+\\'" title) ; no trailing close-paren
;      (setq title (concat title ")")))
;    (set-frame-name title)))

(defun hexlify-buffer ()
  "Convert a binary buffer to hexl format.
This discards the buffer's undo information."
  (interactive)
  (and (consp buffer-undo-list)
       (setq buffer-undo-list nil))
  ;; Don't decode text in the ASCII part of `hexl' program output.
  (let ((coding-system-for-read 'raw-text)
	(coding-system-for-write buffer-file-coding-system)
	(buffer-undo-list t))
    (apply 'call-process-region (point-min) (point-max)
	   (expand-file-name hexl-program exec-directory)
	   t t nil
           ;; Manually encode the args, otherwise they're encoded using
           ;; coding-system-for-write (i.e. buffer-file-coding-system) which
           ;; may not be what we want (e.g. utf-16 on a non-utf-16 system).
           (mapcar (lambda (s)
                     (if (not (multibyte-string-p s)) s
                       (encode-coding-string s locale-coding-system)))
                   (split-string (hexl-options))))
    (if (> (point) (hexl-address-to-marker hexl-max-address))
	(hexl-goto-address hexl-max-address))))

(defun dehexlify-buffer ()
  "Convert a hexl format buffer to binary.
This discards the buffer's undo information."
  (interactive)
  (and (consp buffer-undo-list)
       (setq buffer-undo-list nil))
  (let ((coding-system-for-write 'raw-text)
	(coding-system-for-read buffer-file-coding-system)
	(buffer-undo-list t))
    (apply 'call-process-region (point-min) (point-max)
	   (expand-file-name hexl-program exec-directory)
	   t t nil "-de" (split-string (hexl-options)))))

(defmacro dotfile (filename &optional path)
  "Define the function `filename' to edit the file in question"
  (let ((path-str (concat "~/" (or path
                                   (symbol-name filename)))))
    `(defun ,filename ()
       (format "Open %s for editing" ,path)
       (interactive)
       (find-file ,path-str))))

(provide 'mp-utilities)
