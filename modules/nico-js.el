;; JS files

(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
 
(add-hook 'js-mode-hook '(lambda ()
			    (flycheck-mode t)
			    (setq tab-width 4)))

;; js2-refactor
;; (js2r-add-keybindings-with-prefix "C-c C-r")

(provide 'nico-js)
