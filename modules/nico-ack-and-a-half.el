(require 'ack-and-a-half)

;; Create shorter aliases
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

(define-key ack-and-a-half-mode-map (kbd "n") 'next-error-no-select)
(define-key ack-and-a-half-mode-map (kbd "p") 'previous-error-no-select)

(provide 'nico-ack-and-a-half)
