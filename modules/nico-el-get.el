(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (goto-char (point-max))
     (eval-print-last-sexp))))


(push "~/.emacs.d/el-get-recipes" el-get-recipe-path)

(defvar nico/get-packages '(auctex 
			    pcomplete-plugins
			    browse-kill-ring 
			    bbdb
			    dvc
			    nyan-mode
			    magit 
			    paredit 
			    slime 
			    htmlize 
			    offlineimap
			    twilight-anti-bright-theme
			    shell-switcher
			    switch-window
			    expand-region
					;drag-stuff    ;; see later
			    emacs-jabber)
  "A list of packages to ensure are installed at launch.")

(el-get 'sync nico/get-packages)

(provide 'nico-el-get)
