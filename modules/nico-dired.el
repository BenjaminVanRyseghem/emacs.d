(require 'dired-x)

;; auto-update dired buffers
(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)

;;Enable some commands
(put 'dired-find-alternate-file 'disabled nil)

;; ls flags
(setq dired-listing-switches "-ahl")

;; hide details
;; (dired-details-install)

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
		(message (concat "xdg-open " each))
		(dired-smart-shell-command (concat "xdg-open " each)))))

(defun nico/dired-open-file ()
  "In dired, open the file named on this line."
  (interactive)
  (let* ((file (dired-get-filename nil t)))
    (message "Opening %s..." file)
    (call-process "xdg-open" nil 0 nil file)
    (message "Opening %s done" file)))

(let ((dired-guessing '(("\\.docx?" "libreoffice")
			("\\.flv" "totem")
			("\\.html?" "chrome")
			("\\.image" "pharo-vm")
			("\\.jar" "java -jar")
			("\\.jpg" "eog")
			("\\.mkv" "totem")
			("\\.mp4" "totem")
			("\\.od[pt]" "libreoffice")
			("\\.ogv" "totem")
			("\\.pdf" "evince")
			("\\.png" "eog")
			("\\.pptx?" "libreoffice")
			("\\.sh" "bash")
			("\\.svg" "inkscape")
			("\\.ttf" "gnome-font-viewer")
			("\\.webm" "totem")
			("\\.xlsx?" "libreoffice")
			("\\.avi" "totem"))))
  (dolist (pair dired-guessing)
    (add-to-list 'dired-guess-shell-alist-user pair)))



(provide 'nico-dired)
