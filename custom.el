;; Turn off the annoying bell
(setq ring-bell-function 'ignore)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("65385d67a1711d06a04e0cc5830e24ff7d016bdb4f9876a5d538308400024c4c" "0c2ca285c4aedb6d3333e861ccee41edde2afc7efe0f1d347e0133d04f11ab1f" "73fe242ddbaf2b985689e6ec12e29fab2ecd59f765453ad0e93bc502e6e478d6" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "f3ceb7a30f6501c1093bc8ffdf755fe5ddff3a85437deebf3ee8d7bed8991711" "f32dd8e7b3a508874eded03d5be43d2bdfffe81c199eea72de06ce3e653db720" "427234e4b45350b4159575f1ac72860c32dce79bb57a29a196b9cfb9dd3554d9" "1f3304214265481c56341bcee387ef1abb684e4efbccebca0e120be7b1a13589" "d2622a2a2966905a5237b54f35996ca6fda2f79a9253d44793cfe31079e3c92b" "159bb8f86836ea30261ece64ac695dc490e871d57107016c09f286146f0dae64" "5a0522c0959f3b694ffd06ce620ee3868b2da14723c75e76939940971fc84e3b" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "6cfe5b2f818c7b52723f3e121d1157cf9d95ed8923dbc1b47f392da80ef7495d" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "d6a00ef5e53adf9b6fe417d2b4404895f26210c52bb8716971be106550cea257" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(flycheck-check-syntax-automatically (quote (save new-line mode-enabled)))
 '(flycheck-idle-change-delay 5)
 '(imenu-eager-completion-buffer nil)
 '(imenu-use-popup-menu (quote on-mouse))
 '(js2-global-externs (quote ("define" "require" "app")))
 '(js2-include-node-externs t)
 '(locate-ls-subdir-switches "-lhl")
 '(magit-repo-dirs (quote ("/home/nico/config/" "/home/nico/work/")))
 '(mu4e-attachment-dir "~/")
 '(mu4e-bookmarks (quote (("flag:unread AND NOT flag:trashed" "Unread messages" 117) ("date:today..now" "Today's messages" 116) ("date:7d..now" "Last 7 days" 119) ("amber AND flag:unread" "Amber" 97) ("pharo AND flag:unread" "Pharo" 112) ("rmod AND flag:unread" "RMoD" 114) ("from:ducasse AND flag:unread" "Stef" 115) ("from:vanryseghem AND flag:unread" "Ben" 98) ("from:aurelia AND flag:unread" "Aurelia" 101) ("nico AND flag:unread" "Nico" 110))))
 '(mu4e-compose-complete-addresses t)
 '(mu4e-compose-dont-reply-to-self t)
 '(mu4e-headers-skip-duplicates t)
 '(mu4e-use-fancy-chars t)
 '(mu4e-user-mail-address-list (quote ("petton.nicolas@gmail.com" "nico@objectfusion.fr")))
 '(notmuch-hello-sections (quote (ignore notmuch-hello-insert-saved-searches notmuch-hello-insert-search notmuch-hello-insert-recent-searches notmuch-hello-insert-alltags notmuch-hello-insert-footer)))
 '(og-org-agenda-appt-headline "APPT")
 '(org-agenda-custom-commands (quote (("w" . "Work TODO") ("wf" "Foretagsplatsen" tags-todo "+ftgp-hold" nil) ("wb" "Business (objectfusion)" tags-todo "+business-hold" nil) ("wo" "Objectfusion (all)" tags-todo "+objectfusion-hold" nil) ("wa" "Amber" tags-todo "+amber-hold" nil) ("wr" "Resilience" tags-todo "+resilience-hold" nil) ("wi" "RMoD" tags-todo "rmod|inria-hold" nil) ("wh" "SmalltalkHub" tags-todo "+smalltalkhub-hold" nil) ("n" "Next actions (current buffer)" tags-tree "TODO=\"NEXT\"" nil) ("h" "Waiting/stuck" ((todo "WAITING" ((org-agenda-overriding-header "Waiting for others"))) (tags "stuck" ((org-agenda-overriding-header "Marked Stuck")))) nil) ("d" "30 days deadlines" agenda "" ((org-agenda-entry-types (quote (:deadline))) (org-agenda-overriding-header "Month deadlines") (org-agenda-span (quote month)) (org-agenda-overriding-header ""))) ("." "Short tasks (< 2 min)" tags "short-hold" ((org-agenda-overriding-header "Less than 2 minutes tasks"))) ("W" "Work agenda" agenda "" ((org-agenda-files (quote ("~/org/work.org"))) (org-agenda-overriding-header "Work agenda"))) ("H" "Home agenda" agenda "Home agenda" ((org-agenda-overriding-header "Home Agenda") (org-agenda-files (quote ("~/org/home.org"))))) ("l" "Logbook" nico/org-agenda-log "" ((org-agenda-overriding-header "Logbook"))) ("@p" "@ Phone" tags "@phone" ((org-agenda-overriding-header "@ Phone"))) ("@e" "@ Email" tags "@email" ((org-agenda-overriding-header "@ Email"))))))
 '(org-agenda-default-appointment-duration 60)
 '(org-agenda-restore-windows-after-quit t)
 '(org-agenda-span (quote week))
 '(org-columns-default-format "%60ITEM(Task) %10Effort(Estimated Effort){:} %10CLOCKSUM")
 '(org-completion-use-ido t)
 '(org-deadline-warning-days 10)
 '(org-default-notes-file "~/org/inbox.org")
 '(org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")
 '(org-export-taskjuggler-target-version 3)
 '(org-fontify-done-headline t)
 '(org-global-properties (quote (("Effort_ALL" . "1h 2h 4h 6h 8h 16h"))))
 '(org-habit-graph-column 52)
 '(org-hide-leading-stars t)
 '(org-log-done (quote time))
 '(org-mobile-force-id-on-agenda-items nil)
 '(org-modules (quote (org-bibtex org-docview org-gnus org-habit org-info org-protocol org-jsinfo org-habit org-irc org-mew org-mhe org-protocol org-rmail org-vm org-wl org-w3m org-bookmark)))
 '(org-pomodoro-audio-player "/usr/bin/afplay")
 '(org-stuck-projects (quote ("+LEVEL=2/-DONE" ("TODO" "NEXT") nil "")))
 '(org-tags-column -80)
 '(org-todo-keyword-faces (quote (("NEXT" :foreground "orange" :weight bold) ("CANCELLED" :foreground "forest green"))))
 '(org-todo-keywords (quote ((sequence "TODO(t)" "|" "DONE(d)" "CANCELLED(c)") (sequence "NEXT(n)" "|" "DONE(d)" "CANCELLED(c)") (sequence "FEATURE(f)" "|" "COMPLETED(c)") (sequence "BUG(b)" "|" "FIXED(x)") (sequence "APPT(p)" "|" "DONE(d)" "CANCELED(a)") (sequence "WAITING(w)" "|" "DONE(d)"))))
 '(password-cache-expiry 300)
 '(powerline-default-separator (quote arrow))
 '(powerline-default-separator-dir (quote (left . right)))
 '(safe-local-variable-values (quote ((require-final-newline . t) (TeX-PDF-mode . t) (TeX-master . "deliverable1.tex"))))
 '(set-mark-command-repeat-pop t)
 '(solarized-height-minus-1 1.0)
 '(solarized-height-plus-1 1.0)
 '(solarized-height-plus-2 1.0)
 '(solarized-height-plus-3 1.0)
 '(solarized-height-plus-4 1.0)
 '(solarized-high-contrast-mode-line nil)
 '(solarized-use-variable-pitch nil)
 '(speedbar-use-images t)
 '(speedbar-verbosity-level 0)
 '(tool-bar-mode nil)
 '(winner-boring-buffers (quote ("*Completions* *Messages*")))
 '(winner-mode t))
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
 '(custom-button ((t (:background "#eee8d5" :foreground "#586e75" :box (:line-width 2 :style released-button)))))
 '(font-lock-fic-face ((t (:stipple nil :foreground "lime green" :slant italic :weight bold))) t)
 '(writer-mode-default-face ((t (:inherit FontAwesome)))))
