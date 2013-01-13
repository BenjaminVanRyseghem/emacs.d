;; misc functions and keybindings

(defun sudo-file ()
  (interactive)
  (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "Sudo file: "))))


(defun sudo-edit ()
  (interactive)
  (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name)))

(defun tunnel (port host)
  (interactive "sPort: \nsHost: ")
  (let ((buffer "SSH Tunnel"))
    (async-shell-command 
     (concat "ssh -C -N -D " port " " host) 
     buffer)
    (with-current-buffer buffer
      (insert (concat "Starting tunnel on " host " port " port)))))

(defun htop ()
  (interactive)
  (term "htop"))
  
;; Custom keybindings
(global-set-key (kbd "C-M-y") 'clipboard-yank)
(global-set-key (kbd "C-M-k") 'clipboard-kill-region)
(global-set-key (kbd "C-c C-f") 'sudo-file)
(global-set-key (kbd "C-c C-s") 'sudo-edit)
(global-set-key (kbd "C-c j") 'bookmark-jump)
(global-set-key [f11] 'toggle-fullscreen)

;; (global-undo-tree-mode)
;; (global-set-key (kbd "C-c u") 'undo-tree-visualize)

(provide 'nico-misc)
