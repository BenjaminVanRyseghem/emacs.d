(require 'flyspell)

(defun nico/setup-flymake ()
  (define-key flyspell-mode-map (kbd "C-;") nil))

(dolist (mode-hook '(text-mode-hook 
					 LaTeX-mode-hook))
  (add-hook mode-hook (lambda () 
						(flyspell-mode))))

(dolist (mode-hook '(prog-mode-hook))
  (add-hook mode-hook (lambda () 
						(flyspell-prog-mode))))

(nico/setup-flymake)

(provide 'nico-flyspell)
