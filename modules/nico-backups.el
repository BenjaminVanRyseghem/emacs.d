;; Put backup and auto-save files in /tmp

(defvar nico/backup-directory "~/.tmp/"
  "The directory to put autosave and backup files")

(setq backup-directory-alist
      `((".*" . ,nico/backup-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,nico/backup-directory t)))

(provide 'nico-backups)
