(require 'drag-stuff)

(drag-stuff-global-mode t)
(add-to-list 'drag-stuff-except-modes 'org-mode)
(add-to-list 'drag-stuff-except-modes 'rebase-mode)
(add-to-list 'drag-stuff-except-modes 'emacs-lisp-mode)

(provide 'nico-drag-stuff)
