(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
     (goto-char (point-max))
     (eval-print-last-sexp)))))


(push "~/.emacs.d/el-get-recipes" el-get-recipe-path)

(defvar nico/get-packages '(ace-jump-mode
			    ;; required by org-pomodoro
			    alert
			    ;; auctex
			    drag-stuff
			    ;; bbdb
			    browse-kill-ring 
			    ;; dired-details
			    epresent
			    expand-region
			    flycheck
			    google-maps
			    htmlize 
			    js-comint
			    js2-mode
			    js2-refactor s ;; s is required by js2-refactor
			    ido-ubiquitous
			    magit 
			    markdown-mode
			    ;; mu4e installed with apt-get
			    multiple-cursors
			    notify
			    ;; notmuch
			    ;; notmuch-labeler
			    nyan-mode
			    offlineimap
			    org-mode
			    org-pomodoro
			    paredit 
			    pcomplete-plugins
			    rainbow-mode
			    shell-switcher
			    solarized-theme
			    sr-speedbar
			    switch-window
			    twilight-anti-bright-theme
			    undo-tree
			    yasnippet)
  "A list of packages to ensure are installed at launch.")

(el-get 'sync nico/get-packages)

(provide 'nico-el-get)
