(defface writer-mode-default-face '((t (:inherit default)))
  "Face for writer-mode")

(defcustom writer-minor-mode-string "Writer"
  "String to display in  mode-line when Writer mode is enabled.")

(defcustom writer-mode-left-margin 30
  "Left margin in Writer mode")

(defcustom writer-mode-right-margin 30
  "Left margin in Writer mode")

(define-minor-mode writer-mode 
  "Toggle writer minor mode. A minor mode for editing files with fonts for writing."
  :group 'writer :lighter writer-minor-mode-string
  (if writer-mode
      (enable-writer-mode)
    (disable-writer-mode)))

(defun enable-writer-mode ()
  (ns-toggle-fullscreen)
  (auto-fill-mode t)
  (set-window-margins (selected-window)
		      writer-mode-left-margin
		      writer-mode-right-margin)
  (writer-set-faces))

(defun disable-writer-mode ()
  (ns-toggle-fullscreen)
  (auto-fill-mode -1)
  (set-window-margins (selected-window)
		      left-margin-width
		      right-margin-width)
  (writer-unset-faces))

(defun writer-set-faces ()
  "Faces settings for the current buffer."
  (buffer-face-set 'writer-mode-default-face))

(defun writer-unset-faces ()
  (buffer-face-set 'default))

(provide 'nico-writer-mode)
