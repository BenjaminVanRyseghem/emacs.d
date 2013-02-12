(require 'dired-x)
(require 'dired-details)

;;Enable some commands
(put 'dired-find-alternate-file 'disabled nil)

;; ls flags
(setq dired-listing-switches "-ahl")

;; Try to guess the target directory for copying
(setq dired-dwim-target t)

;; Hide hidden files
(setq dired-omit-files "^\\...+$")

(add-hook 'dired-mode-hook (lambda () 
			     (dired-omit-mode 1)
			     (nico/dired-set-keys)))

(defun nico/dired-set-keys ()
  (local-set-key (kbd "M-s") 'find-name-dired)
  (local-set-key (kbd "K") 'dired-kill-subdir)
  ;;(local-set-key (kbd "o") 'nico/dired-open-files)
  (local-set-key (kbd "C-x C-a") 'gnus-dired-attach))

(global-set-key (kbd "C-x C-j") 'dired-jump)

(defun nico/dired-open-files () 
  (interactive)
  (dolist (each (dired-get-marked-files t current-prefix-arg)
		(dired-smart-shell-command (concat "xdg-open " each)))))
;;  (dired-do-shell-command "o" nil (dired-get-marked-files t current-prefix-arg)))


;; faces
(set-face-attribute 'dired-directory nil
		    :foreground "SkyBlue")

(set-face-attribute 'dired-header nil
		    :weight 'bold
		    :foreground "SkyBlue")

(let ((dired-guessing '(("\\.docx?" "libreoffice")
			("\\.flv" "vlc")
			("\\.html?" "firefox")
			("\\.image" "pharo-vm")
			("\\.jar" "java -jar")
			("\\.jpg" "eog")
			("\\.mkv" "totem")
			("\\.mp4" "totem")
			("\\.od[pt]" "libreoffice")
			("\\.ogv" "totem")
			("\\.pdf" "acroread")
			("\\.png" "eog")
			("\\.pptx?" "libreoffice")
			("\\.sh" "bash")
			("\\.svg" "inkscape")
			("\\.ttf" "gnome-font-viewer")
			("\\.uxf" "~/Downloads/Umlet/umlet.sh")
			("\\.webm" "totem")
			("\\.xlsx?" "libreoffice")
			("\\.avi" "totem"))))
  (dolist (pair dired-guessing)
    (add-to-list 'dired-guess-shell-alist-user pair)))



(provide 'nico-dired)
