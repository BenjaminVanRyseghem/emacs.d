;; misc functions and keybindings
(require 'switch-window)

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
 
;; Use tabs instead of spaces for indenting by default
(setq-default indent-tabs-mode t)

;; sr-speedbar global-shortcut
(global-set-key (kbd "M-i") 'imenu)

;; switch-window
(global-set-key (kbd "C-x o") 'switch-window)

;; browse-url
(global-set-key (kbd "C-c C-o") 'browse-url)
 
;; Custom keybindings
;; (global-set-key (kbd "M-i") 'imenu)
(global-set-key (kbd "C-M-y") 'clipboard-yank)
(global-set-key (kbd "C-M-k") 'clipboard-kill-region)
(global-set-key (kbd "C-c C-f") 'sudo-file)
(global-set-key (kbd "C-c C-s") 'sudo-edit)
(global-set-key (kbd "C-c j") 'bookmark-jump)
(global-set-key [f11] 'toggle-fullscreen)
(global-set-key (kbd "C-x u") 'undo-tree-visualize)
(global-set-key (kbd "S-SPC") 'dabbrev-expand)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-c y") 'browse-kill-ring)

(provide 'nico-misc)
