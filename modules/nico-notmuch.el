(require 'notmuch)

(define-key global-map (kbd "M-N") 'notmuch)

(setq send-mail-function 'smtpmail-send-it
      sendmail-program "msmtp"
      message-send-mail-function 'message-send-mail-with-sendmail
      mail-from-style nil
      message-kill-buffer-on-exit t)


(defvar nico/email-accounts 
  '()
  "Email SMTP Accounts. Each account is an alist.")

(setq nico/email-accounts
      '(("petton.nicolas@gmail.com" . ((name . "Nicolas Petton")
				       (signature . "~/.signature-gmail")
				       (smtp . "gmail")))
	("nico@objectfusion.fr" . ((name . "Nicolas Petton")
				   (signature . "~/.signature-objectfusion")
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
	      user-full-name (cdr (assoc 'name account))
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

(defun nico/add-mode-line-account ()
  (add-to-list 'mode-line-buffer-identification 
	       '(:propertize (" " user-email-address " ") face user-email-address)))

(add-hook 'message-setup-hook 'nico/automatic-account)
(add-hook 'message-mode-hook 'nico/add-mode-line-account)

(add-hook 'notmuch-hello-mode-hook 'nico/setup-notmuch)

(defun nico/setup-notmuch ()
  (require 'offlineimap)
  (require 'gnus-art)
  (offlineimap)

  ;; Email addresses autocomptetion based on motmuch db itself
  ;; (require 'notmuch-address)
  ;; (setq notmuch-address-command "~/.emacs.d/bin/nottoomuch-addresses.sh")
  ;; (notmuch-address-message-insinuate)


  (setq offlineimap-enable-mode-line-p '(member
					 major-mode
					 '(offlineimap-mode
					   notmuch-hello-mode)))
  
  (define-key notmuch-hello-mode-map (kbd "C-c C-c") 'nico/notmuch-update-all)
  (define-key notmuch-hello-mode-map (kbd "C-c C-u") 'nico/notmuch-update)
  
  (define-key notmuch-search-mode-map "d" 'nico/notmuch-search-tag-read)
  (define-key notmuch-search-mode-map "t" 'nico/notmuch-search-filter-by-date)
  (define-key notmuch-search-mode-map "c" 'nico/notmuch-search-tag-all-read)
  (define-key notmuch-search-mode-map "u" 'nico/notmuch-search-tag-unread)
  (define-key notmuch-search-mode-map "i" 'nico/notmuch-search-tag-important))

(defun nico/notmuch-search-tag (tags)
  (notmuch-search-tag tags)
  (next-line))

(defun nico/notmuch-search-tag-read ()
  (interactive)
  (nico/notmuch-search-tag "-unread"))

(defun nico/notmuch-search-tag-all-read ()
  (interactive)
  (if (y-or-n-p "Mark all threads as read? ")
      (progn
	(notmuch-search-tag-all '("-unread"))
	(notmuch-search-quit))))

(defun nico/notmuch-search-tag-unread ()
  (interactive)
  (nico/notmuch-search-tag "+unread"))

(defun nico/notmuch-search-tag-important ()
  (interactive)
  (nico/notmuch-search-tag "+important"))

(defun nico/notmuch-search-filter-by-date (days)
  (interactive "NNumber of days to display: ")
  (notmuch-search-filter (nico/notmuch-date-filter days)))

(defun nico/notmuch-date-filter (days)
  (let* ((now (current-time))
	 (begin (time-subtract now (days-to-time days))))
    (concat
     (format-time-string "%s.." begin)
     (format-time-string "%s" now))))
    
(defun nico/notmuch-update ()
  (interactive)
  (notmuch-poll)
  (notmuch-hello-update)
  (nico/update-notmuch-saved-searches))

(defun nico/notmuch-update-all ()
  (interactive)
  (offlineimap-resync)
  (nico/notmuch-update))

;; notmuch searches
(defun nico/update-notmuch-saved-searches ()
  (setq notmuch-saved-searches `(("inbox" . "tag:inbox") 
				 ("important" . "tag:important")
				 ("unread" . "tag:unread")
				 ("today" . ,(nico/notmuch-date-filter 1))
				 ("this week" . ,(nico/notmuch-date-filter 7))
				 ("sent" . "from:petton.nicolas@gmail.com or from:nico@objectfusion.fr")
				 ("Pharo" . "folder:Smalltalk.Pharo AND tag:unread") 
				 ("Amber" . "folder:Smalltalk.Amber AND tag:unread") 
				 ("RMoD" . "folder:rmod AND tag:unread")
				 ("Launchpad" . "from:launchpad AND tag:unread")
				 ("smalltalkhub" . "smalltalkhub and tag:unread")
				 ("gst" . "from:help-smalltalk@gnu.org and tag:unread")
				 ("squeak" . "to:squeak-dev@lists.squeakfoundation.org and tag:unread") 
				 ("riak" . "to:riak-users <riak-users@lists.basho.com> and tag:unread") 
				 ("seaside" . "to:seaside@lists.squeakfoundation.org and tag:unread"))))

(nico/update-notmuch-saved-searches)

;; notmuch-labeler
(require 'notmuch-labeler)
(notmuch-labeler-image-tag "unread")
(notmuch-labeler-image "unread" "~/.emacs.d/el-get/notmuch-labeler/resources/star.svg" 'svg)

(notmuch-labeler-image-tag "important")
(notmuch-labeler-image "important" "~/.emacs.d/el-get/notmuch-labeler/resources/tag.svg" 'svg)

;; notifications
(defvar nico/notmuch-refresh-count 0)

(defun nico/notmuch-refresh-status-message ()
  (unless no-display
    (let* ((new-count
	    (string-to-number
	     (car (process-lines notmuch-command "count"))))
	   (diff-count (- new-count nico/notmuch-refresh-count)))
      (if (> diff-count 0)
	  (notify "New messages"
		  (format "You have %s messages."
			  (notmuch-hello-nice-number diff-count))))
      (setq nico/notmuch-refresh-count new-count))))

(add-hook 'notmuch-hello-refresh-hook 'nico/notmuch-refresh-status-message)

;; ASynK
(defun asynk ()
  (interactive)
  (async-shell-command 
   (concat 
    "python ~/builds/ASynK/asynk.py --op=sync --pwd=" 
    (read-passwd "Password: "))))

(provide 'nico-notmuch)

