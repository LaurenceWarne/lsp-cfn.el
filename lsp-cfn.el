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
(require 'yaml-mode)

(defgroup lsp-cfn nil
  "lsp integration for cfn-lsp-extra."
  :prefix "lsp-cfn-"
  :group 'applications)

(defcustom lsp-cfn-verbose nil
  "If non-nil, run cfn-lsp-extra in verbose mode."
  :type 'boolean
  :group 'lsp-cfn)

(define-derived-mode lsp-cfn-json-mode js-mode
  "CFN-JSON"
  "Simple mode to edit CloudFormation template in JSON format."
  (setq js-indent-level 2))

(add-to-list 'magic-mode-alist
             '("\\({\n *\\)? *[\"']AWSTemplateFormatVersion" . lsp-cfn-json-mode))
(add-to-list 'lsp-language-id-configuration
             '(lsp-cfn-json-mode . "cloudformation"))

(define-derived-mode lsp-cfn-yaml-mode yaml-mode
  "CFN-YAML"
  "Simple mode to edit CloudFormation template in YAML format.")

(add-to-list 'magic-mode-alist
             '("\\(---\n\\)?AWSTemplateFormatVersion:" . lsp-cfn-yaml-mode))
(add-to-list 'lsp-language-id-configuration
             '(lsp-cfn-yaml-mode . "cloudformation"))

(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection "cfn-lsp-extra")
                  :activation-fn (lsp-activate-on "cloudformation")
                  :environment-fn (lambda ()
                                    '(("CFN_LSP_EXTRA_VERBOSE" . lsp-cfn-verbose)))
                  :server-id 'cfn-lsp-extra))


(provide 'lsp-cfn)

;;; lsp-cfn.el ends here
