;; package.el
;; Still using it because some packages are missing from el-get

(dolist (source '(("gnu" . "http://elpa.gnu.org/packages/")
		  ("elpa" . "http://tromey.com/elpa/")
		  ("melpa" . "http://melpa.milkbox.net/packages/")
		  ("marmalade" . "http://marmalade-repo.org/packages/")))
  (add-to-list 'package-archives source t))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Default packages to load

(defvar my-packages '(less-css-mode twilight-theme)
  "A list of packages to ensure are installed at launch.")

(dolist (package my-packages)
  (when (not (package-installed-p package))
    (package-install package)))

(provide 'nico-package)
