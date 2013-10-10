(defun apg ()
  "Insert a random password at point. Requires apg in the $PATH"
  (interactive)
  (let ((password))
    (save-excursion
      (let ((buffer "*passwords*"))
	(shell-command "apg" buffer)
	(switch-to-buffer buffer)
	(let* ((beg (goto-char (point-max))))
	  (forward-line -2)
	  (setq password (buffer-substring beg (point))))
	(kill-buffer buffer)))
    (insert password)))

(provide 'nico-apg)
