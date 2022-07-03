;;; lsp-cfn.el --- LSP integration for cfn-lsp-extra -*- lexical-binding: t -*-

;; Author: Laurence Warne
;; Maintainer: Laurence Warne
;; Version: 0.1
;; URL: https://github.com/LaurenceWarne/lsp-cfn.el
;; Package-Requires: ((emacs "27.0") (lsp-mode "8.0.0") (yaml-mode "0.0.15"))

;;; Commentary:

;; cfn-lsp-extra setup for lsp-mode.  A lot of the mode setup is copied from
;; https://www.emacswiki.org/emacs/CfnLint.  The snippet stuff is also heavily
;; inspired by https://github.com/AndreaCrotti/yasnippet-snippets.

;;; Code:

(require 'js)
(require 'lsp)
(require 'yaml-mode)

;;; Custom variables

(defgroup lsp-cfn nil
  "LSP integration for cfn-lsp-extra."
  :prefix "lsp-cfn-"
  :group 'applications)

(defcustom lsp-cfn-verbose nil
  "If non-nil, run cfn-lsp-extra in verbose mode."
  :type 'boolean
  :group 'lsp-cfn)

(defcustom lsp-cfn-executable "cfn-lsp-extra"
  "The cfn-lsp-extra executable.

Should be set before the package is loaded, e.g. in the :init
block of a `use-package' declaration."
  :type 'string
  :group 'lsp-cfn)

;;; Constants

(defconst lsp-cfn-snippets-dir
  (expand-file-name
   "snippets"
   (file-name-directory
    ;; Copied from ‘f-this-file’ from f.el.
    (cond
     (load-in-progress load-file-name)
     ((and (boundp 'byte-compile-current-file) byte-compile-current-file)
      byte-compile-current-file)
     (:else (buffer-file-name))))))

(defvar yas-snippet-dirs)

;;; Modes

(define-derived-mode lsp-cfn-json-mode js-mode
  "CFN-JSON"
  "Simple mode to edit CloudFormation template in JSON format."
  (setq js-indent-level 2))

(define-derived-mode lsp-cfn-yaml-mode yaml-mode
  "CFN-YAML"
  "Simple mode to edit CloudFormation template in YAML format.")

;;; Snippet setup

;; Next couple of functions are modified from: https://github.com/AndreaCrotti/yasnippet-snippets

;;;###autoload
(defun lsp-cfn-snippets-initialize ()
  "Load the `lsp-cfn-snippets' snippets directory."
  ;; NOTE: we add the symbol `lsp-cfn-snippets-dir' rather than its
  ;; value, so that yasnippet will automatically find the directory
  ;; after this package is updated (i.e., moves directory).
  (when (and (fboundp 'yas--load-snippet-dirs)
             (fboundp 'yas-load-directory))
    (add-to-list 'yas-snippet-dirs 'lsp-cfn-snippets-dir t)
    (yas--load-snippet-dirs)
    (yas-load-directory lsp-cfn-snippets-dir t)))

;;;###autoload
(with-eval-after-load 'yasnippet
  (lsp-cfn-snippets-initialize))


;;; LSP setup

(add-to-list 'lsp-language-id-configuration
             '(lsp-cfn-json-mode . "cloudformation"))

(add-to-list 'lsp-language-id-configuration
             '(lsp-cfn-yaml-mode . "cloudformation"))

(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection lsp-cfn-executable)
                  :activation-fn (lsp-activate-on "cloudformation")
                  :environment-fn (lambda ()
                                    '(("CFN_LSP_EXTRA_VERBOSE" . lsp-cfn-verbose)))
                  :server-id 'cfn-lsp-extra))

(provide 'lsp-cfn)

;;; lsp-cfn.el ends here
