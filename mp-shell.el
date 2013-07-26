;;super shell
  (defun my-shell ()
    "Run an inferior shell in the current directory.
  set name to that of this directory.
  If buffer exists but shell process is not running, make new shell.
  \(Type \\[describe-mode] in the shell buffer for a list of commands.)"
    (interactive)
    (require 'shell)
    (let (shell-buffer
  	  comint-name
  	  (pop-up-windows t))		; so that it is in another window
  
      ;; standardize the shell name (fix problems from locate)
  
      (if (and (>= (length default-directory) 2)
  	       (string= (substring default-directory 0 2) "//"))
  	  (setq default-directory (substring default-directory 1)))
  
      (if (> (length default-directory) (length (getenv "HOME")))
  	  (if (string= (substring default-directory 0 (length (getenv "HOME")))
  		       (getenv "HOME"))
  	      (setq default-directory
  		    (concat "~"
  			    (substring default-directory
  				       (length (getenv "HOME")))))))
  
      ;; put the name shell first for easier lookup
  
      (setq shell-buffer (format "*shell-%s*" default-directory)
  	    comint-name (format "shell-%s" default-directory))
  
      (if (not (comint-check-proc shell-buffer))
  	  (let* ((prog (or explicit-shell-file-name
  			   (getenv "ESHELL")
  			   (getenv "SHELL")
  			   "/bin/sh"))
  		 (name (file-name-nondirectory prog))
  		 (startfile (concat "~/.emacs_" name))
  		 (xargs-name (intern-soft (concat "explicit-" name "-args"))))
  	    (save-excursion
  	      (set-buffer (apply 'make-comint comint-name prog
  				 (if (file-exists-p startfile) startfile)
  				 (if (and xargs-name (boundp xargs-name))
  				     (symbol-value xargs-name)
  				   '("-i"))))
  	      (setq shell-buffer (current-buffer))
  	      (shell-mode))))
  
      (pop-to-buffer shell-buffer)))
 (global-set-key [f10] 'my-shell)

(provide 'mp-shell)
