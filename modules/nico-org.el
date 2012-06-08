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
       (sequence "APPT(p)" "|" "CANCELED(a)")))


;; Automatic export in ~/Public for org files. 
(defun nico/automatic-org-export-as-html ()
  (if (string-match "^/Users/nico/org/.*" (buffer-file-name))
      (org-export-as-html 3 nil nil nil nil "~/Public/org/")))

;; Automatic iCal export
(defun nico/automatic-org-export-as-ical ()
  (if (string-match "^/Users/nico/org/.*" (buffer-file-name))
      (org-export-icalendar-this-file)))

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


;; Org-capture
(setf org-default-notes-file "~/org/notes.org")
(define-key global-map "\C-cc" 'org-capture)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/notes.org" "Tasks")
             "* TODO %i %? \n  %a")))

;;Org-contacts
(require 'org-contacts)
(defvar org-contacts-files '("~/org/contacts.org"))
(add-to-list 'org-capture-templates
             '("c" "Contacts" entry (file (car org-contacts-files))
               "* %(org-contacts-template-name)
                  :PROPERTIES:
                  :EMAIL: %(org-contacts-template-email)
                  :END:"))

;; Other org-capture templates
(setq nico/org-email-file '("~/org/emails.org"))
(add-to-list 'org-capture-templates
	     '("a" "Email Action" entry (file+headline (car nico/org-email-file) "Actions")
	       "* TODO %i %?   :email:action:\n  %a\n  %U"))
(add-to-list 'org-capture-templates
	     '("i" "Email Tickler" entry (file (car nico/org-email-file) "Tickler")
	       "* TODO %i %?   :email:answer:\n  %a\n  %U"))
(add-to-list 'org-capture-templates
	     '("w" "Email Waiting Answer" entry (file+headline (car nico/org-email-file) "Waiting")
	       "* TODO %i %?   :email:waiting:\n  %a\n  %U"))

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
