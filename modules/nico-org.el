;; org-mode

(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list
			"~/org/notes.org"
			"~/org/work.org"
			"~/org/calendar.org" 
			"~/org/home.org"))

;; Open notes (notes.org) file
(global-set-key (kbd "C-M-n") 'nico/find-notes-file)

(defun nico/find-notes-file ()
  (interactive)
  (find-file "~/org/notes.org"))

;; My own todo keywords and their shortcuts
(setq org-todo-keywords
       '((sequence "TODO(t)" "|" "DONE(d)")
       (sequence "FEATURE(f)" "|" "COMPLETED(c)")
       (sequence "BUG(b)" "|" "FIXED(x)")
       (sequence "APPT(p)" "|" "CANCELED(a)")
       (sequence "WAITING(w)" "|")))


;; Automatic export in ~/Public for org files. 
(defun nico/automatic-org-export-as-html ()
  (if (string-match "^/Users/nico/org/.*" (buffer-file-name))
      (org-export-as-html 3 nil nil nil nil "~/Public/org/")))

;; Automatic iCal export
(defun nico/automatic-org-export-as-ical ()
  (if (string-match "^/Users/nico/org/.*" (buffer-file-name))
      (progn
	(org-export-icalendar-this-file)
	(org-export-icalendar-all-agenda-files))))

;; Export TODO items in iCal too
(setq org-icalendar-include-todo t)

(add-hook 'after-save-hook 'nico/automatic-org-export-as-html)
;; Disabled as I don't use it currently
;; (add-hook 'after-save-hook 'automatic-org-export-as-ical)

;; My blog settings. Jekyll + org-mode
(defun nico/automatic-org-blog-export-as-html ()
  (if (string-match "^/Users/nico/work/nicolas-petton.fr/org/.*" (buffer-file-name))
      (org-export-as-html 3 nil nil nil t "~/work/nicolas-petton.fr/jekyll/_posts/")))

(add-hook 'after-save-hook 'nico/automatic-org-blog-export-as-html)


;;Org-contacts
(require 'org-contacts)
(defvar org-contacts-files '("~/org/contacts.org"))

;; Org-capture
(define-key global-map "\C-cc" 'org-capture)

(setf org-default-notes-file "~/org/notes.org")
(defvar nico/org-email-file "~/org/emails.org")

(add-to-list 'org-capture-templates
             '("c" "Contacts" entry (file (car org-contacts-files))
               "* %(org-contacts-template-name)
                  :PROPERTIES:
                  :EMAIL: %(org-contacts-template-email)
                  :END:"))
(add-to-list 'org-capture-templates
	     '("t" "Todo" entry (file+headline org-default-notes-file "Tasks")
	       "* TODO %i %? \n  %a"))
(add-to-list 'org-capture-templates
	     '("h" "Home" entry (file "~/org/home.org")
	       "* %i %?  \n  %a\n"))
(add-to-list 'org-capture-templates
	     '("s" "Cool stuff" entry (file+headline org-default-notes-file "Cool stuff")
	       "* %i %?   \n  %a\n"))
(add-to-list 'org-capture-templates
	     '("a" "Email Action" entry (file+headline nico/org-email-file "Actions")
	       "* TODO %i %?   \n  %a\n  %U"))
(add-to-list 'org-capture-templates
	     '("i" "Email Tickler" entry (file nico/org-email-file "Tickler")
	       "* TODO %i %?   \n  %a\n  %U"))
(add-to-list 'org-capture-templates
	     '("w" "Email Waiting Answer" entry (file+headline nico/org-email-file "Waiting")
	       "* WAITING %i %?   \n  %a\n  %U"))

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

;; Start emacs with my agenda list
(org-agenda-list)

(provide 'nico-org)
