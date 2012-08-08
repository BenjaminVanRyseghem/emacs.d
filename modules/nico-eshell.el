(require 'eshellbmk)
(require 'shell-switcher)
(require 'eshell-enhanced-ls)

(setq shell-switcher-mode t)


;; Prompt
(setq eshell-prompt-function
      (lambda ()
	(concat
	 "[" user-login-name "] "
	 (format-time-string "%H:%M " (current-time))
	 (abbreviate-file-name (eshell/pwd))
	 (if (= (user-uid) 0) " # " " $ "))))


(setq eshell-cmpl-cycle-completions nil
      eshell-save-history-on-exit t
      eshell-buffer-shorthand t
      eshell-cmpl-dir-ignore "\\`\\(\\.\\.?\\|CVS\\|\\.svn\\|\\.git\\)/\\'")

;; Normal scrolling
(setq eshell-scroll-show-maximum-output nil)
(setq eshell-scroll-to-bottom-on-output nil)


(eval-after-load 'esh-opt
  '(progn
     (require 'em-prompt)
     (require 'em-term)
     (require 'em-cmpl)
     (setenv "PAGER" "cat")
     (set-face-attribute 'eshell-prompt nil :foreground "green2")
     (add-hook 'eshell-mode-hook ;; for some reason this needs to be a hook
               '(lambda () (define-key eshell-mode-map "\C-a" 'eshell-bol)))
     (add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)

     (add-to-list 'eshell-visual-commands "ssh")
     (add-to-list 'eshell-visual-commands "htop")
     (add-to-list 'eshell-visual-commands "top")
     (add-to-list 'eshell-visual-commands "tail")
     (add-to-list 'eshell-visual-commands "vim")
     (add-to-list 'eshell-command-completions-alist
                  '("gunzip" "gz\\'"))
     (add-to-list 'eshell-command-completions-alist
                  '("tar" "\\(\\.tar|\\.tgz\\|\\.tar\\.gz\\)\\'"))))


;;;###autoload
(when (not (functionp 'eshell/rgrep))
  (defun eshell/rgrep (&rest args)
    "Use Emacs grep facility instead of calling external grep."
    (eshell-grep "rgrep" args t)))

;;;###autoload
(defun eshell/extract (file)
  (let ((command (some (lambda (x)
                         (if (string-match-p (car x) file)
                             (cadr x)))
                       '((".*\.tar.bz2" "tar xjf")
                         (".*\.tar.gz" "tar xzf")
                         (".*\.bz2" "bunzip2")
                         (".*\.rar" "unrar x")
                         (".*\.gz" "gunzip")
                         (".*\.tar" "tar xf")
                         (".*\.tbz2" "tar xjf")
                         (".*\.tgz" "tar xzf")
                         (".*\.zip" "unzip")
                         (".*\.Z" "uncompress")
                         (".*" "echo 'Could not extract the file:'")))))
    (eshell-command-result (concat command " " file))))

(provide 'nico-eshell)
