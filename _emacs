;;; Disable C-z to prevent crash on Mac OS X
(if (eq window-system 'ns)
    (global-unset-key (kbd "C-z"))
)

;;; Toggle truncate-lines key-binding
(global-set-key "\C-xt" 'toggle-truncate-lines)

;;; js2-mode
;(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

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
 '(comment-column 40)
 '(compilation-scroll-output t)
 '(default-frame-alist
    (quote
     ((foreground-color . "white")
      (background-color . "black")
      (width . 120)
      (height . 55)
      (tool-bar-lines . 0))))
 '(fill-column 80)
 '(global-auto-revert-mode t nil (autorevert))
 '(global-whitespace-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(scroll-conservatively 10000)
 '(sgml-basic-offset 4)
 '(show-paren-mode t nil (paren))
 '(split-width-threshold nil)
 '(tab-width 4)
 '(truncate-lines t)
 '(whitespace-style (quote (face tabs trailing)))
 '(x-select-enable-clipboard t))

(put 'upcase-region 'disabled nil)

(put 'downcase-region 'disabled nil)
