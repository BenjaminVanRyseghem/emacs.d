;; package.el

(require 'package)
(dolist (source '(("technomancy" . "http://repo.technomancy.us/emacs/")
		  ("elpa" . "http://tromey.com/elpa/")
		  ("marmalade" . "http://marmalade-repo.org/packages/")
		  ("gnu" . "http://elpa.gnu.org/packages/")))
  (add-to-list 'package-archives source t))
(package-initialize)

