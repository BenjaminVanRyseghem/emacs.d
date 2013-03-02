;; Download and unzip pharo images

(defcustom pharo-retrieve-url "http://pharo.gforge.inria.fr/ci/image/20/latest.zip"
  "Url path to the latest Pharo image")

(defcustom pharo-images-directory "~/work/smalltalk/"
  "Base path of the pharo images")

(defun pharo-get (name)
  "Download and unzip a new pharo image, then open a dired buffer on the directory"
  (interactive "sName: ")
  (let* ((filename "pharo.zip")
	 (directory (concat pharo-images-directory name))
	 (path (concat directory "/" filename)))
    (if (file-exists-p directory)
	(error "Path already exists. Choose another name"))
    (make-directory directory t)
    (url-copy-file pharo-retrieve-url path t)
    (dired directory)
    (shell-command (concat "unzip " filename))
    (revert-buffer)))

(provide 'nico-pharo-get)
