(require 'undo-tree)
(global-undo-tree-mode)

;; Conflicts with discover.el
(define-key undo-tree-map (kbd "C-x r") nil)

(provide 'nico-undotree)
