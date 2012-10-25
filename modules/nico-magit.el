(require 'magit)
(require 'magit-svn)

(define-key global-map (kbd "C-x g") 'magit-status)
(add-hook 'magit-mode-hook 'turn-on-magit-svn)

(provide 'nico-magit)
