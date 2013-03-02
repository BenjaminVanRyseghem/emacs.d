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
  (local-set-key (kbd "o") 'nico/dired-open-file)
  (local-set-key (kbd "C-x C-a") 'gnus-dired-attach))

(global-set-key (kbd "C-x C-j") 'dired-jump)

(defun nico/dired-open-files () 
  (interactive)
  (dolist (each (dired-get-marked-files t current-prefix-arg)
		(message (concat "open " each))
		(dired-smart-shell-command (concat "open " each)))))
;;(dired-do-shell-command "o" nil (dired-get-marked-files t current-prefix-arg)))

(defun nico/dired-open-file ()
  "In dired, open the file named on this line."
  (interactive)
  (let* ((file (dired-get-filename nil t)))
    (message "Opening %s..." file)
    (call-process "open" nil 0 nil file)
    (message "Opening %s done" file)))


;; faces
;; (set-face-attribute 'dired-directory nil
;; 		    :foreground "SkyBlue")

;; (set-face-attribute 'dired-header nil
;; 		    :weight 'bold
;; 		    :foreground "SkyBlue")

(let ((dired-guessing '(("\\.docx?" "libreoffice")
			("\\.flv" "vlc")
			("\\.html?" "chrome")
			("\\.image" "pharo-vm")
			("\\.jar" "java -jar")
			("\\.jpg" "eog")
			("\\.mkv" "vlc")
			("\\.mp4" "vlc")
			("\\.od[pt]" "libreoffice")
			("\\.ogv" "vlc")
			("\\.pdf" "acroread")
			("\\.png" "eog")
			("\\.pptx?" "libreoffice")
			("\\.sh" "bash")
			("\\.svg" "inkscape")
			("\\.ttf" "gnome-font-viewer")
			("\\.uxf" "~/Downloads/Umlet/umlet.sh")
			("\\.webm" "vlc")
			("\\.xlsx?" "libreoffice")
			("\\.avi" "vlc"))))
  (dolist (pair dired-guessing)
    (add-to-list 'dired-guess-shell-alist-user pair)))



(provide 'nico-dired)
