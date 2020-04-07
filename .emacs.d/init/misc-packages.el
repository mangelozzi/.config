;;; ============================================================================
;;; WHITESPACE (Built in package)
;; https://github.com/emacs-mirror/emacs/blob/master/lisp/whitespace.el
(use-package whitespace
  :ensure t
  :config
  ;; face:       Enable all visualizations which use special faces. This element has a special meaning: if it is absent from the list, none of the other visualizations take effect except space-mark, tab-mark, and newline-mark.
  ;; trailing:   Highlight trailing whitespace.
  ;; lines-tail: lines which have columns beyond whitespace-line-column' are highlighted via	faces. 
  (setq whitespace-style '(face trailing lines-tail))
  (setq whitespace-display-mappings '(
                                      (space-mark 32 [183] [46]) ; middle-dot
                                      (tab-mark 9 [9654 9] [92 9]) ; arrow
                                      ))
  )
;;; ============================================================================
;;; Use xref instead or ELISP-SLIME-NAV for finding help on built in lisp

;;; ============================================================================
;;; WHICH-KEY
;; If one pauses during a key chord, brings up a menu of availble hotkey options.
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;;; ============================================================================
;;; KEY CHORD
;; Create hotkeys from multiple key pressed at the same time
(use-package key-chord)
;; :commands key-chord-mode)

;;; ============================================================================
;;; MARKDOWN
;; https://github.com/defunkt/markdown-mode
;; To render to HTML, require an installed external Markdown processor
(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
