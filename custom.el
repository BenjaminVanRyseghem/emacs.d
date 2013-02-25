;; Turn off the annoying bell
(setq ring-bell-function 'ignore)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(locate-command "mdfind")
 '(magit-repo-dirs (quote ("/home/nico/config/" "/home/nico/work/")))
 '(notmuch-hello-sections (quote (ignore notmuch-hello-insert-saved-searches notmuch-hello-insert-search notmuch-hello-insert-recent-searches notmuch-hello-insert-alltags notmuch-hello-insert-footer)))
 '(org-agenda-custom-commands (quote (("w" . "Work TODO") ("wf" "Foretagsplatsen" tags-todo "+ftgp" nil) ("wb" "Business (objectfusion)" tags-todo "+business" nil) ("wo" "Objectfusion (all)" tags-todo "+objectfusion" nil) ("wa" "Amber" tags-todo "+amber" nil) ("wr" "Resilience" tags-todo "+resilience" nil) ("wi" "Inria" tags-todo "+inria" nil) ("wh" "SmalltalkHub" tags-todo "+smalltalkhub" nil))))
 '(org-export-taskjuggler-target-version 3)
 '(org-habit-graph-column 52))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-column ((t (:background "#000000" :strike-through nil :underline nil :slant normal :weight normal :height 128)))))
