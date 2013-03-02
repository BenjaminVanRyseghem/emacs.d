(require 'reftex)
(add-hook 'LaTeX-mode-hook 'tex-pdf-mode)

(eval-after-load "LaTeX"
  '(progn

     ;; synctex
     (TeX-source-correlate-mode)

     (add-to-list 'TeX-expand-list
		  '("%q" skim-make-url))))

(defun skim-make-url () (concat
			 (TeX-current-line)
			 " "
			 (expand-file-name (funcall file (TeX-output-extension) t)
					   (file-name-directory (TeX-master-file)))
			 " "
			 (buffer-file-name)))

(setq TeX-view-program-list
      '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %q")))

(setq TeX-view-program-selection '((output-pdf "Skim")))

(provide 'nico-latex)
