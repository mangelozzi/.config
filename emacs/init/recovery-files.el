;;; ============================================================================
;;; LOCK FILE e.g .#file
;; Lock files tell other instances of Emacs that this file is already open
;; (setq create-lockfiles nil)

;;; ============================================================================
;;; BACKUPS e.g. file~
;; Emacs makes backups of files when you work on a file then save it
;; Like version control on every save
;; Debug with (either one):
;;   (make-backup-file-name--default-function buffer-file-name)
;;   (funcall make-backup-file-name-function buffer-file-name)
(setq vc-make-backup-files t)
(setq version-control t       ;; Use version numbers for backups.
      kept-new-versions 10  ;; Number of newest versions to keep.
      kept-old-versions 0   ;; Number of oldest versions to keep.
      delete-old-versions t ;; Don't ask to delete excess backup versions.
      backup-by-copying t)  ;; Copy all files, don't rename them.
;; Default and per-save backups go here:
;; "." means all files backup into same absolute dir name
(setq backup-directory-alist `(("." . ,(concat _tmp-dir "backups/"))))

;;; ============================================================================
;;; AUTOSAVES e.g #file#
;; Must escape the backslash in lisp
;; Emacs makes autosaves while editing files (every 30s or 300 keystrokes)
;; Debug with (WARNING!! init.el name already calculated, so wont apply):
;;   buffer-auto-save-file-name
(setq auto-save-list-file-prefix (concat _tmp-dir "auto-saves/list/"))
(setq auto-save-file-name-transforms
      `((".*" ,(concat _tmp-dir "auto-saves/") t)))
;; Old code:
;;   Replace '/' or '\' with '__' so its a valid filename
;;   (concat user-emacs-directory "file-autosaves/" (replace-regexp-in-string "[/\\]" "|" buffer-file-name))
