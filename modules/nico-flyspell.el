(require 'flyspell)

(defun nico/setup-flymake ()
  ;; C-; is bound to 'other-window already
  (define-key flyspell-mode-map (kbd "C-;") nil)
  (define-key flyspell-mode-map (kbd "C-M-i") 'ispell-change-dictionary))

(dolist (mode-hook '(text-mode-hook 
					 LaTeX-mode-hook))
  (add-hook mode-hook (lambda () 
						(flyspell-mode))))

(dolist (mode-hook '(prog-mode-hook))
  (add-hook mode-hook (lambda () 
						(flyspell-prog-mode))))

(nico/setup-flymake)

(provide 'nico-flyspell)
