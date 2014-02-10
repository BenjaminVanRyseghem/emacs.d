(require 'flyspell)

(defvar nico-languages-ring nil "Languages ring for Ispell")

(let ((languages '("en_US" "francais")))
      (setq nico-languages-ring (make-ring (length languages)))
      (dolist (elem languages) (ring-insert nico-languages-ring elem)))

(defun nico/setup-flymake ()
  ;; C-; is bound to 'other-window already
  (define-key flyspell-mode-map (kbd "C-;") nil)
  (define-key flyspell-mode-map (kbd "C-M-i") 'nico/cycle-ispell-languages))

(defun nico/cycle-ispell-languages ()
  (interactive)
  (let ((language (ring-ref nico-languages-ring -1)))
	(ring-insert nico-languages-ring language)
	(ispell-change-dictionary language)))

(dolist (mode-hook '(text-mode-hook 
					 LaTeX-mode-hook))
  (add-hook mode-hook (lambda () 
						(flyspell-mode))))

(dolist (mode-hook '(prog-mode-hook))
  (add-hook mode-hook (lambda () 
						(flyspell-prog-mode))))

(nico/setup-flymake)

(provide 'nico-flyspell)
