;; (push #p"~/dir/to/sly" asdf:*central-registry*)
;; (asdf:load-system :slynk)
;; (slynk:create-server :port 4008)
;(add-to-list 'load-path "~/dir/to/cloned/sly")
;; (require 'sly-autoloads)
(setq inferior-lisp-program "/opt/sbcl/bin/sbcl")
 	

(setq sly-lisp-implementations
      '((ccl ("ccl"))
        (lw ("lw-console"))
        (sbcl ("sbcl" "--dynamic-space-size" "5024") :coding-system utf-8-unix)))

(provide 'mp-sly)
