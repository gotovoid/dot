;; _   _     _ _  ___
;; | | | |   | | |/ / |EMACS
;; | |_| |_  | | ' /| |Kev++
;; |  _  | |_| | . \| |___
;; |_| |_|\___/|_|\_\_____|

;; emacs
(xterm-mouse-mode t)
(add-to-list 'load-path "~/.emacs.d")
(load "figlet.el")
(require 'blank-mode)
(require 'yasnippet-bundle)
(require 'magit)
(delete-selection-mode t)
(show-paren-mode t)
(ido-mode t)
(ruler-mode t)
(tooltip-mode -1)
(global-linum-mode t)
(global-hl-line-mode t)
(toggle-indicate-empty-lines t)
;(add-to-list 'auto-mode-alist '("\\.vim$" . python-mode))

;; key-bindings

(global-set-key [f1] 'delete-other-windows)
(global-set-key [f2] 'find-file-other-window)
(global-set-key [f5] (lambda ()
                       (interactive)
                       (load-file "~/.emacs")))
(global-set-key [f6] 'global-hl-line-mode)
(global-set-key [f7] 'blank-mode)
(global-set-key [f8] 'toggle-truncate-lines)
(global-set-key "\C-x\C-g" 'magit-status)

(defun my-indent-region (N)
  (interactive "p")
  (if mark-active
      (progn (indent-rigidly (min (mark) (point)) (max (mark) (point)) (* N 4))
             (setq deactivate-mark nil))
    (self-insert-command N)))

(defun my-unindent-region (N)
  (interactive "p")
  (if mark-active
      (progn (indent-rigidly (min (mark) (point)) (max (mark) (point)) (* N -4))
             (setq deactivate-mark nil))
    (self-insert-command N)))
(global-set-key ">" 'my-indent-region)
(global-set-key "<" 'my-unindent-region)


;; org-mode
(setq org-enforce-todo-dependencies t)
(setq org-log-done 'time)
(setq org-agenda-files (file-expand-wildcards "~/org/*.org"))
(define-key global-map "\C-ca" 'org-agenda)

;; buffer
(global-auto-revert-mode t)
(setq make-backup-files nil)
(setq set-mark-command-repeat-pop t)

;; gui
(setq line-number-mode t
      column-number-mode t)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse t)
(setq scroll-step 1)
(setq-default truncate-lines t)
(setq redisplay-dont-pause t)
(setq-default cursor-type '(bar . 4))
(set-cursor-color "purple")
(setq-default cursor-in-non-selected-windows t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 120 :family "DejaVu Sans Mono")))))

;; space
(setq-default sentence-end-double-space nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                        64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
(define-key text-mode-map (kbd "<tab") 'tab-to-tab-stop)
(setq-default c-default-style "awk" c-basic-offset 4)
(add-hook 'c-mode-hook (lambda () (define-key c-mode-map "\C-m" 'c-context-line-break)))


;; enable
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
