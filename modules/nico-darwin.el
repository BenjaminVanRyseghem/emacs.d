(defun system-type-is-darwin ()
  (interactive)
  "Return true if system is darwin-based (Mac OS X)"
  (string-equal system-type "darwin"))

(if (system-type-is-darwin)
    (progn
      (setenv "PATH" (concat "/usr/local/texlive/2011/bin/universal-darwin:" "/usr/local/bin:" "/usr/local/sbin:" "/opt/local/bin:" "/Users/nico/bin:" (getenv "PATH")))

      ;;Use cmd key as meta and keep alt key for special chars
      (setq mac-option-key-is-meta nil)
      (setq mac-command-key-is-meta t)
      (setq mac-command-modifier 'meta)
      (setq mac-option-modifier nil)))

(provide 'nico-darwin)
