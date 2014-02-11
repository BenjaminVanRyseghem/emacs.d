(require 'ido-ubiquitous)
(require 'ido-vertical-mode)
(require 'ido)
(require 'icomplete)
(require 'smex)

(ido-mode)
(ido-everywhere)
(ido-ubiquitous-mode)
(ido-vertical-mode)
(icomplete-mode 99)
(smex-initialize)

(setq
 ido-enable-flex-matching t
 ido-use-virtual-buffers t)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-x") 'smex)


(provide 'nico-ido)
