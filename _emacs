;; _   _     _ _  ___
;; | | | |   | | |/ / |EMACS
;; | |_| |_  | | ' /| |Kev++
;; |  _  | |_| | . \| |___
;; |_| |_|\___/|_|\_\_____|
;; http://www.emacswiki.org/emacs/EmacsCrashCode

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'blank-mode)
(require 'yasnippet)
(require 'magit)

(setq default-major-mode 'text-mode)
(setq echo-keystrokes 0.01)
(setq inhibit-startup-message t)
(setq scroll-step 1)
(setq sentence-end-double-space nil)
(setq set-mark-command-repeat-pop t)
(setq tab-width 4)
(setq-default cursor-type '(bar . 4))
(setq-default indent-tabs-mode nil)
(setq-default indicate-empty-lines t)
(setq-default truncate-lines t)

(ido-mode t)
(set-cursor-color "purple")
(delete-selection-mode t)
(global-linum-mode t)
(menu-bar-mode -1)
(show-paren-mode t)
(tool-bar-mode -1)
(xterm-mouse-mode t)

(global-set-key "\M-k" 'kill-this-buffer)
(global-set-key "\M-n" 'switch-to-next-buffer)
(global-set-key "\M-p" 'switch-to-prev-buffer)
(global-set-key (kbd "<apps>") 'execute-extended-command)
(global-set-key [f5] (lambda ()
               (interactive)
		       (load-file "~/.emacs")))

(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 's 'replace-regexp)

(custom-set-faces
 '(default ((t (:height 120 :family "DejaVu Sans Mono")))))

(defun delete-line ()
  (interactive)
  (setq old-col (current-column))
  (end-of-line)
  (if (= (current-column) 0)
      (delete-char 1)
    (progn
      (beginning-of-line)
      (kill-line)
      (delete-char 1)
      (move-to-column old-col))))

(defun make-backup-file-name (filename)
  (expand-file-name
    (concat "." (file-name-nondirectory filename) "~")
    (file-name-directory filename)))

(put 'narrow-to-region 'disabled nil)
