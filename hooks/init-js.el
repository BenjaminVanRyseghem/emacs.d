;; JS files

(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))


(add-hook 'js-mode-hook '(lambda ()
			   (setq js-indent-level 8)
			   (setq tab-width 8)))

