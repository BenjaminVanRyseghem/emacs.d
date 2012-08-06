(require 'notmuch)
(require 'offlineimap)
(require 'gnus-art)
(offlineimap)

(setq send-mail-function 'smtpmail-send-it
      user-full-name "Nicolas Petton"
      user-mail-address "petton.nicolas@gmail.com"
      sendmail-program "/usr/local/bin/msmtp"
      message-send-mail-function 'message-send-mail-with-sendmail
      ;; These 3 lines make notmuch switch msmtp accounts based on the from header
      mail-specify-envelope-from t
      message-sendmail-envelope-from 'header
      mail-envelope-from 'header
      mail-from-style nil)


(defvar nico/email-accounts 
  '()
  "Email SMTP Accounts. Each account is an alist.")

(setq nico/email-accounts
  '(("petton.nicolas@gmail.com" . ((signature . "~/.signature-gmail")
				   (smtp . "gmail")))
    ("nico@objectfusion.fr" . ((signature . "~/.signature-objectfusion")
			       (smtp . "objectfusion")))))


(defun nico/select-email-account (name)
  "Select the smtp account to be used to send messages."
  (interactive (list
		(completing-read "Select account: " 
				 (mapcar (lambda (each) (car each))
					 nico/email-accounts))))
  (let ((account nil))
    (dolist (each nico/email-accounts) 
      (if (string-match (car each) name)
	  (setq account each)))
    (message (concat "Using email account " (car account)))
    (if account
	(setq user-email-address (car account)
	      message-signature-file (cdr (assoc 'signature account))
	      message-sendmail-extra-arguments (list "-a" (cdr (assoc 'smtp account)))))))
    
  
;; Default email account
(nico/select-email-account "petton.nicolas@gmail.com")

(defun nico/automatic-account ()
  "Automatic smtp account selection based on the from header of the current message"
  (if (message-mail-p)
      (save-excursion
	(let ((from
		(save-restriction
		  (message-narrow-to-headers)
		  (message-fetch-field "from"))))
	  (nico/select-email-account from)
	  (nico/update-message)))))

(defun nico/update-message ()
  "Update the signature from the current account"
  (save-excursion
      (message-goto-signature)
      (previous-line)
      (let ((position (point)))
	(end-of-buffer)
	(delete-region position (point)))
      (message-insert-signature)))

(add-hook 'message-setup-hook 'nico/automatic-account)
(add-hook 'notmuch-hello-mode-hook 'nico/setup-notmuch)

(defun nico/setup-notmuch ()
  (require 'offlineimap)
  (offlineimap)
  
  (define-key notmuch-hello-mode-map (kbd "C-c C-c") 'nico/notmuch-update-all)
  (define-key notmuch-hello-mode-map (kbd "C-c C-u") 'nico/notmuch-update)
  
  (define-key notmuch-search-mode-map "d" 'nico/notmuch-search-tag-read)
  (define-key notmuch-search-mode-map "c" 'nico/notmuch-search-tag-all-read)
  (define-key notmuch-search-mode-map "u" 'nico/notmuch-search-tag-unread)
  (define-key notmuch-search-mode-map "i" 'nico/notmuch-search-tag-important))
  
(defun nico/notmuch-search-tag (tags)
  (notmuch-search-tag tags)
  (next-line))

(defun nico/notmuch-search-tag-read ()
  (interactive)
  (nico/notmuch-search-tag '("-unread")))

(defun nico/notmuch-search-tag-all-read (confirmation)
  (interactive (list (read-string "Mark all threads as read? y/(n) ")))
  (if (string-equal confirmation "y")
      (progn
       (notmuch-search-tag-all '("-unread"))
       (notmuch-search-quit))))

(defun nico/notmuch-search-tag-unread ()
  (interactive)
  (nico/notmuch-search-tag '("+unread")))

(defun nico/notmuch-search-tag-important ()
  (interactive)
  (nico/notmuch-search-tag '("+important")))

(defun nico/notmuch-update-all ()
  (interactive)
  (offlineimap-resync)
  (nico/notmuch-update))

(defun nico/notmuch-update ()
  (interactive)
  (notmuch-poll)
  (notmuch-hello-update))

;; notmuch searches
(setq notmuch-saved-searches '(("inbox" . "tag:inbox") 
			       ("important" . "tag:important")
			       ("unread" . "tag:unread") 
			       ("sent" . "from:petton.nicolas@gmail.com or from:nico@objectfusion.fr")
			       ("Pharo" . "folder:Smalltalk.Pharo AND tag:unread") 
			       ("Amber" . "folder:Smalltalk.Amber AND tag:unread") 
			       ("RMoD" . "folder:rmod AND tag:unread")
			       ("smalltalkhub" . "smalltalkhub and tag:unread")
			       ("gst" . "from:help-smalltalk@gnu.org and tag:unread")
			       ("squeak" . "to:squeak-dev@lists.squeakfoundation.org and tag:unread") 
			       ("riak" . "to:riak-users <riak-users@lists.basho.com> and tag:unread") 
			       ("seaside" . "to:seaside@lists.squeakfoundation.org and tag:unread")))

(provide 'nico-notmuch)
