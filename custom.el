;; Turn off the annoying bell
(setq ring-bell-function 'ignore)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("6cfe5b2f818c7b52723f3e121d1157cf9d95ed8923dbc1b47f392da80ef7495d" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "d6a00ef5e53adf9b6fe417d2b4404895f26210c52bb8716971be106550cea257" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(flycheck-check-syntax-automatically (quote (save idle-change mode-enabled)))
 '(locate-command "mdfind")
 '(magit-repo-dirs (quote ("/Users/nico/config/" "/Users/nico/work/")))
 '(notmuch-hello-sections (quote (ignore notmuch-hello-insert-saved-searches notmuch-hello-insert-search notmuch-hello-insert-recent-searches notmuch-hello-insert-alltags notmuch-hello-insert-footer)))
 '(org-agenda-custom-commands (quote (("w" . "Work TODO") ("wf" "Foretagsplatsen" tags-todo "+ftgp" nil) ("wb" "Business (objectfusion)" tags-todo "+business" nil) ("wo" "Objectfusion (all)" tags-todo "+objectfusion" nil) ("wa" "Amber" tags-todo "+amber" nil) ("wr" "Resilience" tags-todo "+resilience" nil) ("wi" "RMoD" tags-todo "+rmod" nil) ("wh" "SmalltalkHub" tags-todo "+smalltalkhub" nil) ("n" "Next Actions" todo "NEXT" nil) ("n" . "Next Actions") ("h" "Waiting/hold" ((todo "WAITING" ((org-agenda-overriding-header "Waiting for others"))) (tags "hold" ((org-agenda-overriding-header "On Hold")))) nil) ("d" "30 days deadlines" agenda "" ((org-agenda-entry-types (quote (:deadline))) (org-agenda-overriding-header "Month deadlines") (org-agenda-span (quote month)) (org-agenda-overriding-header ""))) ("." "Short tasks (< 2 min)" tags "short" ((org-agenda-overriding-header "Less than 2 minutes tasks"))))))
 '(org-agenda-default-appointment-duration 60)
 '(org-agenda-span (quote week))
 '(org-export-taskjuggler-target-version 3)
 '(org-habit-graph-column 52)
 '(org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-protocol org-jsinfo org-habit org-irc org-mew org-mhe org-protocol org-rmail org-vm org-wl org-w3m org-bookmark)))
 '(org-stuck-projects (quote ("+LEVEL=2/-DONE" ("TODO" "NEXT") nil "")))
 '(org-todo-keyword-faces (quote (("NEXT" :foreground "orange" :weight bold) ("CANCELLED" :foreground "forest green"))))
 '(org-todo-keywords (quote ((sequence "TODO(t)" "|" "DONE(d)" "CANCELLED(c)") (sequence "NEXT(n)" "|" "DONE(d)" "CANCELLED(c)") (sequence "FEATURE(f)" "|" "COMPLETED(c)") (sequence "BUG(b)" "|" "FIXED(x)") (sequence "APPT(p)" "|" "DONE(d)" "CANCELED(a)") (sequence "WAITING(w)" "|" "DONE(d)"))))
 '(password-cache-expiry 300)
 '(safe-local-variable-values (quote ((require-final-newline . t) (TeX-PDF-mode . t) (TeX-master . "deliverable1.tex"))))
 '(set-mark-command-repeat-pop t))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background "White" :foreground "Black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "apple" :family "Menlo"))))
;;  '(linum ((t (:inherit (shadow default)))) t)
;;  '(mode-line ((t (:background "OliveDrab3" :foreground "black" :box nil :height 120))))
;;  '(writer-mode-default-face ((t (:inherit default :background "gray94" :foreground "Black" :weight semi-light :height 1.8 :width expanded :family "Baskerville")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dired-directory ((t (:inherit font-lock-function-name-face :foreground "sky blue" :weight bold))))
 '(dired-header ((t (:inherit font-lock-type-face :background "dark red" :foreground "white"))))
 '(eshell-prompt ((t (:background "dark slate gray" :foreground "gray100" :weight bold))) t)
 '(magit-branch ((t (:inherit magit-header :background "dark blue"))))
 '(magit-item-highlight ((t (:inherit highlight :background "dark slate gray"))))
 '(magit-section-title ((t (:inherit magit-header :background "dark red"))))
 '(org-column ((t (:background "black" :strike-through nil :underline nil :slant normal :weight normal :height 120 :family "Menlo"))))
 '(org-todo ((t (:foreground "red" :weight bold))))
 '(org-warning ((t (:inherit font-lock-warning-face :foreground "dark red")))))
