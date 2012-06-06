(setq send-mail-function 'smtpmail-send-it
      user-full-name "Nicolas Petton"
      user-mail-address "petton.nicolas@gmail.com"
      message-send-mail-function 'smtpmail-send-it
      mail-from-style nil)

(add-hook 'gnus-group-mode-hook 'nico/setup-gnus)

(defun nico/setup-gnus () 
  (require 'offlineimap)
  (offlineimap)
  (gnus-topic-mode)
  (gnus-group-sort-groups-by-alphabet)
  (setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\”]\”[#’()]")
  ;; Kill message buffer after sending the message
  (setq message-kill-buffer-on-exit t)
  ;; Check new news every 5 minutes if idle for at least 2'
  (gnus-demon-add-handler 'gnus-group-get-new-news 5 2))

;; Accounts setup
(setq gnus-select-method 
      '(nnnil ""))

;; Imap search see http://www.emacswiki.org/emacs/GnusGmail#toc18
(require 'nnir)

(setq gnus-secondary-select-methods
      '((nnimap "Mail"
		(nnimap-address "localhost")  
		(nnimap-stream network)
		(nnimap-authenticator login))
	(nnimap "objectfusion"
		(nnimap-address "imap.gmail.com")
		(nnimap-inbox "objectfusion")
		(nnimap-server-port 993)
		(nnir-search-engine imap)
		(nnimap-stream ssl))))


;; Use msmtp
(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "/usr/local/bin/msmtp")
(setq message-sendmail-extra-arguments '("-a" "gmail"))

(setq gnus-parameters
      '(("nnimap\\+Mail:.*"
         ;;(display . all)
         (posting-style
          (name "Nicolas Petton")
          (address "petton.nicolas@gmail.com")
          (eval (setq message-sendmail-extra-arguments '("-a" "gmail")))
	 (signature-file "~/.signature-gmail")))
	("nnimap\\+objectfusion:.*"
         ;;(display . all)
         (posting-style
          (name "Nicolas Petton")
          (address "nico@objectfusion.fr")
          (organization "S.A.R.L. Objectfusion")
          (eval (setq message-sendmail-extra-arguments '("-a" "objectfusion")))
	 (signature-file "~/.signature-objectfusion")))))


;; Scores configuration
(setq gnus-use-adaptive-scoring t)
(setq gnus-score-expiry-days 14)
(setq gnus-default-adaptive-score-alist
      '((gnus-unread-mark)
	(gnus-ticked-mark (from 10))
	;;(gnus-dormant-mark (from 5))
	(gnus-saved-mark (from 20) (subject 5))
	(gnus-del-mark (from -2) (subject -50))
	(gnus-read-mark (from 2) (subject 1))
	(gnus-killed-mark (from 0) (subject -3))))


;; sort by reverse score, then by subject, and finally by number
;; see http://www.gnu.org/software/emacs/manual/html_node/gnus/Sorting-the-Summary-Buffer.html
(setq gnus-thread-sort-functions
      '(gnus-thread-sort-by-number
	gnus-thread-sort-by-subject
	(not gnus-thread-sort-by-total-score)))


;; 3 panes
(gnus-add-configuration
 '(article
   (horizontal 1.0
	       (vertical 60 (group 1.0))
	       (vertical 1.0
			 (summary 0.20 point)
			 (article 1.0)))))
(gnus-add-configuration
 '(summary
   (horizontal 1.0
	       (vertical 60 (group 1.0))
	       (vertical 1.0 (summary 1.0 point)))))

