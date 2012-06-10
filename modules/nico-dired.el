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
  (local-set-key (kbd "o") 'nico/dired-open-files))


;; On linux, use the following script as 'open'
;;#! /bin/bash
;;
;; OSX-like open 
;; 
;;for file in "$@"
;;do
;;  nohup xdg-open "$file" &
;;done
;;sleep 1

(defun nico/dired-open-files () 
  (interactive)
  (save-window-excursion
    (dired-do-shell-command "open" nil (dired-get-marked-files))))

(provide 'nico-dired)
