(defun faces_x ()
  ;; these are used when in X
  (custom-set-faces
   '(default ((t (:foreground "wheat" :background "black"))))
   '(flyspell-duplicate ((t (:foreground "Gold3" :underline t :weight normal))))
   '(flyspell-incorrect ((t (:foreground "OrangeRed" :underline t :weight normal))))
   '(font-lock-comment-face ((t (:foreground "SteelBlue1"))))
   '(font-lock-function-name-face ((t (:foreground "gold"))));"chartreuse1")))))
   '(font-lock-keyword-face ((t (:foreground "springgreen"))))
   '(font-lock-type-face ((t (:foreground "PaleGreen"))))
   '(font-lock-variable-name-face ((t (:foreground "Coral"))))
   '(menu ((((type x-toolkit)) (:background "light slate gray" :foreground "wheat" :box (:line-width 2 :color "grey75" :style released-button)))))
   '(mode-line ((t (:foreground "black" :background "light slate gray"))));4f3f3
   '(tool-bar ((((type x w32 mac) (class color)) (:background "light slate gray" :foreground "wheat" :box (:line-width 1 :style released-button)))))
'(font-lock-warning-face ((t (:foreground "#FF0000" :bold t)))))
  (set-cursor-color "deep sky blue")
  (set-foreground-color "wheat")
  (set-background-color "black")
  (set-face-foreground 'default "wheat")
  (set-face-background 'default "black"))

(defun spring-colors()
  (interactive)
  (color-theme-install
   '(spring-colors
      ((background-color . "#ffe772")
      (background-mode . light)
      (border-color . "#ffa833")
      (cursor-color . "#00b326")
      (foreground-color . "#000000")
      (mouse-color . "black"))
     (fringe ((t (:background "#ffa833"))))
     (mode-line ((t (:foreground "#ffffff" :background "#84df3a"))))
     (region ((t (:background "#ffa929"))))
     (font-lock-builtin-face ((t (:foreground "#f820b4"))))
     (font-lock-comment-face ((t (:foreground "#05c705"))))
     (font-lock-function-name-face ((t (:foreground "#2841c8"))))
     (font-lock-keyword-face ((t (:foreground "#b415c1"))))
     (font-lock-string-face ((t (:foreground "#aa5509"))))
     (font-lock-type-face ((t (:foreground"#199915"))))
     (font-lock-variable-name-face ((t (:foreground "#09d31c"))))
     (minibuffer-prompt ((t (:foreground "#2302f2" :bold t))))
     (font-lock-warning-face ((t (:foreground "#FF0000" :bold t))))
     )))
  ;; these are used when in X

(defun faces_nox ()
  ;; these are used when in terminal
  (custom-set-faces
   '(default ((t (:foreground "white" :background "black"))))
   '(font-lock-comment-face ((t (:foreground "magenta"))))
   '(font-lock-function-name-face ((t (:foreground "red"))))
   '(font-lock-keyword-face ((t (:foreground "green"))))
   '(font-lock-type-face ((t (:foreground "blue"))))
   '(font-lock-string-face ((t (:foreground "chartreuse3")))) ;cyan
   '(font-lock-variable-name-face ((t (:foreground "blue"))))
   '(menu ((((type x-toolkit)) (:background "white" :foreground "black" :box (:line-width 2 :color "grey75" :style released-button)))))
   '(modeline ((t (:foreground "blue" :background "white")))))
  (set-cursor-color "blue")
  (set-foreground-color "white")
  (set-background-color "black")
  (set-face-foreground 'default "white")
  (set-face-background 'default "black"))


(defun 80line-rule(mode)
 (font-lock-add-keywords 
     mode
     '(("^[^\n]\\{80\\}\\(.*\\)$"
        1 font-lock-warning-face prepend))))

;(if window-system 

; (faces_nox))

;highlight active line
;(require 'highlight-current-line)
;(highlight-current-line-on t)
;(set-face-background 'highlight-current-line-face "darkgreen");"dim grey")
;(require 'highline)
;(highline-mode 1)
;(setq highline-face 'highlight)
;(global-hl-line-mode 1)
;(set-face-background 'hl-line "darkgreen")
;(faces_x)

(provide 'mp-colors)
