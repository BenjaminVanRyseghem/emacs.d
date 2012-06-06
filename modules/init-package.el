;; package.el

(dolist (source '(("gnu" . "http://elpa.gnu.org/packages/")
		  ("elpa" . "http://tromey.com/elpa/")
		  ("marmalade" . "http://marmalade-repo.org/packages/")))
  (add-to-list 'package-archives source t))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Default packages to load
(defvar my-packages '(auctex 
		      browse-kill-ring 
		      color-theme 
		      color-theme-solarized 
		      less-css-mode 
		      magit 
		      paredit 
		      slime 
		      slime-repl 
		      htmlize 
		      offlineimap
		      ;;jabber ;;Don't use the stable version because of Gtalk support use pre-test 0.8.91 in site-lisp
		      )
  "A list of packages to ensure are installed at launch.")

(dolist (package my-packages)
  (when (not (package-installed-p package))
    (package-install package)))
