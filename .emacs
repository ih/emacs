; initialize package manager and packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

(package-initialize)

;; installs use-package if not available (thanks to ian whitlock)
(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))

(require 'use-package)

;;packages used
(use-package exec-path-from-shell :ensure t)
(use-package elpy :ensure t)
(use-package solarized-theme :ensure t)
(use-package magit :ensure t)
(use-package js2-mode :ensure t)
(use-package blank-mode :ensure t)

; Execution related
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

; OS X related disable
;; use command instead of control
(setq ns-command-modifier 'meta)

; Keyboard related


; Buffers related
;; make it easy to rename a buffer
(global-set-key (kbd "C-x m") 'rename-buffer)

;make navigation between buffers easier
(defun select-next-window ()
  "Switch to the next window"
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to the previous window"
  (interactive)
  (select-window (previous-window)))

(global-set-key (kbd "M-o") 'select-next-window)
(global-set-key (kbd "M-O")  'select-previous-window)

; Text related
;; visualize when lines are too long
(setq-default show-trailing-whitespace t)
(setq-default whitespace-style '(face lines-tail))
(setq-default whitespace-line-column 80)
(global-whitespace-mode 1)

;; no beeping
(setq visible-bell 1)
;; enable mouse scrolling
(require 'mwheel)
(mouse-wheel-mode 1)

; Cursor related
;; show cursor line and column in stats bar
(column-number-mode 1)
(line-number-mode 1)
(show-paren-mode 1)

(ido-mode 1)

; Theme related
(load-theme 'solarized-dark 1)

; Frame related
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

; Python related
(elpy-enable)
(elpy-use-ipython)
;(load-file "~/.emacs.d/epy/epy-init.el")

; Editing related
;; spaces instead of tabs
(setq-default indent-tabs-mode nil)
;; make sure tabs get replaced with spaces
;; clean up white space
(add-hook 'before-save-hook (lambda ()
                  (delete-trailing-whitespace)
                  (untabify (point-min) (point-max))))


; Javascript related
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(custom-set-variables
 '(js2-basic-offset 2))


; Git related
(require 'magit)
(eval-after-load 'magit
  (progn '(global-set-key (kbd "C-x g") 'magit-status)))
