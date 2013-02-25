(require 'org)
(require 'org-mobile)
(require 'org-capture)
(require 'org-mac-link-grabber)

(add-hook 'org-mode-hook 
	  (lambda () 
	    (define-key org-mode-map (kbd "C-c g") 'omlg-grab-link)))

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cb" 'org-iswitchb)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cg" 'omlg-grab-link)


;; MobileOrg
(setq org-mobile-directory "~/Dropbox/MobileOrg")
(org-mobile-pull) ;; run org-mobile-pull at startup


(defvar org-mobile-push-timer nil
  "Timer that `org-mobile-push-timer' used to reschedule itself, or nil.")

(defun org-mobile-push-with-delay (secs)
  (when org-mobile-push-timer
    (cancel-timer org-mobile-push-timer))
  (setq org-mobile-push-timer
        (run-with-idle-timer
         (* 1 secs) nil 'org-mobile-push)))

(add-hook 'after-save-hook 
	  (lambda () 
	    (when (eq major-mode 'org-mode)
	      (dolist (file (org-mobile-files-alist))
		(if (string= (expand-file-name (car file)) (buffer-file-name))
		    (org-mobile-push-with-delay 30))))))


(run-with-timer 0 360 'org-mobile-pull)

;;Org-notmuch
;; (require 'org-notmuch)

(setf org-default-notes-file "~/org/inbox.org")
(defvar nico/org-email-file "~/org/emails.org")
(defvar nico/org-calendar-file "~/org/calendar.org")


(setq org-directory "~/org")
;; (setq org-mobile-inbox-for-pull "~/org/flagged.org")
;; (setq org-mobile-directory "~/Dropbox/MobileOrg")

(setq org-agenda-files (list
			nico/org-email-file
			org-default-notes-file
			nico/org-calendar-file
			"~/org/work.org"
			"~/org/home.org"
			"~/org/stuff.org"))

(setq org-refile-targets '(("~/org/work.org" :maxlevel . 3) 
			   ("~/org/home.org" :maxlevel . 3)
			   ("~/org/someday.org" :level . 1)))

;; Open notes (notes.org) file
(global-set-key (kbd "C-M-n") 'nico/find-notes-file)

(defun nico/find-notes-file ()
  (interactive)
  (find-file org-default-notes-file))

;; My own todo keywords and their shortcuts
(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)")
	(sequence "FEATURE(f)" "|" "COMPLETED(c)")
	(sequence "BUG(b)" "|" "FIXED(x)")
	(sequence "APPT(p)" "|" "CANCELED(a)")
	(sequence "WAITING(w)" "|")))

;; Automatic export in ~/Public for org files. 
(defun nico/automatic-org-export-as-html ()
  (if (string-match "^/home/nico/org/.*" (buffer-file-name))
      (org-export-as-html 3 nil nil nil nil "~/Public/org/")))

;; Automatic iCal export
(defun nico/automatic-org-export-as-ical ()
  (if (string-match "^/home/nico/org/.*" (buffer-file-name))
      (progn
	(org-export-icalendar-this-file)
	(org-export-icalendar-all-agenda-files))))

(defun nico/org-export-agenda ()
  (org-agenda-write "~/Public/org/agenda.html"))

;; Export the agenda
;; (run-at-time nil 3600 'nico/org-export-agenda)

;; Export TODO items in iCal too
(setq org-icalendar-include-todo t)

;; Disabled as I don't use it currently
;; (add-hook 'after-save-hook 'nico/automatic-org-export-as-html)
;; (add-hook 'after-save-hook 'automatic-org-export-as-ical)

;; My blog settings. Jekyll + org-mode
(defun nico/automatic-org-blog-export-as-html ()
  (if (string-match "^/home/nico/work/nicolas-petton.fr/org/.*" (buffer-file-name))
      (org-export-as-html 3 nil nil nil t "~/work/nicolas-petton.fr/jekyll/_posts/")))

(add-hook 'after-save-hook 'nico/automatic-org-blog-export-as-html)

;; org-capture
(setq org-capture-templates '())
             ;; '(("c" "Contacts" entry (file (car org-contacts-files))
             ;;   "* %(org-contacts-template-name)
             ;;      :PROPERTIES:
             ;;      :EMAIL: %(org-contacts-template-email)
             ;;      :END:")))
(add-to-list 'org-capture-templates
	     '("t" "Todo [inbox]" entry (file+headline org-default-notes-file "Tasks")
	       "* TODO %i %? \n  %a"))
(add-to-list 'org-capture-templates
	     '("h" "Home" entry (file "~/org/home.org")
	       "* %i %?  \n  %a\n"))
(add-to-list 'org-capture-templates
	     '("s" "Cool stuff" entry (file+headline org-default-notes-file "Cool stuff")
	       "* %i %?   \n  %a\n"))
(add-to-list 'org-capture-templates
	     '("a" "Action [email]" entry (file+headline nico/org-email-file "Actions")
	       "* TODO %i %?   \n  %a\n"))
(add-to-list 'org-capture-templates
	     '("i" "Tickler [email]" entry (file+headline nico/org-email-file "Tickler")
	       "* %i %?   \n  %a"))
(add-to-list 'org-capture-templates
	     '("w" "Waiting Answer [email]" entry (file+headline nico/org-email-file "Waiting")
	       "* WAITING %i %?   \n  %a\n  %U"))

(add-to-list 'org-capture-templates
	     '("p" "Appointment" entry (file+headline nico/org-calendar-file "Appointment")
	       "* APPT %i %?   \n  %a\n  %U"))


(defvar french-holiday
      '((holiday-fixed 1 1 "Jour de l'an")
        (holiday-fixed 5 1 "Fête du travail")
        (holiday-fixed 5 8 "Victoire 45")
        (holiday-fixed 7 14 "Fête nationale")
        (holiday-fixed 8 15 "Assomption")
        (holiday-fixed 11 1 "Toussaint")
        (holiday-fixed 11 11 "Armistice 18")
        (holiday-fixed 12 25 "Noël")
        (holiday-easter-etc 1 "Lundi de Pâques")
        (holiday-easter-etc 39 "Ascension")
        (holiday-easter-etc 50 "Lundi de Pentecôte")))

(setq calendar-date-style 'european
      calendar-holidays (append french-holiday)
      calendar-mark-holidays-flag t)

;; Org-agenda and Emacs appointments

(defun nico/notify-appt (time-to-appt new-time msg)
  (notify "Appt. Reminder" msg))

(setq appt-audible nil
      appt-message-warning-time 30
      appt-display-format 'window
      appt-disp-window-function 'nico/notify-appt)

;; Run once, activate and schedule refresh
(defun nico/check-appt ()
  (org-agenda-to-appt t '((headline "APPT"))))
(nico/check-appt)

(run-at-time nil 3600 'nico/check-appt)
(appt-activate t)

;; Pomodoro timer
(setq org-timer-default-timer 25)

;; Use Google-weather in agenda view
;; (require 'google-weather)
;; (require 'org-google-weather)
;; (setq org-google-weather-icon-directory "~/.emacs.d/icons")

;; Icons for categories
;; (setq org-agenda-category-icon-alist
;;       '(("notes" "~/.emacs.d/icons/notes.png" nil nil :ascent center)
;; 	("work" "~/.emacs.d/icons/work.png" nil nil :ascent center)
;; 	("contacts" "~/.emacs.d/icons/cake.png" nil nil :ascent center)
;; 	("calendar" "~/.emacs.d/icons/calendar.png" nil nil :ascent center)))

(provide 'nico-org)
