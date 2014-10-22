(require 'evil)
(evil-mode 1)

(require 'evil-surround)
(global-evil-surround-mode 1)

(require 'evil-visualstar)

(defun my-move-key (keymap-from keymap-to key)
  "Moves key binding from one keymap to another, deleting from the old location. "
  (define-key keymap-to key (lookup-key keymap-from key))
  (define-key keymap-from key nil))
(my-move-key evil-motion-state-map evil-normal-state-map (kbd "RET"))
(my-move-key evil-motion-state-map evil-normal-state-map " ")

(define-key evil-normal-state-map " " 'helm-overlord)
(define-key evil-normal-state-map (kbd "RET") 'helm-M-x)

;; these modes are clear from evil
(add-hook 'term-mode-hook 'evil-emacs-state)
(add-hook 'prodigy-mode-hook 'evil-emacs-state)
(add-hook 'cider-repl-mode-hook 'evil-emacs-state)

(provide 'setup-evil)
