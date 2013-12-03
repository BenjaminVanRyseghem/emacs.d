;; Hide toolbar, menubar and scrollbar, just because I don't like them
(tool-bar-mode 0)
(menu-bar-mode 0) ;; the menubar on OSX is ok
(scroll-bar-mode 0)

(setq inhibit-startup-screen t)
(defalias 'yes-or-no-p 'y-or-n-p)

;; customize file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)


;; Behave sanely
(require 'cl)

(defvar modules-dir "~/.emacs.d/modules")
(defvar site-lisp-dir "~/.emacs.d/site-lisp")

;; load path
(add-to-list 'load-path modules-dir)
(add-to-list 'load-path site-lisp-dir)

(let ((default-directory site-lisp-dir))
  (normal-top-level-add-subdirs-to-load-path))

(require 'package)
(require 'nico-modules)
(require 'ido)
(require 'icomplete)
(require 'switch-window)
(require 'zeitgeist)

(icomplete-mode 99)
(ido-mode)
(setq ido-enable-flex-matching t)

;; use ibuffer instead of the default buffer-list
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Change the behavior of M-f and co to properly handle camel case
(global-subword-mode 1)

(delete-selection-mode 1)
;; (global-hl-line-mode 1)

;; Start server
(server-start)

;; tramp
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
(put 'narrow-to-region 'disabled nil)
