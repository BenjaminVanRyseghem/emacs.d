(require 'powerline)

(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(defun setup-color-theme ()
  (interactive)
  (load-theme 'subatomic))

(defun setup-window-system ()
  (if (window-system) (progn 
			(setq frame-title-format '(buffer-file-name "%f" ("%b")))
			(tooltip-mode -1)
			(set-default-font "UbuntuMono-12")
			(mouse-wheel-mode t)
			(powerline-default-theme)
			(blink-cursor-mode -1)
			(setup-color-theme))))


(setup-window-system)

(provide 'nico-window-system)
