(require 'org)
(require 'org-mobile)
(require 'org-pomodoro)
(require 'google-maps)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cb" 'org-iswitchb)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cp" 'org-pomodoro)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t)))

(setq org-default-notes-file "~/org/inbox.org")
(defvar nico/org-calendar-file "~/org/calendar.org")
(defvar nico/org-log-file "~/org/log.org")

(setq org-agenda-files `(,org-default-notes-file
			 ,nico/org-calendar-file
			 "~/org/work.org"
			 "~/org/home.org"
			 "~/org/stuff.org"
			 "~/org/someday.org"))

(setq org-refile-targets `(("~/org/work.org" :maxlevel . 3)
			   ("~/org/home.org" :maxlevel . 3)
			   ("~/org/someday.org" :level . 1)
			   (,nico/org-calendar-file :level . 1)))

;; MobileOrg
(setq org-mobile-directory "~/Ubuntu One/MobileOrg")
;; run org-mobile-pull at startup
(org-mobile-pull)


(defun nico/find-notes-file ()
  (interactive)
  (find-file org-default-notes-file))

(defun nico/org-export-agenda ()
  (interactive)
  (org-agenda-write "~/Public/org/agenda.html"))

;; Export TODO items in iCal too
(setq org-icalendar-include-todo t)

;; org-capture
(setq org-capture-templates '())
(add-to-list 'org-capture-templates
	     '("t" "Todo [inbox]" entry (file+headline org-default-notes-file "Tasks")
	       "* TODO %i%?"))
(add-to-list 'org-capture-templates
	     '("l" "Todo [inbox]" entry (file+headline org-default-notes-file "Tasks")
	       "* TODO %a"))
;; taken from http://doc.norang.ca/org-mode.html
(add-to-list 'org-capture-templates
	      '("r" "Respond to Phone" entry (file+headline org-default-notes-file "Tasks")
		"* DONE %? :PHONE:\n%U" :clock-in t :clock-resume t))
(add-to-list 'org-capture-templates
	     '("s" "Cool stuff" entry (file+headline org-default-notes-file "Cool stuff")
	       "* %i%?"))
(add-to-list 'org-capture-templates
	     '("p" "Appointment" entry (file+headline nico/org-calendar-file "Appointment")
	       "* APPT %i%? \n %U"))

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
      calendar-holidays french-holiday
      calendar-mark-holidays-flag t)

;; Org-agenda notify appointements
(defun nico/notify-appt (time-to-appt new-time msg)
  (notify
   (format "Appointement in %s minute(s)" min-to-app)
   msg
   :icon "/usr/share/icons/gnome/32x32/status/appointment-soon.png"))

;; Keep the next 2
(setq appt-audible nil
      appt-message-warning-time 30
      appt-display-format 'window
      appt-disp-window-function 'nico/notify-appt)

;; Run once, activate and schedule refresh
(defun nico/check-appt ()
  (org-agenda-to-appt t '((headline "APPT"))))

(appt-activate t)
(nico/check-appt)

(run-at-time nil 3600 'nico/check-appt)

;; Display the agenda
(defun nico/jump-to-org-agenda ()
  (interactive)
  (let ((buffer (get-buffer "*Org Agenda*")))
    (if buffer
	(switch-to-buffer buffer)
      (org-agenda-list))
    (delete-other-windows)))

;; Go to the agenda buffer after 10' idle
(run-with-idle-timer 600 t 'nico/jump-to-org-agenda)

;; GDT next actions
(defun nico/org-gtd-next ()
  "Switch the next undone heading to NEXT state (if not at the last one)."
  (interactive)
  (save-excursion
    (widen)
    (org-back-to-heading)
    (let ((level (outline-level))
	  (found-next))
      (outline-next-heading)
      (while (and (= level (outline-level))
		  (not found-next))
	(if (org-entry-is-todo-p)
	    (progn
	      (setq found-next t)
	      (org-todo "NEXT"))
	  (outline-next-heading))))))

(defun nico/org-gtd-mark-next (changes-plist)
  (let ((from (plist-get change-plist :from))
	(to (plist-get change-plist :to)))
    (when (and (string-equal from "NEXT")
	       (member to org-done-keywords))
      (nico/org-gtd-next))))

(setq org-trigger-hook nil)
(add-hook 'org-trigger-hook 'nico/org-gtd-mark-next)

;; Archive all DONE entries
(defun nico/org-archive-done-subtree ()
  (interactive)
  (org-map-entries 'org-archive-subtree "/DONE" 'tree))

;; Custom agenda function, see customized 'org-agenda-custom-commands.
;; Open the agenda in org-agenda-log-mode, with the archive file, and
;; for the previous week. To work well, 'org-log-done should be set to
;; 't, to ensure that everything is in the agenda.
(defun nico/org-agenda-log (arg)
  (let ((org-agenda-files org-agenda-files))
    (add-to-list 'org-agenda-files "~/org/work.org_archive")
    (add-to-list 'org-agenda-files "~/org/calendar.org_archive")
    (org-agenda-list arg)
    (org-agenda-log-mode)
    (org-agenda-earlier 1)))

(nico/jump-to-org-agenda)

(provide 'nico-org)
