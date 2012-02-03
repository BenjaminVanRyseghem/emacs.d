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
