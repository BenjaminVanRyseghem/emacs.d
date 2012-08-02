;; Hide toolbar, menubar and scrollbar, just because I don't like them
(tool-bar-mode 0)
;; (menu-bar-mode 0)
(scroll-bar-mode 0)

;; Display line numbers
;; (global-linum-mode t)

(setq inhibit-startup-screen t)

;; Behave sanely
(require 'cl)

(defvar modules-dir "~/.emacs.d/modules")
(defvar site-lisp-dir "~/.emacs.d/site-lisp")

;; load path
(add-to-list 'load-path modules-dir)
(add-to-list 'load-path site-lisp-dir)

(let ((default-directory site-lisp-dir))
      (normal-top-level-add-subdirs-to-load-path))

;;(mapc 'load (directory-files modules-dir nil "^[^#].*el$"))

(require 'package)
(require 'nico-modules)
(require 'google-translate)
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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex -synctex=1")
 '(notmuch-saved-searches (quote (("inbox" . "tag:inbox") ("unread" . "tag:unread") ("Pharo" . "folder:Smalltalk.Pharo AND tag:unread") ("Amber" . "folder: Smalltalk.Amber AND tag:unread") ("RMoD" . "folder:rmod AND tag:unread")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
