(package-initialize)

;;
;; Stuff I set with Custom
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(package-selected-packages (quote (use-package shell-pop elpy markdown-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;; --------------------
;; Global features setup
;; --------------------

;; Use MELPA package repository
(require 'package) ;; You might already have this line
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; Resizing windows with C-S-<arrow-key>
(global-set-key (kbd "C-S-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-S-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-S-<down>") 'shrink-window)
(global-set-key (kbd "C-S-<up>") 'enlarge-window)

;; Don't show the emacs startup message and just drop me into the scratch buffer
(setq inhibit-startup-message t)

;; Backup all files to ~/.emacs.d and don't pollute the directory
;; Keep the first few backups (lowest-numbered) ever and the latest few backups (highest numbered) ever, Delete all in between. 
(setq backup-directory-alist `(("." . "~/.emacs.d/backups"))
      delete-old-versions t ;; Delete old backups
      kept-new-versions 7   ;; Keep 7 newest versions when a new backup is made
      kept-old-versions 2   ;; Number of oldest versions to keep when a new backup is made
      version-control t     ;; Always make numeric backup versions
      backup-by-copying t)  ;; Backup by making copies of files


      
;; ------------------
;; Configure packages
;; ------------------

(require 'use-package)

(use-package linum
  :init (global-linum-mode t)
  :config (setq linum-format "%4d\u2502"))

(use-package column-number
  :init (column-number-mode t))

(use-package ido
  :init (ido-mode t))

(use-package elpy
  :commands elpy-enable
  :init (elpy-enable)
  :config
  (progn
    (setq elpy-rpc-python-command "python3")
    (elpy-use-ipython "ipython3")))

(use-package shell-pop
  :bind (("C-t" . shell-pop))
  :config
  (setq shell-pop-shell-type (quote ("ansi-term" "*ansi-term*" (lambda nil (ansi-term shell-pop-term-shell)))))
  (setq shell-pop-term-shell "/bin/zsh")
  ;; need to do this manually or not picked up by `shell-pop'
  (shell-pop--set-shell-type 'shell-pop-shell-type shell-pop-shell-type))
