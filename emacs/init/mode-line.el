;;; package --- Summary
;;    Set the mode-line to my own personal preference.
;;; Commentary:
;;; Code:

;;; ============================================================================
;;; FRAME TITLE
;; Cannot add faces because OS controlled style
(setq-default frame-title-format
	      (list
	       invocation-name
	       ":  "
	       "  "
	       "%b"
	       ;;'(:eval (if (buffer-file-name) (abbreviate-file-name (buffer-file-name)) "%b"))
	       ))

;;; ============================================================================
;;; MODE-LINE
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/_0025_002dConstructs.html#g_t_0025_002dConstructs
;; Debug with:
;;   (force-mode-line-update)

;; Default value for mode-line-format
;;   ("%e" mode-line-front-space mode-line-mule-info mode-line-client mode-line-modified mode-line-remote mode-line-frame-identification mode-line-buffer-identification "   " mode-line-position evil-mode-line-tag
;;    (vc-mode vc-mode)
;;    "  " mode-line-modes mode-line-misc-info mode-line-end-spaces)

;; When the Emacs frame comes in focus, refresh the version control emacs state,
;; so that after a commit and returning, the VC state will be updated.
(add-hook 'focus-in-hook 'vc-refresh-state)

(defun _mode-line-evil()
  "Return the evil state converted to a string, e.g. normal, insert etc."
  (format "%s" evil-mode-line-tag))

(defun _mode-line-dir()
  "Return the current buffer head path formatted with the _mode-line-dir face."
  (let* ((_str (if (buffer-file-name) (abbreviate-file-name (buffer-file-name)) (format-mode-line "%b"))))
    (setq _str (file-name-directory _str))
    (when (null _str) (setq _str ""))
    (put-text-property 0 (length _str) 'face '_mode-line-dir _str)
    _str))

(defun _mode-line-filename()
  "Return the current buffer's file name formatted depending whether it is modified or not."
  (let* ((_str (format-mode-line " %b ")))
    (if (and (buffer-modified-p) (buffer-file-name))
	(put-text-property 0 (length _str) 'face '_mode-line-filename-unsaved _str)
      (put-text-property 0 (length _str) 'face '_mode-line-filename _str))
    _str))
;; (propertize (buffer-name) 'face '(:background "#CCCCCC" :weight bold))))

(defun _mode-line-modified()
  "Takes in the mode-line construct %+ string and change it's value and face."
  (let*  ((_str (format-mode-line "%+")))
    (unless buffer-file-name (setq _str "")) ; Scratch buffer has no buffer name and is not readonly
    (cond
     ((string-equal "*" _str) (propertize " +++ " 'face '(:background "#FF0000" :weight bold)))
     ((string-equal "-" _str) (propertize "     " 'face '(:weight bold)))
     ((string-equal "%" _str) (propertize "  R  " 'face '(:weight bold)))
     (t                       (propertize "  ?  " 'face '(:weight bold))))))

(defun _mode-line-vc()
  "Return the version control status."
  (let*  ((_str ""))
    (when buffer-file-name
      (setq _str (format "%s" (vc-state buffer-file-name))))
    (when (null _str) (setq _str ""))
    (cond
     ((string-equal _str "nil" )        (put-text-property 0 (length _str) 'face 'vc-base-state _str))
     ((string-equal _str "edited" )     (put-text-property 0 (length _str) 'face 'vc-edited-state _str))
     ((string-equal _str "up-to-date")  (put-text-property 0 (length _str) 'face 'vc-up-to-date-state _str))
     ((string-equal _str "added" )      (put-text-property 0 (length _str) 'face 'vc-locall-added-state _str))
     ((string-equal _str "removed" )    (put-text-property 0 (length _str) 'face 'vc-removed-state _str))
     ((string-equal _str "conflict" )   (put-text-property 0 (length _str) 'face 'vc-conflict-state _str))
     (t                                 (propertize _str 'face '()))
     )
    _str))

(defun _mode-line-render (left right)
  "Return a string of `window-width' length containing LEFT, and RIGHT aligned respectively."
  (let* ((available-width (- (window-total-width) (+ (length (format-mode-line left)) (length (format-mode-line right))))))
    (append left (list (format (format "%%%ds" available-width) "")) right)
    )
  )

(defun _mode-line-line-column()
  "Return the line and column numbers formatted for the mode-line."
  (let*  ((_line   (format-mode-line "%l"))
	  (_column (format-mode-line "%C")))
    (format "%5s,%-4s" (format "[%s" _line) (format "%s]" _column))))

(defvar _mode-line-format-left "Combine all the LEFT side mode-line attributes into one string.")
(setq _mode-line-format-left
      (list
       "%e"
       ;;Example
       ;; (propertize "Hello" 'face '(:foreground "orange") 'help-echo "buffer modified.")
       '(:eval (_mode-line-evil))
       ;; '(:eval (_mode-line-modified))
       " "
       '(:eval (_mode-line-dir))
       '(:eval (_mode-line-filename))
       " "
       ))

(defvar _mode-line-format-right "Combine all the RIGHT side mode-line attributes into one string.")
(setq _mode-line-format-right
      (list
       "%]"
       " "
       ;; '(:eval (eglot--mode-line-format))
       " "
       '(vc-mode vc-mode)
       ":"
       '(:eval (_mode-line-vc))
       "  "
       (propertize "%m" 'face '(:foreground "#999999")) ; Major mode
       "  "
       ;; mode-line-position
       '(-3 "%o")
       " "
       '(:eval (_mode-line-line-column))
       ;;(vc-mode 'eglot-mode-line)
       ))

;; Set the mode-line to be the left and right sides combined."
(setq-default mode-line-format
	      (list (list :eval '(_mode-line-render _mode-line-format-left _mode-line-format-right))))

;;; mode-line.el ends here
