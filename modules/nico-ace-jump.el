;; If you use the default configuration, which binds to "C-c SPC".

;; "C-c SPC" ==> ace-jump-word-mode

;; enter first character of a word, select the highlighted key to move to it.
;; "C-u C-c SPC" ==> ace-jump-char-mode

;; enter a character for query, select the highlighted key to move to it.
;; "C-u C-u C-c SPC" ==> ace-jump-line-mode

;; each non-empty line will be marked, select the highlighted key to move to it.

(define-key global-map (kbd "C-z") 'ace-jump-mode)

(provide 'nico-ace-jump)
