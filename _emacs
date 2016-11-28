;;; Toggle truncate-lines key-binding

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; js2-jsx-mode
(unless (package-installed-p 'js2-mode)
  (package-install 'js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))

;; global toggle lines command
(global-set-key "\C-xt" 'toggle-truncate-lines)

;; Enable global upcase/downcase commands
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;;;
;;; Customize
;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(c-basic-offset 4)
 '(column-number-mode t)
 '(compilation-scroll-output t)
 '(compile-command "make ")
 '(default-frame-alist (quote ((width . 120) (height . 55) (tool-bar-lines . 0))))
 '(fill-column 80)
 '(global-auto-revert-mode t nil (autorevert))
 '(global-whitespace-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(package-selected-packages (quote (js2-mode)))
 '(scroll-conservatively 10000)
 '(sgml-basic-offset 4)
 '(show-paren-mode t nil (paren))
 '(split-width-threshold nil)
 '(tab-width 4)
 '(truncate-lines t)
 '(whitespace-style
   (quote
    (empty face indentation::space space-after-tab space-before-tab tabs trailing))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
