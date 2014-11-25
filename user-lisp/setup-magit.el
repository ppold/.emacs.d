(require 'magit-gh-pulls)
(require 'helm-github-issues)

(setq helm-github-issues-bookmarks
      '("rnmp/salvattore"))
(add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls)

(provide 'setup-magit)
