;; org-mode

(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list "~/org/index.org"
			     "~/org/work.org"
                             "~/org/meetings.org" 
                             "~/org/home.org"))


;; My own todo keywords and their shortcuts
(setq org-todo-keywords
       '((sequence "TODO(t)" "|" "DONE(d)")
       (sequence "FEATURE(f)" "|" "COMPLETED(c)")
       (sequence "BUG(b)" "|" "FIXED(x)")
       (sequence "|" "CANCELED(a)")))


;; Automatic export in ~/Public for org files. 
(defun automatic-org-export-as-html ()
  (if (string-match "^/home/nico/org/.*" (buffer-file-name))
      (org-export-as-html 3 nil nil nil nil "~/Public/org/")))

(add-hook 'after-save-hook 'automatic-org-export-as-html)


;; My blog settings. Jekyll + org-mode
(defun automatic-org-blog-export-as-html ()
  (if (string-match "^/home/nico/projects/nicolas-petton.fr/org/.*" (buffer-file-name))
      (org-export-as-html 3 nil nil nil t "~/projects/nicolas-petton.fr/jekyll/_posts/")))

(add-hook 'after-save-hook 'automatic-org-blog-export-as-html)


;; (setq org-publish-project-alist
;;       '(
	
;; 	("org-nicolas-petton.fr"
;; 	 ;; Path to org files.
;; 	 :base-directory "~/projects/nicolas-petton.fr/org/"
;; 	 :base-extension "org"
	 
;; 	 ;; Path to Jekyll project.
;; 	 :publishing-directory "~/projects/nicolas-petton.fr/jekyll/"
;; 	 :recursive t
;; 	 :publishing-function org-publish-org-to-html
;; 	 :headline-levels 4 
;; 	 :html-extension "html"
;; 	 :body-only t ;; Only export section between <body> </body>
;; 	 )
	
	
;; 	("org-static-nicolas-petton.fr"
;; 	 :base-directory "~/projects/nicolas-petton.fr/org/"
;; 	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf"
;; 	 :publishing-directory "~/projects/nicolas-petton.fr/"
;;           :recursive t
;;           :publishing-function org-publish-attachment)
	
;; 	("nicolas-petton.fr" :components ("org-nicolas-petton.fr" "org-static-nicolas-petton.fr"))
	
;; 	))
