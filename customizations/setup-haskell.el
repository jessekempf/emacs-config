(add-hook 'haskell-mode-hook 'haskell-doc-mode)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)

(setq haskell-process-type 'stack-ghci)
(setq haskell-process-path-ghci "stack")
(setq haskell-process-args-ghci "ghci")

(require 'flycheck)
(require 'flycheck-haskell)
(add-hook 'haskell-mode-hook 'flycheck-mode)
(add-hook 'flycheck-mode-hook 'flycheck-haskell-configure)

;; configure completions
(require 'company)
(add-hook 'haskell-mode-hook 'company-mode)
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
;(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(add-to-list 'company-backends 'company-ghc)
(custom-set-variables '(company-ghc-show-info t))

(defun complete-or-indent ()
  (interactive)
  (if (company-manual-begin)
      (company-complete-common)
    (indent-according-to-mode)))

(eval-after-load 'haskell-mode
  `(define-key haskell-mode-map [tab] 'complete-or-indent))

;; (defadvice haskell-mode-stylish-buffer (around skip-if-flycheck-errors activate)
  ;; (unless (flycheck-has-current-errors-p 'error)
    ;; ad-do-it))
(setq haskell-stylish-on-save t)
