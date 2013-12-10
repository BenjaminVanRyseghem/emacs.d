(require 'dired-x)
(require 'runner)

(setq runner-run-in-background t)

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

;; Enhanced RET
(defun nico/dired-return (&optional prefix)
  "When used with the C-u (universal argument), find the file in other window"
  (interactive "p")
  (if (> prefix 1)
      (dired-find-file-other-window)
    (dired-find-file)))

;; Hide hidden files
(setq dired-omit-files "^\\...+$")

(add-hook 'dired-mode-hook (lambda () 
			     (dired-omit-mode 1)
			     (nico/dired-set-keys)))

(defun nico/dired-set-keys ()
  (local-set-key (kbd "M-s") 'find-name-dired)
  (local-set-key (kbd "K") 'dired-kill-subdir)
  (local-set-key (kbd "o") 'nico/dired-open-file)
  (local-set-key (kbd "RET") 'nico/dired-return)
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


(provide 'nico-dired)
