(require 'pos-tip) ;; better looking tooltips
(require 'auto-complete)
(require 'auto-complete-config)

(add-to-list 'ac-user-dictionary 
			 user-mail-address
			 "Nicolas"
			 "Petton")

(setq ac-use-menu-map t)

(add-to-list 'ac-sources 'ac-source-yasnippet)
(add-to-list 'ac-sources 'ac-source-filename)
(add-to-list 'ac-sources 'ac-user-dictionary)

(setq ac-source-yasnippet nil)
(ac-flyspell-workaround)
(ac-config-default)

(global-auto-complete-mode)

(provide 'nico-auto-complete)
