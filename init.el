;;; Code:

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; Set path to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

(setq user-lisp-dir
      (expand-file-name "user-lisp" user-emacs-directory))

;; Set up load path
;; (add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path site-lisp-dir)
(add-to-list 'load-path user-lisp-dir)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Set up appearance early
(require 'appearance)

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Are we on a mac?
(setq is-mac (equal system-type 'darwin))

;; Setup packages
(require 'setup-package)

;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   '(dired-details
     dired+
     auto-complete
     gist
     yasnippet
     flx-ido
     ido-ubiquitous
     evil
     evil-visualstar
     evil-surround
     smartparens
     rainbow-delimiters
     magit
     magit-gitflow
     git-gutter
     helm
     helm-themes
     helm-c-yasnippet
     perspective
     projectile
     multi-term
     exec-path-from-shell
     whitespace-cleanup-mode
     saveplace
     vagrant
     browse-kill-ring
     guide-key
     expand-region
     diminish
     pretty-mode
     org-plus-contrib
     htmlize
     twittering-mode
     itail
     prodigy
     restclient
     w3m

     ;; OSX
     erc-terminal-notifier
     dash-at-point

     ;; Lisp
     slime
     ac-slime

     ;; Clojure
     ac-cider
     cider
     clj-refactor
     clojure-cheatsheet
     clojure-snippets
     latest-clojure-libraries
     align-cljlet
     slamhound
     midje-mode

     ;; YAML
     yaml-mode

     ;; HTML
     emmet-mode
     web-mode
     sass-mode

     ;; Python
     virtualenvwrapper
     flycheck

     ;; Coffeescript
     coffee-mode

     ;; Javascript
     js2-mode
     js2-refactor
     ac-js2
     skewer-mode

     php-mode
     haskell-mode

     ;; Goodies
     auto-dim-other-buffers
     )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

;; Lets start with a smattering of sanity
(require 'sane-defaults)

;; Setup Key bindings
(require 'key-bindings)

;; Load Mac-only config
(when is-mac (require 'mac))

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;; Load PATH from shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Load user specific configuration
(when (file-exists-p user-lisp-dir)
  (mapc 'load (directory-files user-lisp-dir nil "^[^#].*el$")))

;; cjsx files as coffee
(setq auto-mode-alist
      (append '((".*\\.cjsx\\'" . coffee-mode))
              auto-mode-alist))

(provide 'alex-cjsx)
