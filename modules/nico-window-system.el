;; window system

(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(defun setup-color-theme ()
  (interactive)
  (load-theme 'twilight t))

(defun setup-window-system ()
  (if (window-system) (progn 
			(setq frame-title-format '(buffer-file-name "%f" ("%b")))
			(tooltip-mode -1)
			(mouse-wheel-mode t)
			(blink-cursor-mode -1)
			(setup-color-theme)
			(powerline-default-theme)
			)))

(setup-window-system)

(provide 'nico-window-system)
