(defvar private-dir "~/.priv/elisp" 
  "Private elisp directory")

(if (file-exists-p private-dir)
	(add-to-list 'load-path private-dir))

(require 'private-modules)

(provide 'nico-private-modules)
