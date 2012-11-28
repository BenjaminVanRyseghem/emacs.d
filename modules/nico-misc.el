;; misc functions and keybindings

(defun sudo-file ()
  (interactive)
  (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "Sudo file: "))))


(defun sudo-edit ()
  (interactive)
  (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name)))

;; Custom keybindings
(global-set-key (kbd "C-M-y") 'clipboard-yank)
(global-set-key (kbd "C-M-k") 'clipboard-kill-region)
(global-set-key (kbd "C-c C-f") 'sudo-file)
(global-set-key (kbd "C-c C-s") 'sudo-edit)
(global-set-key (kbd "C-c j") 'bookmark-jump)
(global-set-key [f11] 'toggle-fullscreen)

(global-undo-tree-mode)
(global-set-key (kbd "C-c u") 'undo-tree-visualize)

(provide 'nico-misc)
