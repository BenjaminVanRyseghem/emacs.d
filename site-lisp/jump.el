;; jump.el -- Fast cd between bookmarks 
;;
;; Copyright (c) 2012 Nicolas Petton <petton.nicolas@gmail.com>
;; Licensed under MIT
;;
;; This file is NOT part of GNU Emacs.


(defcustom jump-file "~/.emacs.d/jump-bookmarks.el"
  "Jump bookmarks file")

;; default bookmarks alist
(defvar jump-bookmarks-alist '())

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
       (message (concat "No bookmark for " path)))) (jump-bookmarks path) path))

(defun jump-add (path bookmark)
  (setf jump-bookmarks-alist (cons (list bookmark path) jump-bookmarks-alist))
  (jump-dump-bookmarks))

(defun jump-remove (bookmark)
  (setf jump-bookmarks-alist (assoc bookmark jump-bookmarks-alist))
  (jump-dump-bookmarks))

(defun jump-dump-bookmarks ()
  (write-region (concat "(setq jump-bookmarks-alist '" (prin1-to-string jump-bookmarks-alist) ")") 
		nil 
		jump-file))

(defun jump-bookmarks (path)
  (cdr (assoc path jump-bookmarks-alist)))

;; read from file at start-up
(if (file-exists-p jump-file)
    (load-file jump-file))

(provide 'jump)
