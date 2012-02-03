;; window system

(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(defun set-font ()
  (interactive)
  (set-face-attribute 'default nil :font "Monospace-10"))

(defun setup-color-theme ()
  (interactive)
  (require 'color-theme)
  (load-file "~/.emacs.d/color-themes/color-theme-twilight.el")
  (load-file "~/.emacs.d/color-themes/blackboard.el")
  (color-theme-twilight))

(defun setup-window-system ()
  (if (window-system) (progn 
			(setq frame-title-format '(buffer-file-name "%f" ("%b")))
			(tooltip-mode -1)
			(mouse-wheel-mode t)
			(blink-cursor-mode -1)
			(set-font)
			(setup-color-theme))))

(setup-window-system)

