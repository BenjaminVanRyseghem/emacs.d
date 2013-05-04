;; Download and unzip pharo images

(defcustom pharo-image-url "http://files.pharo.org/image/"
  "Url path to Pharo images")

(defcustom pharo-images-directory "~/work/smalltalk/"
  "Base path of the pharo images")
 
(defun pharo-get (name version)
  "Download and unzip a new pharo image, then open a dired buffer on the directory"
  (interactive (list 
		(read-string "Name: " "")
		(completing-read "Version :" '("14" "20" "30"))))
  (let* ((filename "pharo.zip")
	 (directory (concat pharo-images-directory name))
	 (path (concat directory "/" filename)))
    (if (file-exists-p directory)
	(error "Path already exists. Choose another name"))
    (make-directory directory t)
    (url-copy-file (concat pharo-image-url version "/latest.zip") path t)
    (dired directory)
    (shell-command (concat "unzip " filename))
    (revert-buffer)))

(provide 'nico-pharo-get)
