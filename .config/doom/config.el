;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;;;;;;;;;;;
;; Editor ;;
;;;;;;;;;;;;

;; Font.
(cond
 ((string-equal system-type "darwin")
  (setq doom-font (font-spec :family "Fira Code Retina" :size 14 :weight 'semi-light))
  )

 ((string-equal system-type "gnu/linux")
  (setq doom-font (font-spec :family "Fira Code" :size 14 :weight 'semi-light))
  )
 )

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

; spacemacs theme
;(use-package! spacemacs-dark-theme
;  :init
;  (setq spacemacs-theme-org-height nil)
;  (setq spacemacs-theme-comment-bg nil)
;  )
;(setq doom-theme 'spacemacs-dark)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Wrap lines in all modes.
(global-visual-line-mode t)

;; No newline at end of file.
(setq require-final-newline nil)
(setq mode-require-final-newline nil)

;; Disable smartparens
;; https://github.com/hlissner/doom-emacs/blob/develop/docs/faq.org#how-to-disable-smartparensautomatic-parentheses-completion
(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

;; Set transparency on Mac only.
(cond ((string-equal system-type "darwin")
       ;; https://www.emacswiki.org/emacs/TransparentEmacs
       (set-frame-parameter (selected-frame) 'alpha '(95 . 90))
       (add-to-list 'default-frame-alist '(alpha . (95 . 90)))
       )
      )

;;;;;;;;;;;;;;
;; Org Mode ;;
;;;;;;;;;;;;;;

;; Set *scratch* buffer to org mode.
;; Disabled due to slow startup.
;(setq initial-major-mode 'org-mode)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")

(after! org
  (setq org-log-done 'time) ;; Add timestamps when todo is marked done.
  )

;;;;;;;;;;;;;;;;;;;
;; Plugin Config ;;
;;;;;;;;;;;;;;;;;;;

(with-eval-after-load 'lsp-mode
  ;; Disable file watch for performance.
  (setq lsp-enable-file-watchers nil)
  )

;; Use bash.
;; dap-java-run-test-class etc. does not work with fish.
(cond
 ((string-equal system-type "darwin")
  (setq-default shell-file-name "/usr/local/bin/bash")
  )

 ((string-equal system-type "gnu/linux")
  (setq-default shell-file-name "/bin/bash")
  )
 )

;; Test lens mode.
;; https://gitter.im/emacs-lsp/lsp-mode?at=5de8608908d0c961b7f129dd
(add-hook 'lsp-after-open-hook 'lsp-lens-mode)
(add-hook 'lsp-after-open-hook 'lsp-jt-lens-mode)

;; Only use nyan mode in GUI.
(when window-system
  (use-package! nyan-mode
    :config
    (nyan-mode 1)
    :init
    (setq nyan-minimum-window-width 140)
    )
  )

;; https://github.com/mcandre/vimrc-mode
(require 'vimrc-mode)
(add-to-list 'auto-mode-alist '("\\.vim\\(rc\\)?\\'" . vimrc-mode))

;;;;;;;;;;;;;;;;;;;;;;;;
;; Source other files ;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; Email config.
(load-file "~/.config/doom/email.el")

;; Work config.
(load-file "~/.config/my-work/config.el")
