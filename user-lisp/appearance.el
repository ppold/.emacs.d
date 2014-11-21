(setq visible-bell nil
      font-lock-maximum-decoration t
      color-theme-is-global t
      truncate-partial-width-windows nil)

;; Highlight current line
(global-hl-line-mode 1)

;; Set custom theme path
(setq custom-theme-directory (concat user-emacs-directory "themes"))

(dolist
    (path (directory-files custom-theme-directory t "\\w+"))
  (when (file-directory-p path)
    (add-to-list 'custom-theme-load-path path)))

(when (window-system)
  (set-frame-font "Monaco")
  (set-face-attribute 'default nil :family "Monaco" :height 140)
  (custom-set-faces
   '(auto-dim-other-buffers-face ((t (:background "#494949")))))
  (set-face-font 'default "Monaco"))
(load-theme 'zenburn)

;; Don't defer screen updates when performing operations
(setq redisplay-dont-pause t)

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (blink-cursor-mode -1))

;; epic red
(set-cursor-color "firebrick")
(setq initial-scratch-message "")

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(fringe-mode -1)
(set-fringe-mode '(0 . 0))
(set-face-attribute 'mode-line nil  :inverse-video nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)
(set-face-attribute 'vertical-border nil :foreground "#383838")

(add-hook 'prog-mode-hook (defun pnh-add-watchwords ()
                            (font-lock-add-keywords
                             nil `(("\\<\\(FIX\\(ME\\)?\\|TODO\\)"
                                  1 font-lock-warning-face t)))))

(provide 'appearance)
