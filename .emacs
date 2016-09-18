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
(use-package twilight-bright :ensure t)
(use-package magit :ensure t)
(use-package js2-mode :ensure t)
(use-package blank-mode :ensure t)
(use-package web-mode :ensure t)
(use-package flycheck :ensure t)
(use-package ace-window :ensure t)

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
(global-set-key (kbd "M-o") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

(defun select-next-window ()
  "Switch to the next window"
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to the previous window"
  (interactive)
  (select-window (previous-window)))

(global-set-key (kbd "M-p") 'select-next-window)
(global-set-key (kbd "M-O")  'select-previous-window)

; Text related
;; visualize when lines are too long
(setq-default show-trailing-whitespace t)
(setq-default whitespace-style '(face lines-tail))
(setq-default whitespace-line-column 80)
(global-whitespace-mode 1)
;; wrap long lines
(visual-line-mode 1)

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

(global-hl-line-mode 1)

; Theme related
(load-theme 'twilight-bright 1)

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
;; Use flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)


; Javascript related
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook 'flycheck-mode)
(custom-set-variables
 '(js2-basic-offset 2))
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))
(flycheck-add-mode 'javascript-eslint 'web-mode)

; Web-mode related
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)

; Git related
(require 'magit)
(eval-after-load 'magit
  (progn '(global-set-key (kbd "C-x g") 'magit-status)))
