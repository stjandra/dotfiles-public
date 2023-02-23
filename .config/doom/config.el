;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;;;;;;;;;;;
;; Editor ;;
;;;;;;;;;;;;

;; Font.
(setq doom-font (font-spec :family "Fira Code" :size 14 :weight 'semi-light))

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
;;(cond ((string-equal system-type "darwin")
;;       ;; https://www.emacswiki.org/emacs/TransparentEmacs
;;       (set-frame-parameter (selected-frame) 'alpha '(95 . 90))
;;       (add-to-list 'default-frame-alist '(alpha . (95 . 90)))
;;       )
;;      )

;; Without this, menu bar will appear in terminal emacsclient
(menu-bar-mode -1)

;; Ignore case (e.g., during projectile-switch-project)
(setq completion-ignore-case  t)

;;;;;;;;;;;;;;;;;
;; Keybindings ;;
;;;;;;;;;;;;;;;;;

(map!
 :n  "C-h"   #'evil-window-left
 :v  "C-h"   #'evil-window-left
 :n  "C-j"   #'evil-window-down
 :v  "C-j"   #'evil-window-down
 :n  "C-k"   #'evil-window-up
 :v  "C-k"   #'evil-window-up
 :n  "C-l"   #'evil-window-right
 :v  "C-l"   #'evil-window-right
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
(add-hook 'after-make-frame-functions
          (lambda
            (frame)
            (when
                (display-graphic-p frame)
              (use-package! nyan-mode
                :config
                (nyan-mode 1)
                :init
                (setq nyan-minimum-window-width 140)
                )
              )
            )
          )

;; Disable hl-line-mode in rainbow-mode
;; https://github.com/hlissner/doom-emacs/blob/develop/modules/tools/rgb/README.org
(add-hook! 'rainbow-mode-hook
  (hl-line-mode (if rainbow-mode -1 +1)))

;; Map q to quit if server name is magit
;;(cond
;; ((string-equal (daemonp) "magit")
;;  (after! magit
;;    (map! (:map magit-mode-map :nv "q" #'save-buffers-kill-terminal))
;;    )
;;  )
;; )

;; Fuzzy search
(after! vertico
  (setq completion-styles '(flex))
)

;;;;;;;;;;;;;;;;;;;;;;;;
;; Source other files ;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; Email config.
(load-file "~/.config/doom/email.el")

;; Work config.
(if (file-exists-p "~/.config/my-work/config.el")
    (load-file "~/.config/my-work/config.el")
  )
