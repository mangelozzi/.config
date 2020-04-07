;; Helpful Guide from Vim to Evil: https://github.com/noctuid/evil-guide
;; Remember to USE
;; operator + motion + text-object = awesome
;; SURROUND
;; <leader>o/O

;;; ============================================================================
;;; EVIL-MODE
;; This package placed first so that if items below fail, at least can use evil mode to fix them
(use-package evil
  ;;:disabled t
  ;; Always enabled
  ;;:commands evil-mode
  ;;:after key-chord
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-w-in-emacs-state t) ; can use C-w c to close windows in emacs mode
  (setq evil-mode-line-format nil) ; Using custom mode-line. If not can set to 'before or 'after
  (setq evil-flash-delay 10)
  (setq show-paren-mode t)
  ;;(setq evil-want-fine-undo "yes")
  ;; Mode-line state strings (Instead of <N> <i> <E> <M> etc
  (setq evil-normal-state-tag  (propertize " NORMAL " 'face '(:foreground "#FFFFFF" :background "#000000")))
  (setq evil-insert-state-tag  (propertize " INSERT " 'face '(:foreground "#00FF00" :background "#000000")))
  (setq evil-visual-state-tag  (propertize " VISUAL " 'face '(:foreground "#88FFFF" :background "#000000")))
  (setq evil-motion-state-tag  (propertize " MOTION " 'face '(:foreground "#AAAAAA" :background "#000000")))
  (setq evil-replace-state-tag (propertize " REPLACE" 'face '(:foreground "#FF0000" :background "#000000")))
  (setq evil-emacs-state-tag   (propertize " EMACS  " 'face '(:foreground "#FFFFFF" :background "#0000FF")))

  :config
  ;; Highlight the current cursor line when editing
  (defun _cursor-line-highlight ()
    "Change the current line highlighting to be more noticeable when in insert mode."
    (set-face-background hl-line-face "#550000"))
  (defun _cursor-line-normal ()
    "Revert the current line highlighting back to normal."
    (set-face-background hl-line-face "#4f4f4f"))
  (add-hook 'evil-insert-state-entry-hook  '_cursor-line-highlight)
  (add-hook 'evil-replace-state-entry-hook '_cursor-line-highlight)
  (add-hook 'evil-normal-state-entry-hook  '_cursor-line-normal)

  ;; KEYBINDINGS - ALL MODES
  ;; Unbind the following keys for all evil states
  (evil-define-key nil 'global (kbd "M-h") 'evil-backward-char) ; was mark-paragraph
  (evil-define-key nil 'global (kbd "M-j") 'evil-next-line)     ; was indent-new-line
  (evil-define-key nil 'global (kbd "M-k") 'evil-previous-line) ; was downcase-word
  (evil-define-key nil 'global (kbd "M-l") 'evil-forward-char)  ; was kill-sentence
  (evil-define-key nil 'global (kbd "M-:") 'evil-ex)            ; was eval-expression
  (evil-define-key nil 'global (kbd "M-;") nil) ; was comment-dwim
  ;; (define-key evil-insert-state-map (kbd "M-h") 'evil-normal-state)
  ;; (define-key evil-insert-state-map (kbd "M-j") 'evil-normal-state)
  ;; (define-key evil-insert-state-map (kbd "M-k") 'evil-normal-state)
  ;; (define-key evil-insert-state-map (kbd "M-l") 'evil-normal-state)

  ;; NORMAL MODE _______________________________________________________________

  ;; Switch to last used buffer
  (define-key evil-normal-state-map (kbd "<backspace>") 'evil-buffer)

  ;; Map command mode to ; for speed (in addition to :)
  (define-key evil-normal-state-map (kbd ";") 'evil-ex)

  ;; KEYBINDINGS - NORMAL & VISUAL
  (evil-set-leader '(normal visual) (kbd "<SPC>"))

  ;; KEYBINDINGS - INSERT & REPLACE
  ;; When in insert/replace mode, after dragging the mouse, change to visual mode
  (evil-define-key '(insert replace) global [drag-mouse-1] 'evil-visual-state)
  ;; <leader>O  Open count lines above, stay in normal mode
  (defun _open-above-line(count)
    "Create a blank line above point and remain in normal state"
    (interactive "p")
    (evil-open-above count)
    (evil-normal-state))
  (evil-define-key 'normal 'global (kbd "<leader>O") '_open-above-line)
  ;; <leader>O  Open count lines below, stay in normal mode
  (defun _open-below-line(count)
    "Create a blank line below point and remain in normal state"
    (interactive "p")
    (evil-open-below count)
    (evil-normal-state))
  (evil-define-key 'normal 'global (kbd "<leader>o") '_open-below-line)
  (hl-line-mode)
  (evil-mode 1))

;;; ============================================================================
;;; EVIL-SURROUND - Adds surrounding operator
;; https://github.com/emacs-evil/evil-surround
;; https://www.youtube.com/watch?v=wlR5gYd6um0#t=24m42
;; s = (surrounding) Creates a text-object
;; ys = Add surround
;; yss = Add surrounding to current line
;; If changing to a bracket, left brackets means bracket with space, right bracket means just the bracket
;; e.g. ysiw" = Add surround - inner word - double quote
;; e.g. cst<div> = Change surround <span> to <div>
(use-package evil-surround
  ;;:commands evil-surround-edit
  :after evil
  :commands evil-mode
  :bind (:map evil-operator-state-map
              ("s" . evil-surround-edit))
  :config
  (global-evil-surround-mode 1))

;;; ============================================================================
;;; EVIL-COMMENTARY - Add comment operator
;; https://github.com/linktohack/evil-commentary
;; https://www.youtube.com/watch?v=wlR5gYd6um0#t=26m02
;; Default bindings:
;;   gc = comment operator
;;   gy = comment operator but also yank to register x (i.e. "xgy...)
;;   gcc = comment current line
;;   gyy = comment current line and yank
(use-package evil-commentary
  :after evil
  :bind (:map evil-normal-state-map
              ("gc" . evil-commentary)
              ("gy" . evil-commentary-yank)
              ("s-/" . evil-commentary-line))
  :config
  (evil-commentary-mode))

;; <leader>c{motion} = Comment out current {motion} text
;;(evil-define-key 'normal 'evil-commentary-mode-map (kbd "<leader>c") 'evil-commentary)
;; <leader>C = Comment out current line
;;(evil-define-key 'normal 'evil-commentary-mode-map (kbd "<leader>C") 'evil-commentary-line)
;; <leader>t = Try... Comment out current line and yank it
;;(evil-define-key 'normal 'evil-commentary-mode-map (kbd "<leader>t") 'evil-commentary-yank-line)

;;; ============================================================================
;;; EVIL-REPLACE-WITH-REGISTER - Add replace with register operator
;; https://www.youtube.com/watch?v=wlR5gYd6um0#t=26m49
;; Default bindings:
;;   ["x]gR{motion} (evil-replace-with-register)
(use-package evil-replace-with-register
  :after evil
  :bind (:map evil-normal-state-map
              ("gr" . evil-replace-with-register)
              ("gR" . evil-replace-with-register))
  :config
   (evil-replace-with-register-install))
 
;;; ============================================================================
;;; EVIL-INDENT-PLUS - Add indentation text-objects
;; https://github.com/TheBB/evil-indent-plus/tree
;; https://www.youtube.com/watch?v=wlR5gYd6um0#t=30m02
;; Default bindings:
;;   {operator}{i or a} = i = inner, a = around (includes whitespace), generall just use i version
;;   {operator}{i}i = A block of text with the same or higher indentation.
;;   {operator}{j}i = Same as i, but including the first line above with less indentation (k for up).
;;   {operator}{k}i = Same as i, including the first line above and below with less indentation (j for down).
;; e.g.
;;   if (a = b) {     <-- k and j
;;       pass         <-- i
;;       pass         <-- i
;;   }                <-- j
(use-package evil-indent-plus
  :commands evil-mode
  :config
  (define-key evil-inner-text-objects-map "i" 'evil-indent-plus-i-indent)
  (define-key evil-outer-text-objects-map "i" 'evil-indent-plus-a-indent)
  (define-key evil-inner-text-objects-map "k" 'evil-indent-plus-i-indent-up)
  (define-key evil-outer-text-objects-map "k" 'evil-indent-plus-a-indent-up)
  (define-key evil-inner-text-objects-map "j" 'evil-indent-plus-i-indent-up-down)
  (define-key evil-outer-text-objects-map "j" 'evil-indent-plus-a-indent-up-down))

;;; ============================================================================
;;; EVIL-LINE
;; https://www.youtube.com/watch?v=wlR5gYd6um0#t=31m30
;; To target a line from after whitespace use _

;;; ============================================================================
;;; entire
;; Need to find emacs equivalent
;; https://www.youtube.com/watch?v=wlR5gYd6um0#t=31m08

;;; ============================================================================
;;; EVIL-ESCAPE
;; Customizable key sequence to escape from insert state and everything else in Emacs.
;; https://github.com/syl20bnr/evil-escape
(use-package evil-escape
   :config
   (evil-escape-mode))
;;  :after evil
;;  :bind (:map evil-insert-state-map ("C-[". evil-escape))
;;  :config
;;  (evil-escape-mode))
;; (global-set-key (kbd "C-g") 'evil-escape)
;;   :after evil
;;   :commands evil-escape
;;   :bind (("C-g" . evil-escape)
;;          ("C-[" . evil-escape))
;;          ;;("<escape>" . evil-escape))
;;   :init
;;   :config
;;   (evil-escape-mode))
;;; evil.el ends here

;;     (key-chord-define evil-insert-state-map "jk" 'evil-escape)
;;     (key-chord-define evil-insert-state-map "kj" 'evil-escape)
;;(define-key evil-insert-state-map (kbd "C-[") 'evil-escape)
