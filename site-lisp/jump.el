;; Quick cd between bookmarks 

;; Jump bookmarks file
(setf jump-file "~/.emacs.d/jump-bookmarks.el")

;; eshell commands
(defun eshell/jump (path)
  (jump path))
(defun eshell/jump-add (bookmark)
  (jump-add (eshell/pwd) bookmark))
(defun eshell/jump-remove (bookmark)
  (jump-remove bookmark))

(defun jump (path)
  "jump to a specified bookmark"
  ((lambda (mark path)
     (if mark
	 (eshell/cd mark)
       (message (concat "No bookmark for " path)))) (bookmarks path) path))

(defun jump-add (path bookmark)
  (setf jump-bookmarks-alist (cons (list bookmark path) jump-bookmarks-alist))
  (dump-bookmarks))

(defun jump-remove (bookmark)
  (setf jump-bookmarks-alist (assoc bookmark jump-bookmarks-alist))
  (dump-bookmarks))

(defun dump-bookmarks ()
  (write-region (concat "(setq jump-bookmarks-alist '" (prin1-to-string jump-bookmarks-alist) ")") 
		nil 
		jump-file))

(defun bookmarks (path)
  (cdr (assoc path jump-bookmarks-alist)))

;; default bookmarks alist
(setf jump-bookmarks-alist '())

;; read from file at start-up
(load-file jump-file)

(provide 'jump)
