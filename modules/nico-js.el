(require 'js2-mode)
(require 'js2-refactor)
(require 'ac-js2)
(require 'fic-mode)
;; (require 'discover-js2-refactor)

(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
 
(add-hook 'js2-mode-hook (lambda ()
						   ;; (flycheck-mode t)
						   (fic-mode)
						   (ac-js2-mode)
						   (setq tab-width 4
								 indent-tabs-mode t)))

;; js2-refactor
(js2r-add-keybindings-with-prefix "C-c C-r")

;; js-comint -- M-x run-js
(setq inferior-js-program-command "node")
(setenv "NODE_NO_READLINE" "1")
(add-hook 'js2-mode-hook (lambda () 
			    (local-set-key "\C-x\C-e" 'js-send-last-sexp)
			    (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
			    (local-set-key "\C-cb" 'js-send-buffer)
			    (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
			    (local-set-key "\C-cl" 'js-load-file-and-go)))

(provide 'nico-js)
