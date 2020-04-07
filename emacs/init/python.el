;;; PIP Python packages (in VENV!):
;;     sudo apt -y install python3-pip
;;     python3.X -m pip install flake8

;; (use-package flycheck
;;   :ensure t
;;   ;;:hook python-mode
;;   :init
;;   (setq flycheck-flake8rc (concat user-emacs-directory "config/flake8rc.ini"))
;;   (setq flycheck-python-flake8-executable "python3")
;;   :config
;;   (add-hook 'python-mode-hook 'flycheck-mode)
;;   )

;; ;;; ============================================================================
;; ;;; JEDI - Python autocompletion
;; ;; https://github.com/bbatsov/projectile
;; (use-package evil-replace-with-register)
;; (use-package evil-commentary
;;   :ensure t
;;   :config
;;   (evil-commentary-mode))
