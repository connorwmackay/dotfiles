(setq inhibit-startup-message t)

(scroll-bar-mode -1) ;; Disable visual scrollbar
(tool-bar-mode -1) ;; Disable the toolbar
(tooltip-mode -1) ;; Disable tooltip
(set-fringe-mode 10) ;; Breathing room
(menu-bar-mode -1) ;; Disable the menu ba

;; Set up the visible bell
(setq visible-bell t)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Set Font
(set-face-attribute 'default nil :font "FiraCode Nerd Font Mono" :height 125)

;; Set tab size
(setq-default indent-tabs-mode nil)
(setq-default c-default-style "bsd")
(setq-default c-basic-offset 4)
(setq-default tab-width 4)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Use Package
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package ivy
  :diminish
  :bind (:map ivy-minibuffer-map
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))
(setq doom-modeline-icon t)

(use-package gruvbox-theme)
(load-theme 'gruvbox-dark-medium t)

(use-package nerd-icons)

;; Install lsp-mode, company, lsp-ui
(use-package lsp-mode
  :ensure t
  :hook ((c++-mode . lsp)
         (c-mode . lsp))
  :commands lsp
  :config
  (setq lsp-clients-clangd-executable "clangd"))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package company
  :ensure t
  :init (global-company-mode)
  :bind (:map company-active-map    	      
              ("M-j"    . company-select-next)    	      
              ("M-k"    . company-select-previous)    	     
              ([return] . nil)    	      
              ("RET"    . nil)    	      
              ([tab]    . company-complete-selection)    	     
              ("TAB"    . company-complete-selection)))

(use-package company-box
  :hook (company-mode . company-box-mode))

(global-font-lock-mode 1)

(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))

(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-mode)
  (setq projectile-project-search-path '("~/Projects"))
  (setq projectile-enable-caching t))

(defun compile-cmake-configure-debug ()
  (interactive)
  (compile "cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -S .. -B ../build"))

(defun compile-cmake-configure-release ()
  (interactive)
  (compile "cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -S .. -B ../build"))

(defun compile-cmake ()
  (interactive)
  (compile "cmake --build ../build"))

(global-set-key [f4] 'compile-cmake-configure-debug)
(global-set-key [f5] 'compile-cmake)
(global-set-key [f6] 'compile-cmake-configure-release)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)
