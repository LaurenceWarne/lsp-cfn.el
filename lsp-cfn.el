;;; lsp-cfn.el --- cfn-lsp-extra setup for lsp-mode -*- lexical-binding: t -*-

;; Author: Laurence Warne
;; Maintainer: Laurence Warne
;; Version: 0.1
;; Homepage: https://github.com/Laurence Warne/lsp-cfn.el
;; Package-Requires: ((emacs "27.0") (lsp-mode "8.0.0") (yaml-mode "0.0.15"))

;;; Commentary:

;; cfn-lsp-extra setup for lsp-mode.  A lot of the mode setup is copied from
;; https://www.emacswiki.org/emacs/CfnLint.

;;; Code:

(require 'js)
(require 'lsp)
(require 'yaml)

(define-derived-mode cfn-json-mode js-mode
  "CFN-JSON"
  "Simple mode to edit CloudFormation template in JSON format."
  (setq js-indent-level 2))

(add-to-list 'magic-mode-alist
             '("\\({\n *\\)? *[\"']AWSTemplateFormatVersion" . cfn-json-mode))
(add-to-list 'lsp-language-id-configuration
             '(cfn-json-mode . "cloudformation"))
(add-hook 'cfn-json-mode-hook #'lsp-deferred)

(define-derived-mode cfn-yaml-mode yaml-mode
  "CFN-YAML"
  "Simple mode to edit CloudFormation template in YAML format.")
(add-to-list 'magic-mode-alist
             '("\\(---\n\\)?AWSTemplateFormatVersion:" . cfn-yaml-mode))
(add-to-list 'lsp-language-id-configuration
             '(cfn-yaml-mode . "cloudformation"))
(add-hook 'cfn-yaml-mode-hook #'lsp-deferred)

(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection exe)
                  :activation-fn (lsp-activate-on "cloudformation")
                  :server-id 'cfn-lsp-extra))


(provide 'lsp-cfn)

;;; lsp-cfn.el ends here
