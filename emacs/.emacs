;; A minimalistic Emacs configuration for those occasions where Vim
;; isn't available.

;; Use MELPA.
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Be evil.
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)

;; Show line/column numbers.
(global-linum-mode 1)
(column-number-mode 1)

;; Enhancements.
(blink-cursor-mode -1)
(electric-pair-mode 1)
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Left-aligned line numbers with 3 column width by default.
(setq linum-format "%3d ")

;; Font in GUI.
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro Medium" :foundry "ADOBE" :slant normal :weight semibold :height 90 :width normal)))))

;; Make interface more minimalistic
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; UTF-8 as default encoding.
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; Disable startup messages.
(setq initial-scratch-message "")
(setq inhibit-startup-message t)

;; Don't create backup and #autosave# files.
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Accept y/n instead of yes/no in prompts.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Strip trailing whitespace before saving files.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Follow symlinks in version controlled directories.
(setq vc-follow-symlinks t)
