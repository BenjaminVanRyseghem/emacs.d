;; (require 'nyan-mode)
;; (nyan-mode)
;;(display-time-mode)

(setq-default
 mode-line-format
 '(
   ;; Position, including warning for 80 columns
   (:propertize "%4l:" face mode-line-position-face)
   (:eval (propertize "%3c" 'face
                      (if (>= (current-column) 80)
                          'mode-line-80col-face
                        'mode-line-position-face)))

   ;; emacsclient [default -- keep?]
   mode-line-client
   "  "
   ;; read-only or modified status
   (:eval
    (cond (buffer-read-only
           (propertize " RO " 'face 'mode-line-read-only-face))
          ((buffer-modified-p)
           (propertize " ** " 'face 'mode-line-modified-face))
          (t " RW ")))
   "    "
   ;; directory and buffer/file name
   (:propertize (:eval (nico/shorten-directory default-directory 30))
                face mode-line-folder-face)
   (:propertize "%b"
                face mode-line-filename-face)

   ;; narrow [default -- keep?]
   " %n "
   ;; mode indicators: vc, recursive edit, major mode, minor modes, process, global
   (vc-mode vc-mode)
   "  %["
   (:propertize mode-name
                face mode-line-mode-face)
   "%] "
   (:eval (propertize (format-mode-line minor-mode-alist)
                      'face 'mode-line-minor-mode-face))
   "  "
   (global-mode-string global-mode-string)
   "  "
   ;; nyan-mode uses nyan cat as an alternative to %p
   (:eval (when nyan-mode (list (nyan-create))))
   ))


;; Eshell mode-line
(defun nico/eshell-mode-line ()
  (setq mode-line-format 
	'(
	  (:propertize "%4l:" face mode-line-position-face)

	  ;; emacsclient [default -- keep?]
	  mode-line-client
	  "  "
	  ;; directory name
	  (:propertize (:eval default-directory)
		       face mode-line-folder-face)

	  ;; narrow [default -- keep?]
	  " %n "
	  ;; mode indicators: vc, recursive edit, major mode, minor modes, process, global
	  (vc-mode vc-mode)
	  "  %["
	  (:propertize mode-name
		       face mode-line-mode-face)
	  "%] "
	  (:eval (propertize (format-mode-line minor-mode-alist)
			     'face 'mode-line-minor-mode-face))
	  "  "
	  (global-mode-string global-mode-string))))


;; major mode hooks
(add-hook 'eshell-mode-hook 'nico/eshell-mode-line)


;; Helper function
(defun nico/shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat ".../" output)))
    output))

;; Extra mode line faces
(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-folder-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-position-face)
(make-face 'mode-line-mode-face)
(make-face 'mode-line-minor-mode-face)
(make-face 'mode-line-process-face)
(make-face 'mode-line-80col-face)

(set-face-attribute 'mode-line nil
		    :foreground "#fdf6e3" :background "#062b36"
		    :inverse-video nil
		    :box '(:line-width 1 :color "#062b36" :style nil))
(set-face-attribute 'mode-line-inactive nil
		    :foreground "#fdf6e3" :background "#0d4758"
		    :inverse-video nil
		    :box '(:line-width 1 :color "#0d4758" :style nil))

(set-face-attribute 'mode-line-read-only-face nil
		    :inherit 'mode-line-face
		    :foreground "#4271ae"
		    :box '(:line-width 1 :color "#4271ae"))
(set-face-attribute 'mode-line-modified-face nil
		    :inherit 'mode-line-face
		    :foreground "#c82829"
		    :background "#ffffff"
		    :box '(:line-width 1 :color "#c82829"))
(set-face-attribute 'mode-line-folder-face nil
		    :inherit 'mode-line-face
		    :foreground "gray60")
(set-face-attribute 'mode-line-filename-face nil
		    :inherit 'mode-line-face
		    :foreground "#cb4a15"
		    :weight 'bold)
(set-face-attribute 'mode-line-position-face nil
		    :inherit 'mode-line-face)
(set-face-attribute 'mode-line-mode-face nil
		    :inherit 'mode-line-face
		    :foreground "#268bd2")
(set-face-attribute 'mode-line-minor-mode-face nil
		    :inherit 'mode-line-mode-face
		    :foreground "#2aa198")
(set-face-attribute 'mode-line-80col-face nil
		    :inherit 'mode-line-position-face
		    :foreground "black" :background "#eab700")

(provide 'nico-mode-line)
