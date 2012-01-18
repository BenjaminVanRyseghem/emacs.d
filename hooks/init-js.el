;; JS files

(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))


(add-hook 'js-mode-hook '(lambda ()
			   ;;(setq js-indent-level 4)
			   (setq tab-width 4)
			   (setq indent-tabs-mode nil)))
