(require 'eshellbmk)
(require 'shell-switcher)
(require 'eshell-enhanced-ls)
;;(require 'pcmpl-apt)

(setq shell-switcher-mode t)

(setq eshell-banner-message (concat " Welcome to Eshell, "
				    user-login-name
				    "!\n       _\n     _|_|_\n     (o o)\n ooO--(_)--Ooo-\n\n Oh, Nice hat.\n\n"))


;; Prompt
;; Taken and adapted from Damien Cassou's prompt

(defvar nico:prompt-inserted nil)

(defun nico:color (type)
  (case type
    ('arrow "white")
    ('prompt "#CF6A4C")
    ('folder "sky blue")
    ('alert "red")
    ('good "lime green")
    ('warning "dark orange")
    (t "black")))

(defun nico:mprint (obj &optional color)
  (if color
      (insert (propertize obj 'face `(:foreground ,(nico:color color))))
    (insert obj)))

(defun nico:insert-value (value &optional color)
  (nico:mprint value color)
  (setq nico:prompt-inserted (not (string= value ""))))

(defun nico:insert-separator (&optional separator)
  (let ((sep (or separator ":")))
    (if nico:prompt-inserted
	(nico:mprint sep))))

(defun nico:insert-pwd ()
  (let ((pwd (abbreviate-file-name (eshell/pwd))))
    (nico:insert-value pwd 'folder)))

(defun nico:git-color ()
  "Returns a color code based on the current repository status"
  (if (zerop (magit-git-exit-code "diff" "--quiet"))
      ;; nothing to commit because nothing changed
      (if (zerop (length (magit-git-string
			  "rev-list" (concat "origin/"
					     (magit-get-current-branch)
					     ".."
					     (magit-get-current-branch)))))
	  ;; nothing to push as well
	  'good
	;; nothing to commit, but some commits must be pushed
	'warning)
    'alert))

(defun nico:insert-branch ()
  (let ((branch (magit-get-current-branch)))
    (if branch
	(nico:mprint (concat " <" branch ">") (nico:git-color)))))

(defun nico:insert-hostname (&optional color)
  (nico:insert-value (substring (shell-command-to-string "hostname") 0 -1) color))
(defun nico:eshell-prompt ()
  (with-temp-buffer
    (nico:insert-value "\n☼ " 'arrow)
    (nico:insert-separator "[")
    (nico:insert-value (user-login-name) 'prompt)
    (nico:insert-separator "@")
    (nico:insert-hostname 'prompt)
    (nico:insert-separator "] ")
    (nico:insert-pwd)
    (nico:insert-branch)
    (nico:insert-value " ☼\n" 'arrow)
    (nico:insert-value (if (= (user-uid) 0) "# " "(♫) $ "))
    (buffer-substring (point-min) (point-max))))

(eval-after-load "em-prompt"
  '(progn
     (setq eshell-highlight-prompt nil)
     (setq eshell-prompt-function 'nico:eshell-prompt)))



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

;;;###autoload
(defun eshell/tunnel (port host)
  (tunnel (number-to-string port) host))

(provide 'nico-eshell)
