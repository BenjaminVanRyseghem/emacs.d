(define-minor-mode writer-mode 
   "A minor mode for editing files with fonts for writing.")

(defface writer-mode-default-face '((t (:inherit default)))
  "Face for writer-mode")

(defun writer-set-faces ()
  "Faces settings for the current buffer."
  (buffer-face-mode-invoke 'writer-mode-default-face nil t))

(add-hook 'writer-mode-hook 'writer-set-faces)

(provide 'nico-writer-mode)
