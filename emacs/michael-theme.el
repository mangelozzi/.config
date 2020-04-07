;;; michael-theme.el --- Emacs theme with a dark background and bright colors for.

;; Author: Michael Angelozzi
;; URL: https://github.com/michael-angelozzi/.emacs.d.git
;; Version: 0.1
;; Keywords: michael theme
;; Package-Requires: ((evil "1.0.0"))

;; This file is not part of GNU Emacs.

;;; License:

;;; Commentary:

;; WARNING: If checked out on Windows via GIT, CR will be replaced with CRLF
;; Emacs will generate ERRORS about the header not having a package version.

;; See a list of colors with:             list-colors-display
;; See a list of items for styling with:  list-faces-display

;; Show the face under the cursor
;;https://stackoverflow.com/questions/1242352/get-font-face-under-cursor-in-emacs

;; See a list of face options, e.g. underline, overline, bold, italic etc
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Face-Attributes.html#Face-Attributes

;;; Code:

(defface _mode-line-dir `((t ()))        "Face for michael's modeline dir"
  :group  'michael)
(defface _mode-line-filename `((t ()))   "Face for michael's modeline filename"
  :group  'michael)
(defface _mode-line-filename-unsaved `((t ()))   "Face for michael's modeline filename"
  :group  'michael)

(deftheme michael)
(let ((class '((class color) (min-colors 89)))
      (fg1 "#ffffff")
      (fg2 "#e8e8e8")
      (fg3 "#d1d1d1")
      (fg4 "#bbbbbb")
      (bg1 "#000000")
      (bg2 "#181818")
      (bg3 "#282828")
      (bg4 "#393939")
      (key2 "#054124")
      (key3 "#e01105")
      (builtin "#adff00")
      (keyword "#ff0000")
      (const   "#00ffff")
      (comment "#00cf52")
      (func    "#ffb400")
      (str     "#00ff00")
      (type    "#ffff00")
      (var     "#ffbded")
      (warning "#ff00f5"))
  (custom-theme-set-faces
   'michael
   ;; DEFAULT
   ;;`(default 	                ((,class (:foreground "#FFFFFF" :background "#000000" :distant-foreground "#000000"))))
   `(default                       ((,class (:inherit nil
                                             :stipple nil
                                             :background "#000000"
                                             :foreground "#FFFFFF"
                                             :inverse-video nil
                                             :box nil
                                             :strike-through nil
                                             :overline nil
                                             :underline nil
                                             :slant normal
                                             :weight normal
                                             :height 110
                                             :width normal
                                             :foundry "pyrs"
                                             :family "Roboto Mono"))))
   `(fixed-pitch                   ((,class (:family "Roboto Mono"))))
   `(scroll-bar                    ((,class (:background "#FF0000"))))
   `(variable-pitch                ((,class (:family "Roboto"))))

   ;; LINE NUMBERS
   `(line-number	           ((,class (:foreground "#00CC00" :background "#3F3F3F"))))
   `(line-number-current-line	   ((,class (:foreground "#4F4F4F" :background "#00CC00" :bold t))))
   ;; SEARCHING
                                        ; /search
   `(isearch                       ((,class (:foreground "#000000" :background "#00FF00" :bold t)))) 
                                        ; /search highlighting of matches elsewhere on the screen
   `(lazy-highlight                ((,class (:foreground "#FFFFFF" :background "#007700" :bold t))))  
   ;; CODE HIGHLIGHTING
   `(font-lock-builtin-face        ((,class (:foreground ,builtin))))
   `(font-lock-comment-face        ((,class (:foreground ,comment :slant italic))))
   `(font-lock-negation-char-face  ((,class (:foreground ,const))))
   `(font-lock-reference-face      ((,class (:foreground ,const))))
   `(font-lock-constant-face       ((,class (:foreground ,const))))
   `(font-lock-doc-face            ((,class (:foreground ,comment))))
   `(font-lock-function-name-face  ((,class (:foreground ,func :bold t))))
   `(font-lock-keyword-face        ((,class (:foreground ,keyword :bold t))))
   `(font-lock-string-face         ((,class (:foreground ,str))))
   `(font-lock-type-face           ((,class (:foreground ,type ))))
   `(font-lock-variable-name-face  ((,class (:foreground ,var))))
   `(font-lock-warning-face        ((,class (:foreground ,warning :background ,bg2))))
   ;; WHITESPACE (WhiteSpaceMode replaces the old BlankMode)
   ;; Refer to below for the glyphs used for whitespace
   ;; Trailing whitespace before end of a line
   `(whitespace-trailing           ((,class (:foreground "#005500" :background "#FF0000"))))
   ;; The style for lines which go beyond whitespace-line-column
   `(whitespace-line               ((,class (:background "#550000"))))
   `(whitespace-empty              ((,class (:foreground "#005500" :background "#0000FF"))))
   `(whitespace-hspace             ((,class (:foreground "#005500" :background "#0000FF"))))
   `(whitespace-indentation        ((,class (:foreground "#005500" :background "#0000FF"))))
   `(whitespace-newline            ((,class (:foreground "#005500" :background "#0000FF"))))
   `(whitespace-space              ((,class (:foreground "#005500" :background "#0000FF"))))
   `(whitespace-space-after-tab    ((,class (:foreground "#005500" :background "#0000FF"))))
   `(whitespace-space-before-tab   ((,class (:foreground "#005500" :background "#0000FF"))))
   `(whitespace-tab                ((,class (:foreground "#005500" :background "#0000FF"))))
   ;; VISUAL SELECTION
   `(region                        ((,class (:background "#888888"))))
   ;; CURSOR RELATED
   ;; hl-line is overridden by hooks when enter insert mode and leaving normal mode
   `(hl-line                       ((,class (:background "#4F4F4F"))))
   ;; Only background takes affect on the custor face
   `(cursor                        ((,class (:background "#FFFFFF"))))
   ;; When on a parenthis, highlights the corresponding opening/closing bracket
   `(show-paren-match ((,class (:foreground "#00FF00" :background "#000000" :underline t :distant-foreground "#FFFFFF" :bold t))))
   `(minibuffer-prompt             ((,class (:foreground "#000000" :background "#00FF00" :bold t))))
   ;; MODE-LINE
   ;; Mode-line active buffer
   `(mode-line                     ((,class (:foreground "#3F3F3F" :background "#00CC00"))))
                                        ;`(mode-line ((,class (:box (:line-width 1 :color nil) :foreground "#3F3F3F" :background "#00CC00" :bold t))))
   ;;`(mode-line-inactive ((,class (:box (:line-width 1 :color nil :style pressed-button) :foreground ,key3 :background ,bg1 :weight normal))))
   ;; Mode-line other buffers
   `(mode-line-inactive            ((,class (:foreground "#3F3F3F" :background "#AAAAAA" :weight normal))))
   ;;`(mode-line-inactive            ((,class (:foreground ,key3 :background ,bg1 :weight normal))))
   `(mode-line-buffer-id           ((,class (:foreground "#000000" :background nil :bold t))))
   `(mode-line-buffer-id-inactive  ((,class (:foreground "#000000" :background nil :bold t))))
   `(mode-line-highlight           ((,class (:foreground ,keyword :box nil :weight bold))))
   `(mode-line-emphasis            ((,class (:foreground ,fg1))))
   `(_mode-line-dir                ((,class ())))
   `(_mode-line-filename           ((,class (:background "#CCCCCC" :weight bold))))
   `(_mode-line-filename-unsaved   ((,class (:foreground "#FF0000" :background "#FFFFFF" :weight bold))))
   `(eglot-mode-line               ((,class (:distant-foreground "#888888" :foreground "#888888" :weight light))))
   ;; VC-MODE (Version Control)
   `(vc-state-base                 ((,class (:distant-foreground "#009900" :foreground "#009900" :weight light))))
   `(vc-up-to-date-state           ((,class (:foreground "#009900" :distant-foreground "#009900" ))))
   `(vc-edited-state               ((,class (:foreground "#DD0000" :weight bold))))
   `(vc-locally-added-state        ((,class (:foreground "#008800" :distant-foreground "#008800" :weight bold  ))))
   `(vc-removed-state              ((,class (:foreground "#FF8800" :weight bold))))
   `(vc-missing-state              ((,class (:foreground "#FF0000" :weight bold))))
   `(vc-conflict-state             ((,class (:foreground "#FFFF00" :weight bold))))
   ;; OTHER
   `(match  ((,class (:foreground "#FF00FF" :background "#FFFF00" :bold t)))) ; !!! WHAT IS THIS?jj
   `(highlight ((,class (:bold t :foreground "#000000" :background "#00FF00")))) ; Not sure but I changed it
   `(fringe ((,class (:background ,bg2 :foreground ,fg4))))
   `(vertical-border ((,class (:foreground ,fg3))))
   `(default-italic ((,class (:italic t))))
   `(link ((,class (:foreground ,const :underline t))))
   `(org-code ((,class (:foreground ,fg2))))
   `(org-hide ((,class (:foreground ,fg4))))
   `(org-level-1 ((,class (:bold t :foreground ,fg2 :height 1.1))))
   `(org-level-2 ((,class (:bold nil :foreground ,fg3))))
   `(org-level-3 ((,class (:bold t :foreground ,fg4))))
   `(org-level-4 ((,class (:bold nil :foreground ,bg4))))
   `(org-date ((,class (:underline t :foreground ,var) )))
   `(org-footnote  ((,class (:underline t :foreground ,fg4))))
   `(org-link ((,class (:underline t :foreground ,type ))))
   `(org-special-keyword ((,class (:foreground ,func))))
   `(org-block ((,class (:foreground ,fg3))))
   `(org-quote ((,class (:inherit org-block :slant italic))))
   `(org-verse ((,class (:inherit org-block :slant italic))))
   `(org-todo ((,class (:box (:line-width 1 :color ,fg3) :foreground ,keyword :bold t))))
   `(org-done ((,class (:box (:line-width 1 :color ,bg3) :bold t :foreground ,bg4))))
   `(org-warning ((,class (:underline t :foreground ,warning))))
   `(org-agenda-structure ((,class (:weight bold :foreground ,fg3 :box (:color ,fg4) :background ,bg3))))
   `(org-agenda-date ((,class (:foreground ,var :height 1.1 ))))
   `(org-agenda-date-weekend ((,class (:weight normal :foreground ,fg4))))
   `(org-agenda-date-today ((,class (:weight bold :foreground ,keyword :height 1.4))))
   `(org-agenda-done ((,class (:foreground ,bg4))))
   `(org-scheduled ((,class (:foreground ,type))))
   `(org-scheduled-today ((,class (:foreground ,func :weight bold :height 1.2))))
   `(org-ellipsis ((,class (:foreground ,builtin))))
   `(org-verbatim ((,class (:foreground ,fg4))))
   `(org-document-info-keyword ((,class (:foreground ,func))))
   `(font-latex-bold-face ((,class (:foreground ,type))))
   `(font-latex-italic-face ((,class (:foreground ,key3 :italic t))))
   `(font-latex-string-face ((,class (:foreground ,str))))
   `(font-latex-match-reference-keywords ((,class (:foreground ,const))))
   `(font-latex-match-variable-keywords ((,class (:foreground ,var))))
   `(ido-only-match ((,class (:foreground ,warning))))
   `(org-sexp-date ((,class (:foreground ,fg4))))
   `(ido-first-match ((,class (:foreground ,keyword :bold t))))
   `(gnus-header-content ((,class (:foreground ,keyword))))
   `(gnus-header-from ((,class (:foreground ,var))))
   `(gnus-header-name ((,class (:foreground ,type))))
   `(gnus-header-subject ((,class (:foreground ,func :bold t))))
   `(mu4e-view-url-number-face ((,class (:foreground ,type))))
   `(mu4e-cited-1-face ((,class (:foreground ,fg2))))
   `(mu4e-cited-7-face ((,class (:foreground ,fg3))))
   `(mu4e-header-marks-face ((,class (:foreground ,type))))
   `(ffap ((,class (:foreground ,fg4))))
   `(js2-private-function-call ((,class (:foreground ,const))))
   `(js2-jsdoc-html-tag-delimiter ((,class (:foreground ,str))))
   `(js2-jsdoc-html-tag-name ((,class (:foreground ,key2))))
   `(js2-external-variable ((,class (:foreground ,type  ))))
   `(js2-function-param ((,class (:foreground ,const))))
   `(js2-jsdoc-value ((,class (:foreground ,str))))
   `(js2-private-member ((,class (:foreground ,fg3))))
   `(js3-warning-face ((,class (:underline ,keyword))))
   `(js3-error-face ((,class (:underline ,warning))))
   `(js3-external-variable-face ((,class (:foreground ,var))))
   `(js3-function-param-face ((,class (:foreground ,key3))))
   `(js3-jsdoc-tag-face ((,class (:foreground ,keyword))))
   `(js3-instance-member-face ((,class (:foreground ,const))))
   `(warning ((,class (:foreground ,warning))))
   `(ac-completion-face ((,class (:underline t :foreground ,keyword))))
   `(info-quoted-name ((,class (:foreground ,builtin))))
   `(info-string ((,class (:foreground ,str))))
   `(icompletep-determined ((,class :foreground ,builtin)))
   `(undo-tree-visualizer-current-face ((,class :foreground ,builtin)))
   `(undo-tree-visualizer-default-face ((,class :foreground ,fg2)))
   `(undo-tree-visualizer-unmodified-face ((,class :foreground ,var)))
   `(undo-tree-visualizer-register-face ((,class :foreground ,type)))
   `(slime-repl-inputed-output-face ((,class (:foreground ,type))))
   `(rainbow-delimiters-depth-1-face ((,class :foreground ,fg1)))
   `(rainbow-delimiters-depth-2-face ((,class :foreground ,type)))
   `(rainbow-delimiters-depth-3-face ((,class :foreground ,var)))
   `(rainbow-delimiters-depth-4-face ((,class :foreground ,const)))
   `(rainbow-delimiters-depth-5-face ((,class :foreground ,keyword)))
   `(rainbow-delimiters-depth-6-face ((,class :foreground ,fg1)))
   `(rainbow-delimiters-depth-7-face ((,class :foreground ,type)))
   `(rainbow-delimiters-depth-8-face ((,class :foreground ,var)))
   `(magit-item-highlight ((,class :background ,bg3)))
   `(magit-section-heading        ((,class (:foreground ,keyword :weight bold))))
   `(magit-hunk-heading           ((,class (:background ,bg3))))
   `(magit-section-highlight      ((,class (:background ,bg2))))
   `(magit-hunk-heading-highlight ((,class (:background ,bg3))))
   `(magit-diff-context-highlight ((,class (:background ,bg3 :foreground ,fg3))))
   `(magit-diffstat-added   ((,class (:foreground ,type))))
   `(magit-diffstat-removed ((,class (:foreground ,var))))
   `(magit-process-ok ((,class (:foreground ,func :weight bold))))
   `(magit-process-ng ((,class (:foreground ,warning :weight bold))))
   `(magit-branch ((,class (:foreground ,const :weight bold))))
   `(magit-log-author ((,class (:foreground ,fg3))))
   `(magit-hash ((,class (:foreground ,fg2))))
   `(magit-diff-file-header ((,class (:foreground ,fg2 :background ,bg3))))
   `(term ((,class (:foreground ,fg1 :background ,bg1))))
   `(term-color-black ((,class (:foreground ,bg3 :background ,bg3))))
   `(term-color-blue ((,class (:foreground ,func :background ,func))))
   `(term-color-red ((,class (:foreground ,keyword :background ,bg3))))
   `(term-color-green ((,class (:foreground ,type :background ,bg3))))
   `(term-color-yellow ((,class (:foreground ,var :background ,var))))
   `(term-color-magenta ((,class (:foreground ,builtin :background ,builtin))))
   `(term-color-cyan ((,class (:foreground ,str :background ,str))))
   `(term-color-white ((,class (:foreground ,fg2 :background ,fg2))))
   `(rainbow-delimiters-unmatched-face ((,class :foreground ,warning)))
   `(helm-header ((,class (:foreground ,fg2 :background ,bg1 :underline nil :box nil))))
   `(helm-source-header ((,class (:foreground ,keyword :background ,bg1 :underline nil :weight bold))))
   `(helm-selection ((,class (:background ,bg2 :underline nil))))
   `(helm-selection-line ((,class (:background ,bg2))))
   `(helm-visible-mark ((,class (:foreground ,bg1 :background ,bg3))))
   `(helm-candidate-number ((,class (:foreground ,bg1 :background ,fg1))))
   `(helm-separator ((,class (:foreground ,type :background ,bg1))))
   `(helm-time-zone-current ((,class (:foreground ,builtin :background ,bg1))))
   `(helm-time-zone-home ((,class (:foreground ,type :background ,bg1))))
   `(helm-buffer-not-saved ((,class (:foreground ,type :background ,bg1))))
   `(helm-buffer-process ((,class (:foreground ,builtin :background ,bg1))))
   `(helm-buffer-saved-out ((,class (:foreground ,fg1 :background ,bg1))))
   `(helm-buffer-size ((,class (:foreground ,fg1 :background ,bg1))))
   `(helm-ff-directory ((,class (:foreground ,func :background ,bg1 :weight bold))))
   `(helm-ff-file ((,class (:foreground ,fg1 :background ,bg1 :weight normal))))
   `(helm-ff-executable ((,class (:foreground ,key2 :background ,bg1 :weight normal))))
   `(helm-ff-invalid-symlink ((,class (:foreground ,key3 :background ,bg1 :weight bold))))
   `(helm-ff-symlink ((,class (:foreground ,keyword :background ,bg1 :weight bold))))
   `(helm-ff-prefix ((,class (:foreground ,bg1 :background ,keyword :weight normal))))
   `(helm-grep-cmd-line ((,class (:foreground ,fg1 :background ,bg1))))
   `(helm-grep-file ((,class (:foreground ,fg1 :background ,bg1))))
   `(helm-grep-finish ((,class (:foreground ,fg2 :background ,bg1))))
   `(helm-grep-lineno ((,class (:foreground ,fg1 :background ,bg1))))
   `(helm-grep-match ((,class (:foreground nil :background nil :inherit helm-match))))
   `(helm-grep-running ((,class (:foreground ,func :background ,bg1))))
   `(helm-moccur-buffer ((,class (:foreground ,func :background ,bg1))))
   `(helm-source-go-package-godoc-description ((,class (:foreground ,str))))
   `(helm-bookmark-w3m ((,class (:foreground ,type))))
   `(company-echo-common ((,class (:foreground ,bg1 :background ,fg1))))
   `(company-preview ((,class (:background ,bg1 :foreground ,key2))))
   `(company-preview-common ((,class (:foreground ,bg2 :foreground ,fg3))))
   `(company-preview-search ((,class (:foreground ,type :background ,bg1))))
   `(company-scrollbar-bg ((,class (:background ,bg3))))
   `(company-scrollbar-fg ((,class (:foreground ,keyword))))
   `(company-tooltip ((,class (:foreground ,fg2 :background ,bg1 :bold t))))
   `(company-tooltop-annotation ((,class (:foreground ,const))))
   `(company-tooltip-common ((,class ( :foreground ,fg3))))
   `(company-tooltip-common-selection ((,class (:foreground ,str))))
   `(company-tooltip-mouse ((,class (:inherit highlight))))
   `(company-tooltip-selection ((,class (:background ,bg3 :foreground ,fg3))))
   `(company-template-field ((,class (:inherit region))))
   `(web-mode-builtin-face ((,class (:inherit ,font-lock-builtin-face))))
   `(web-mode-comment-face ((,class (:inherit ,font-lock-comment-face))))
   `(web-mode-constant-face ((,class (:inherit ,font-lock-constant-face))))
   `(web-mode-keyword-face ((,class (:foreground ,keyword))))
   `(web-mode-doctype-face ((,class (:inherit ,font-lock-comment-face))))
   `(web-mode-function-name-face ((,class (:inherit ,font-lock-function-name-face))))
   `(web-mode-string-face ((,class (:foreground ,str))))
   `(web-mode-type-face ((,class (:inherit ,font-lock-type-face))))
   `(web-mode-html-attr-name-face ((,class (:foreground ,func))))
   `(web-mode-html-attr-value-face ((,class (:foreground ,keyword))))
   `(web-mode-warning-face ((,class (:inherit ,font-lock-warning-face))))
   `(web-mode-html-tag-face ((,class (:foreground ,builtin))))
   `(jde-java-font-lock-package-face ((t (:foreground ,var))))
   `(jde-java-font-lock-public-face ((t (:foreground ,keyword))))
   `(jde-java-font-lock-private-face ((t (:foreground ,keyword))))
   `(jde-java-font-lock-constant-face ((t (:foreground ,const))))
   `(jde-java-font-lock-modifier-face ((t (:foreground ,key3))))
   `(jde-jave-font-lock-protected-face ((t (:foreground ,keyword))))
   `(jde-java-font-lock-number-face ((t (:foreground ,var))))
   ))

;; ;;; WHITESPACE GLYPHS
;; ;; Face used to visualize SPACE.
;; (setq whitespace-space "·")
;; ;; Face used to visualize HARD SPACE (aka none breaking space) (using a bottom square bracket to visualize it).
;; (setq whitespace-hspace "⎵")
;; ;; Face used to visualize TAB.
;; (setq whitespace-tab "▒")
;; ;; Face used to visualize NEWLINE char mapping.
;; (setq whitespace-newline "^")
;; ;; Face used to visualize trailing blanks.
;; (setq whitespace-trailing "$")
;; ;; Face used to visualize “long” lines.
;; (setq whitespace-line "↩")
;; ;; Face used to visualize SPACEs before TAB.
;; (setq whitespace-space-before-tab "█")
;; ;; Face used to visualize 8 or more SPACEs at beginning of line.
;; (setq whitespace-indentation "8")
;; ;; Face used to visualize empty lines at beginning and/or end of buffer.
;; (setq whitespace-empty "-")
;; ;; Face used to visualize 8 or more SPACEs after TAB
;; (setq whitespace-space-after-tab "8")


;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'michael)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; michael-theme.el ends here
