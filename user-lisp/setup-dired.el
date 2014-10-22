(require 'dired-details)
(require 'dired+)
;;; Then I will manually specify what I want redefined.

(setq-default dired-details-hidden-string "")
(dired-details-install)
(setq dired-listing-switches "-alGh")

;; Extend dired.
(require 'dired-x)
(setq-default dired-omit-files-p t)

; Mac OS X clutter is uninteresting.
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\.DS_Store$\\|^__MACOSX$\\|^\\.localized$"))

(define-key dired-mode-map [?/] 'dired-isearch-filenames)

(provide 'setup-dired)
