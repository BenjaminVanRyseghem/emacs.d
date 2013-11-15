(require 'visual-regexp)

(define-key global-map (kbd "C-M-v") 'vr/replace)
(define-key global-map (kbd "M-%") 'vr/query-replace)

(provide 'nico-visual-regexp)
