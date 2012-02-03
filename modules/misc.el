;; misc functions and keybindings

(defun sudo-edit ()
  (interactive)
  (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "Sudo file: "))))


(defun sudo-file ()
  (interactive)
  (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name)))


;; Custom keybindings
(global-set-key (kbd "C-M-y") 'clipboard-yank)
(global-set-key (kbd "C-M-k") 'clipboard-kill-region)
(global-set-key (kbd "C-c C-f") 'sudo-file)
(global-set-key (kbd "C-c C-s") 'sudo-edit)
(global-set-key [f11] 'toggle-fullscreen)


