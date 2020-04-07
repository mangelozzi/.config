;;; init.el --- Michael Angelozzi's Emacs Config

;; Author: Michael Angelozzi
;; Version: 0.1
;; Package-Requires: ((emacs "26"))

;; Michael Angelozzis Emacs Configuration
;; Handy variables
;;     buffer-file-name         - Current buffer full file path
;;     default-directory        - Current buffer dir
;;     _tmp-dir                 - A place to store temp files not version controlled

;; Handy Guides:
;; https://www.emacswiki.org/emacs/EmacsKeyNotation

;; TODOuu
;; disabled-command-function -> call a function which cancels? Evil escape?
;; Magit
;; Py-el
;; Helm -video vs avy
;; Javscript Dev
;; Treemacs - video
;; https://github.com/noctuid/general.el <- Maybe, for managing keymaps
;; https://github.com/joddie/pcre2el <- converting to regular regex

;;; ============================================================================
;;; DEBUG
;; can also call emacs --init-debug
(setq debug-on-error t)
(setq print-length 200)

;;; ============================================================================
;;; OS
(when (eq system-type 'windows-nt)
  ;; Check out .emacs.d folder to: C:\Users\Michael\AppData\Roaming\.emacs.d
  ;;(set-default-font "RobotoMono NF 11")
  (setq user-emacs-directory "~/.config/emacs/")
  )

(when (eq system-type 'gnu/linux)
  )

;;; ============================================================================
;;; VARIABLES
(setq _tmp-dir (concat user-emacs-directory "tmp/"))


;;; ============================================================================
;;; USE-PACKAGE Installation
;; https://github.com/jwiegley/use-package#installing-use-package
;; :ensure t    Automatically download from a remote repository
;; :init        Execute code before a package is loaded
;; :config      Execute code after a package is loaded.
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  )
(eval-when-compile
  (require 'use-package))

;; Always apply `:ensure t` for all future use-package setups
(setq use-package-always-ensure t)

;; Show how many packages have loaded, and load time
;; (setq use-package-compute-statistics t)

;; At beginning so can use this stupid program
(load-file (concat user-emacs-directory "init/evil.el"))

;;; ============================================================================
;;; USE-PACKAGE Global Keybindings
(defun _kill-to-line_start ()
  "Kill from point to beginning of line."
  (interactive)
  (kill-line 0))


(bind-keys*
 ;;("M-C-# M-C!" . save-buffer) ; Example
 ("C-S-u" . universal-argument)     ; Change mapping from default C-u
 ("C-u" . _kill-to-line_start)      ; Change to same as bash command line
 ("C-z" . undo-tree-undo)
 ("C-s" . save-buffer)
 ("C-c" . yank-pop)
 )

;;; ============================================================================
;;; SAVE-PLACE

;; Save the cursor position for each file between sessions.
(setq save-place-file (concat _tmp-dir "places"))
;; Dont set the variable save-place-mode directly, it has no affect, must call this function
(save-place-mode 1)
;; On exit, it checks that every loaded file is readable before saving its buffer position - potentially very slow if you use NFS.
(setq save-place-forget-unreadable-files nil)


;;; ============================================================================
;;; DEFAULT

;; Custom, set via `Options` menu then saved with `Options`->`Save Options`
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; When continuous lines is on, wrap at word boundaries
;; Default that is overwritten when in programming mode
(setq-default word-wrap t)

;; Dont show the startup screen on top of everything else
(setq inhibit-startup-screen t)

;; When searching with apropos searching no just interactive commands
(setq apropos-do-all t)

;;; ============================================================================
;;; QUITTING Emacs

(defun _my-quit-emacs ()
  "When exiting Emacs, offer to save unsaved buffers, but then quit without asking if still wish to quit if there are unsaved buffers."
  (save-some-buffers nil t)
  (kill-emacs))

(defun save-buffers-kill-terminal (&optional arg)
  "Override the existing quit Emacs function via C-x C-c."
  (interactive)
  (_my-quit-emacs))

(defun save-buffers-kill-emacs (&optional arg)
  "Override the existing quit Emacs function via the mouse."
  (interactive)
  (_my-quit-emacs))

;;; ============================================================================
;;; VISUAL
;; Font
;; To see a list of available font names:
;;   1. Open scratch buffer, paste in (font-family-list)
;;   2. Place point at the end of the command, and Press C-j to run eval-print-last-sexp
;;   3. Then goto end of printed list and press <RET> on ... to expand the list
;; Refer to: https://www.gnu.org/software/emacs/manual/html_node/emacs/Fonts.html#Fonts
;; for more examples, e.g. '(font . "RobotoMono-11:weight=light:slant=italic"))
;; Set in theme file isntead
;;(add-to-list 'default-frame-alist '(font . "RobotoMono-11"))

;; Default line spacing
;;(setq-default line-spacing 8)

;; Hide the icon Tool bar
(tool-bar-mode -1)

;; Number Modes
(setq-default column-number-mode t)
(setq-default display-line-numbers 'relative)

;; Disable the cursor blinking
(blink-cursor-mode 0)

;; Enable highlighting of matching parenthesis
(show-paren-mode)

;; Highlight the current line
(global-hl-line-mode 1)

;; Start maximised (cross-platf)
(add-hook 'window-setup-hook 'toggle-frame-maximized t)
;; Start fullscreen (distraction free mode) (cross-platf)
;; (add-hook 'window-setup-hook 'toggle-frame-fullscreen t)

;; Install the theme if changes were made to it (only once off)
;; !!!!!!!!!!!IF MAKE CHANGES UNCOMMENT THIS (package-install-file (expand-file-name "michael-theme.el" user-emacs-directory))
;; Load the theme after installing it or else will take a restart for changes to apply
;; Load the theme - Must come after (package-initialize) and (load custom-file)
;; Also pass in t to denote to not ask if the theme is safe to load
(load-theme 'michael t)

;;; ============================================================================
;;; LOAD FILES
(load-file (concat user-emacs-directory "init/recovery-files.el"))
(load-file (concat user-emacs-directory "init/mode-line.el"))
(load-file (concat user-emacs-directory "init/programming.el"))
(load-file (concat user-emacs-directory "init/misc-packages.el"))

;;; ============================================================================
;;; END
(setq debug-on-error nil)

;; See a list of startup timmings
;; Ensure use-package-compute-statistics is set to t before use-package is used.
;;(use-package-report)             

;;(describe-personal-keybindings)  ; Show a summary of keybindins

;;; ============================================================================
;;; TEMP

;; (find-file "/home/michael/linkcube/src/base/assets/sass/_lc__linkcube.scss")
;; (find-file "/home/michael/linkcube/src/base/views.py")
;; (find-file "~/temp.py")
;; (find-file "~/.config/emacs/init/python.el")
;; (find-file "~/.config/emacs/config/flake8rc.ini")
;; (find-file "~/.config/emacs/init/python.el")
;; (find-file "~/.config/emacs/init/programming.el")
;; (find-file "~/.config/emacs/michael-theme.el")
;; (find-file "~/.config/emacs/init/mode-line.el")
(find-file "~/.config/emacs/init.el")
(find-file "~/.config/emacs/init/evil.el")


;; Warning (bytecomp): Unused lexical variable ‘class’
;; Warning (bytecomp): Unused lexical variable ‘package’
;; Warning (bytecomp): Unused lexical variable ‘variables-reference’
;; Warning (bytecomp): Unused lexical variable ‘key’
;; Warning (bytecomp): Unused lexical argument ‘item’
;; Warning (bytecomp): function ‘lsp-treemacs--extract-line’ defined multiple times in this file
;; Warning (bytecomp): Unused lexical argument ‘item’
;; Warning (bytecomp): the function ‘lsp-cannonical-file-name’ is not known to be defined.
