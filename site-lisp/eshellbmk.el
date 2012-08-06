(require 'bookmark)

(defun pcomplete/eshell-mode/bmk ()
  "Completion for `bmk'"
  (pcomplete-here (bookmark-all-names)))

(defun eshell/bmk (&rest args)
  "Integration between EShell and bookmarks.
For usage, execute without arguments."
  (setq args (eshell-flatten-list args))
  (let ((bookmark (car args))
        filename name)
    (if (eq nil args)
	(eshell/bmk-usage)
      ;; Check whether an existing bookmark has been specified
      (if (setq filename (cdr (car (bookmark-get-bookmark-record bookmark))))
	  ;; If it points to a directory, change to it.
	  (if (file-directory-p filename)
	      (eshell/cd filename)
	    ;; otherwise, just jump to the bookmark 
	    (bookmark-jump bookmark))
	(error "%s is not a bookmark" bookmark)))))

(defun eshell/bmk-usage ()
  	(format "Usage: 
bmk BOOKMARK

either change directory pointed to by BOOKMARK
or bookmark-jump to the BOOKMARK if it is not a directory.

Use bmk-add BOOKMARK to add bookmarks.

Completion is available."))
	
(defun eshell/bmk-add (&rest args)
  (if (setq name (car args))
      (progn
	(bookmark-set name)
	(bookmark-set-filename name (eshell/pwd))
	(format "Saved current directory in bookmark as '%s'" name))
    (error "You must enter a bookmark name")))

(provide 'eshellbmk)
