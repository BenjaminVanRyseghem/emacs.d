(require 'pos-tip) ;; better looking tooltips
(require 'auto-complete)
(require 'auto-complete-config)

(dolist (entry `(,user-mail-address "Nicolas" "Petton"))
  (add-to-list 'ac-user-dictionary entry))

(setq ac-use-menu-map t
	  ac-ignore-case t)

(setq ac-source-yasnippet nil)
(ac-flyspell-workaround)
(ac-config-default)

(global-auto-complete-mode)

(add-hook 'auto-complete-mode-hook 
		  (lambda ()
			(dolist (source '(ac-source-yasnippet ac-source-filename ac-source-dictionary))
			  (add-to-list 'ac-sources source))))

(provide 'nico-auto-complete)
