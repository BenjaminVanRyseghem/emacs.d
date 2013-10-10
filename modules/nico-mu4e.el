(require 'mu4e)
(require 'smtpmail)
(require 'org-mu4e)

(define-key global-map (kbd "M-N") 'mu4e)

;; save attachment to my desktop (this can also be a function)
(setq mu4e-attachment-dir "~/Desktop")

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

;; attempt to show images when viewing messages
(setq mu4e-view-show-images t
      mu4e-view-image-max-width 800)

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

(setq mu4e-msg2pdf "/usr/bin/msg2pdf")
(setq mu4e-get-mail-command "offlineimap")

(setq message-send-mail-function 'smtpmail-send-it
      user-full-name "Nicolas Petton"
      starttls-use-gnutls t)

(defvar nico/mu4e-account-alist
  '(("Gmail"
     (user-mail-address "petton.nicolas@gmail.com")
     (smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil)))
     (smtpmail-auth-credentials
      '(("smtp.gmail.com" 587 "petton.nicolas@gmail.com" nil)))
     (smtpmail-default-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-service 587)
     (message-signature-file "~/.signature-gmail"))
    ("Objectfusion"
     (user-mail-address "nico@objectfusion.fr")
     (smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil)))
     (smtpmail-auth-credentials
      '(("smtp.gmail.com" 587 "petton.nicolas@gmail.com" nil)))
     (smtpmail-default-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-service 587)
     (message-signature-file "~/.signature-objectfusion"))))

(defun nico/mu4e-set-account ()
  "Set the account for composing a message. 
   Try to match the current maildir or ask for the account name"
  (let* ((account
	  (if mu4e-compose-parent-message
	      (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
		(string-match "/\\(.*?\\)/" maildir)
		(match-string 1 maildir))
	    (nico/select-mail-account))))
    (nico/setup-mail-account account)))

(defun nico/select-mail-account ()
  (interactive)
  (completing-read (format "Compose with account: (%s) "
			   (mapconcat #'(lambda (var) (car var)) nico/mu4e-account-alist "/"))
		   (mapcar #'(lambda (var) (car var)) nico/mu4e-account-alist)
		   nil t nil nil (caar nico/mu4e-account-alist)))

(defun nico/setup-mail-account (account)
  (let ((account-vars (cdr (assoc account nico/mu4e-account-alist))))
    (mapc #'(lambda (var)
	      (set (car var) (cadr var)))
	  account-vars)))

(nico/setup-mail-account "Gmail")
(add-hook 'mu4e-compose-pre-hook 'nico/mu4e-set-account)


;;  message-mode and dired
(require 'gnus-dired)

;; make the `gnus-dired-mail-buffers' function also work on
;; message-mode derived modes
(defun gnus-dired-mail-buffers ()
  "Return a list of active message buffers."
  (let (buffers)
    (save-current-buffer
      (dolist (buffer (buffer-list t))
     	(set-buffer buffer)
     	(when (and (derived-mode-p 'message-mode)
		   (null message-sent-message-via))
     	  (push (buffer-name buffer) buffers))))
    (nreverse buffers)))

(setq gnus-dired-mail-mode 'message-mode)
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)


(add-to-list 'mu4e-view-actions
   '("View in browser" . mu4e-action-view-in-browser) t)

;; ASynK
;; (defun asynk ()
;;   (interactive)
;;   (async-shell-command "python ~/build/ASynK/asynk.py --op=sync --name 'gmail'" ))

(provide 'nico-mu4e)
