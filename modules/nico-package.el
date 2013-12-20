;; package.el

(let ((sources '(("gnu" . "http://elpa.gnu.org/packages/")
		("elpa" . "http://tromey.com/elpa/")
		("org"       . "http://orgmode.org/elpa/")
		("melpa" . "http://melpa.milkbox.net/packages/")
		("marmalade" . "http://marmalade-repo.org/packages/"))))
  (dolist (source sources)
	  (add-to-list 'package-archives source t))
  (package-initialize))

(when (not package-archive-contents)
  (package-refresh-contents))

;; Default packages to load
(let ((packages-to-load '(less-css-mode
			  ace-jump-mode
			  ack-and-a-half
			  alert
			  auctex
			  drag-stuff
			  browse-kill-ring 
			  epresent
			  expand-region
			  flycheck
			  guide-key
			  google-maps
			  google-translate
			  htmlize 
			  js-comint
			  js2-mode
			  js2-refactor s ;; s is required by js2-refactor
			  ido-ubiquitous
			  magit
			  magit-svn
			  markdown-mode
			  multiple-cursors
			  notify
			  nyan-mode
			  offlineimap
			  org
			  org-pomodoro
			  ox-reveal
			  paredit 
			  powerline
			  projectile
			  rainbow-mode
			  runner
			  shell-switcher
			  solarized-theme
			  sr-speedbar
			  ;; switch-window
			  telepathy
			  twilight-anti-bright-theme
			  undo-tree
			  yasnippet
			  zenburn)))
  (dolist (package packages-to-load)
    (when (not (package-installed-p package))
      (package-install package))))

(provide 'nico-package)
