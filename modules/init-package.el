;; package.el

(require 'package)
(dolist (source '(("elpa" . "http://tromey.com/elpa/")
		  ("marmalade" . "http://marmalade-repo.org/packages/")
		  ("gnu" . "http://elpa.gnu.org/packages/")))
  (add-to-list 'package-archives source t))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Default packages to load
(defvar my-packages '(auctex browse-kill-ring color-theme less-css-mode magit paredit slime slime-repl)
  "A list of packages to ensure are installed at launch.")

(dolist (package my-packages)
  (when (not (package-installed-p package))
    (package-install package)))
