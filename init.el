;; Hide toolbar, menubar and scrollbar, just because I don't like them
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;; Display line numbers
;; (global-linum-mode t)

(setq inhibit-startup-screen t)


(require 'cl)

(setq 
 hooks-dir "~/.emacs.d/hooks"
 site-lisp-dir "~/.emacs.d/site-lisp")


;; load path
(add-to-list 'load-path hooks-dir)
(add-to-list 'load-path site-lisp-dir)

(mapc 'load (directory-files hooks-dir nil "^[^#].*el$"))


;; Custom keybindings
(global-set-key (kbd "C-M-y") 'clipboard-yank)
(global-set-key (kbd "C-M-k") 'clipboard-kill-region)
(global-set-key [f11] 'toggle-fullscreen)


;; icomplete-mode & ido-mode
(require 'ido)
(require 'icomplete)
(icomplete-mode 99)
(ido-mode)


;; Start server
(server-start)

;; Git
;(require 'git)
;(require 'git-blame)

;; tramp -- transparent remote file access
(require 'tramp)

;; enable some disabled commands
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; Cosmetics
(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "green4")
     (set-face-foreground 'diff-removed "red3")))

(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green4")
     (set-face-foreground 'magit-diff-del "red3")))

;; Paren mode
(show-paren-mode t)
