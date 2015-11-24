;; This is a work in progress
;; Start here: https://www.masteringemacs.org/reading-guide
;; See: http://nathantypanski.com/blog/2014-08-03-a-vim-like-emacs-config.html
;;      http://nathantypanski.com/blog/2014-07-02-switching-to-emacs.html
;;      http://bling.github.io/blog/2013/10/27/emacs-as-my-leader-vim-survival-guide/
;;      http://pragmaticemacs.com/
;; See also: http://juanjoalvarez.net/es/detail/2014/sep/19/vim-emacsevil-chaotic-migration-guide/
;;

(require 'package)
(package-initialize)
(setq package-enable-at-startup nil)


(add-to-list 'load-path (concat user-emacs-directory "config"))
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
(require 'use-package)

(use-package color-theme :ensure t)
(use-package color-theme-solarized :ensure t)
(color-theme-solarized)


(use-package evil-leader
      :commands (evil-leader-mode)
      :ensure evil-leader
      :demand evil-leader
      :init
      :config
      (progn
	(evil-leader/set-leader ",")
	(evil-leader/set-key "w" 'save-buffer)
	(evil-leader/set-key "q" 'kill-buffer-and-window)
	)
      )

(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

(use-package elisp-slime-nav :ensure t)
(defun my-lisp-hook ()
  (elisp-slime-nav-mode)
  (turn-on-eldoc-mode)
  )
(add-hook 'emacs-lisp-mode-hook 'my-lisp-hook)
(evil-define-key 'normal emacs-lisp-mode-map (kbd "K")
  'elisp-slime-nav-describe-elisp-thing-at-point)

(eval-after-load 'ibuffer
  '(progn
     (evil-set-initial-state 'ibuffer-mode 'normal)
     (evil-define-key 'normal ibuffer-mode-map
       (kbd "m") 'ibuffer-mark-forward
       (kbd "t") 'ibuffer-toggle-marks
       (kbd "u") 'ibuffer-unmark-forward
       (kbd "=") 'ibuffer-diff-with-file
       (kbd "j") 'evil-next-line
       (kbd "k") 'evil-previous-line
       (kbd "l") 'ibuffer-visit-buffer
       (kbd "M-g") 'ibuffer-jump-to-buffer
       (kbd "M-s a C-s") 'ibuffer-do-isearch
       (kbd "M-s a M-C-s") 'ibuffer-do-isearch-regexp
       ;; ...
       )
     )
   )

(require 'dired-x)

(use-package deft
  :ensure deft
  :config
  (progn
    (setq deft-extension "org")
    (setq deft-directory "~/journal")
    (setq deft-use-filename-as-title t)
    (setq deft-recursive t)))

(use-package magit
  :ensure magit
  :config
  (progn
    (evil-set-initial-state 'magit-mode 'normal)
    (evil-set-initial-state 'magit-status-mode 'normal)
    (evil-set-initial-state 'magit-diff-mode 'normal)
    (evil-set-initial-state 'magit-log-mode 'normal)
    (evil-define-key 'normal magit-mode-map
        "j" 'magit-goto-next-section
        "k" 'magit-goto-previous-section)
    (evil-define-key 'normal magit-log-mode-map
        "j" 'magit-goto-next-section
        "k" 'magit-goto-previous-section)
    (evil-define-key 'normal magit-diff-mode-map
        "j" 'magit-goto-next-section
        "k" 'magit-goto-previous-section)))

;; TODO:This doesn't seem to work
(custom-set-faces
  '(default ((t (:family "Pragmata" :foundry "outline" :slant normal :weight normal)))))

(tool-bar-mode -1)
(visual-line-mode 1)

;; Run a shell in emacs
(global-set-key [f2] 'ansi-term)
;; see https://www.masteringemacs.org/article/running-shells-in-emacs-overview
;; see also: https://www.masteringemacs.org/article/complete-guide-mastering-eshell

;; Keep this at the bottom of the file.
(require 'evil)
(evil-mode 1)
(set-background-color "#000010")
