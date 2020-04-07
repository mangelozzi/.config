;;; ============================================================================
;;; PROGRAMMING
(defun _infer-indentation-style ()
  ;; if our source file uses tabs, we use tabs, if spaces spaces, and if
  ;; neither, we use the current indent-tabs-mode
  (let ((space-count (how-many "^  " (point-min) (point-max)))
        (tab-count (how-many "^\t" (point-min) (point-max))))
    ;; If leading tab count is greater, use tabs, else use spaces
    (if (> tab-count space-count) (setq-local indent-tabs-mode t)
      (setq-local indent-tabs-mode nil))))

(defun _prod-mode-setup ()
  "Setup functionality suited for programming."
  (whitespace-mode)
  ;;(setq-local indent-tabs-mode nil)
  (_infer-indentation-style)               ; Check whether should use buffer or tabs
  (setq-local whitespace-mode 1)           ; Enable showing certain whitespace
  (setq-local truncate-lines t)            ; Turn off word wrap
  )
(add-hook 'prog-mode-hook '_prod-mode-setup)

;;; ============================================================================
;;; Projectile - Project Management
;; https://github.com/bbatsov/projectile

(use-package magit
  :disabled t)

;; COMPANY - Show autocomplete eglot popup menu
(use-package company
  ;;:commands (eglot-ensure)
  :init
  (setq company-minimum-prefix-length 2)
  (setq company-show-numbers (quote (quote t)))
  (setq company-preview '((t (:background "salmon" :foreground "gold"))))
  (setq company-tooltip-annotation '((t (:foreground "green"))))
  (setq company-tooltip-annotation-selection '((t (:inherit company-tooltip-annotation :background "white smoke" :foreground "black"))))
  (setq company-tooltip-common '((t (:foreground "magenta" :slant italic))))
  (setq company-minimum-prefix-length 0)
  (setq company-lsp-cache-candidates 'auto)
  (setq company-idle-delay 0.2) ;; default is 0.2
  )

;; COMPANY-QUICKHELP - Show function help next to current autocomplete recomendation
;; https://github.com/company-mode/company-quickhelp
(use-package company-quickhelp
  :commands (eglot-ensure)
  :init
  (setq company-quickhelp-color-background "#008800")
  (setq company-quickhelp-color-foreground "black")
  (setq company-quickhelp-use-propertized-text t)
  (setq company-quickhelp-delay 0.3)
  :config
  (company-quickhelp-mode)
  )
;;; 
;;; ;; https://github.com/joaotavora/eglot/blob/master/README.md
;;; (use-package eglot
;;;   :defer
;;;   :hook ((c-mode . eglot-ensure)
;;;          (css-mode . eglot-ensure)
;;;          (python-mode . eglot-ensure))
;;;   :init
;;;   ;;(setq eglot-put-doc-in-help-buffer t)
;;;   ;;(setq eglot-auto-display-help-buffer t)
;;;   (setq eglot-send-changes-idle-time 0.3)
;;;   (setq lazy-highlight-initial-delay 0)
;;;   :config
;;;   ;; Company mode required for popup auto complete menu
;;;   (add-hook 'eglot-managed-mode-hook 'company-mode)
;;;   (add-hook 'eglot-managed-mode-hook 'company-quickhelp-mode)
;;;   ;;(shell-command "source /home/michael/linkcube/venv/bin/activate")
;;;   ;;(pyvenv-activate "/home/michael/linkcube/venv/bin/")
;;;   (add-to-list 'eglot-server-programs '(css-mode . ("css-languageserver" "--stdio")))
;;;   ;;(setq eglot-ignored-server-capabilites (quote (:documentHighlightProvider)))
;;;   ;;(add-hook 'python-mode-hook 'eglot-ensure)
;;;   )

;;; ============================================================================
;;; LISP
(defun _emacs-lisp-setup()
  (setq-local whitespace-line-column 80)
  )
(add-hook 'emacs-lisp-mode-hook '_emacs-lisp-setup)

;;; ============================================================================
;;; PYTHON
(defun _python-setup()
  (setq-local whitespace-line-column 80)
  )
(add-hook 'python-mode-hook '_python-setup)

;;; ============================================================================
;;; CSS
(defun _css-setup()
  (setq-local whitespace-line-column 80)
  (message "CSS Mode")
  )
(add-hook 'css-mode-hook '_css-setup)

;;; ============================================================================
;;; JAVSCRIPT
;; Make underscore a word character in Python and JavaScript
;; (add-hook 'python-mode-common-hook
;;  (lambda () (modify-syntax-entry ?_ "w")))

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)
(use-package flycheck :init (global-flycheck-mode))

(use-package lsp-mode
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (python-mode . lsp-deferred)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :init
  (setq lsp-ui-doc-header t)
  (setq lsp-ui-doc-include-signature t)
  (setq lsp-ui-doc-include-function-signatures t)
  (setq lsp-ui-doc-include-function-signatures t
        lsp-eldoc-render-all t
        lsp-enable-completion-at-point t)
  (setq gc-cons-threshold (* 2 100000000)) ;; 100MB
  (setq read-process-output-max (* 1024 1024)) ;; 1MB
  (setq lsp-idle-delay 0.5) ;; default is 0.2s
  :commands lsp lsp-derred)
