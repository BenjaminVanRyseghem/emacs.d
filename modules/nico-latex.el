;; AUCTeX
(add-hook 'LaTeX-mode-hook 'tex-pdf-mode)

(setq LaTeX-command "latex -synctex=1")

(if (system-type-is-darwin)
    (progn
      (setq TeX-view-program-list '(("open" "open %o")))
      (setq TeX-view-program-selection '((output-pdf "open")))))

(provide 'nico-latex)
