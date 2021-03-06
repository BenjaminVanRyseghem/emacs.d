;; Go back to the previous windows configuation with C-c left
(winner-mode)
(global-set-key (kbd "C-|") #'winner-undo)

;; Workaround for french accents
;; https://bugs.launchpad.net/emacs-snapshot/+bug/1251176
(require 'iso-transl)

(defun sudo-file ()
  (interactive)
  (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "Sudo file: "))))

(defun sudo-edit ()
  (interactive)
  (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name)))


;; locate. see $HOME/.profile
(defun updatedb ()
  (interactive)
  (async-shell-command "updatedb -l 0 -o $HOME/var/mlocate.db -U $HOME"))

(defun nico/locate-make-command-line (str)
  (list locate-command "-d" "/home/nico/var/mlocate.db" str))
(setq locate-make-command-line 'nico/locate-make-command-line)

(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(global-set-key (kbd "C-c C-e") #'eval-and-replace)

(defun space2underscore-region (start end)
  "Replace space by underscore in region."
  (interactive "r")
  (save-restriction
    (narrow-to-region start end)
    (goto-char (point-min))
    (while (search-forward " " nil t) (replace-match "_")) ) )

(defun underscore2space-region (start end)
  "Replace underscore by space in region."
  (interactive "r")
  (save-restriction
    (narrow-to-region start end)
    (goto-char (point-min))
    (while (search-forward "_" nil t) (replace-match " ")) ))

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
(setq-default tab-width 4
      indent-tabs-mode t)

;; Use C-SPC to cycle through the mark ring after the first return
(setq set-mark-command-repeat-pop t)

;; uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; switch-window and shrinking
(global-set-key (kbd "C-;") 'other-window)
(global-set-key (kbd "C-M-s-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-M-s-<down>") 'shrink-window)
(global-set-key (kbd "C-M-s-<up>") 'enlarge-window)

;; browse-url
(global-set-key (kbd "C-c C-o") 'browse-url)
 
;; Custom keybindings
;; (global-set-key (kbd "M-i") 'imenu)
(global-set-key (kbd "C-M-y") 'clipboard-yank)
(global-set-key (kbd "C-M-k") 'clipboard-kill-region)
(global-set-key (kbd "C-c C-f") 'sudo-file)
(global-set-key (kbd "C-c j") 'bookmark-jump)
(global-set-key [f11] 'toggle-fullscreen)
(global-set-key (kbd "C-x u") 'undo-tree-visualize)
(global-set-key (kbd "S-SPC") 'dabbrev-expand)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-c y") 'browse-kill-ring)
(global-set-key (kbd "C-c C-f") 'windmove-right)
(global-set-key (kbd "C-c C-b") 'windmove-left)
(global-set-key (kbd "C-c C-n") 'windmove-down)
(global-set-key (kbd "C-c C-p") 'windmove-up)

(provide 'nico-misc)
