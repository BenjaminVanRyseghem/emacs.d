(require 'dired-x)

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
  (local-set-key (kbd "o") 'nico/dired-open-files))

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


(provide 'nico-dired)
