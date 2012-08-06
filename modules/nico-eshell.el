;; Change the default eshell prompt

;; (setq eshell-prompt-function
;;       (lambda ()
;; 	(concat
;; 		(eshell/pwd)
;; 		(if (= (user-uid) 0) " # " " => "))))

(require 'eshelbmk)

(setq eshell-cmpl-cycle-completions nil
      eshell-save-history-on-exit t
      eshell-buffer-shorthand t
      eshell-cmpl-dir-ignore "\\`\\(\\.\\.?\\|CVS\\|\\.svn\\|\\.git\\)/\\'")

;; Normal scrolling
(setq eshell-scroll-show-maximum-output nil)
(setq eshell-scroll-to-bottom-on-output nil)


(eval-after-load 'esh-opt
  '(progn
     (require 'em-prompt)
     (require 'em-term)
     (require 'em-cmpl)
     (setenv "PAGER" "cat")
     (set-face-attribute 'eshell-prompt nil :foreground "turquoise1")
     (add-hook 'eshell-mode-hook ;; for some reason this needs to be a hook
               '(lambda () (define-key eshell-mode-map "\C-a" 'eshell-bol)))
     (add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)

     (add-to-list 'eshell-visual-commands "ssh")
     (add-to-list 'eshell-visual-commands "htop")
     (add-to-list 'eshell-visual-commands "tail")
     (add-to-list 'eshell-command-completions-alist
                  '("gunzip" "gz\\'"))
     (add-to-list 'eshell-command-completions-alist
                  '("tar" "\\(\\.tar|\\.tgz\\|\\.tar\\.gz\\)\\'"))))


;; aliases

(defun eshell/j (path)
  (eshell/bmk path))

(defun eshell/emacs (file)
  (find-file file))

(provide 'nico-eshell)
