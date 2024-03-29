# lsp-cfn.el
[![MELPA](https://melpa.org/packages/lsp-cfn-badge.svg)](https://melpa.org/#/lsp-cfn)

`lsp-mode` integration with [cfn-lsp-extra](https://github.com/LaurenceWarne/cfn-lsp-extra) (a Cloudformation language server), heavily inspired by https://www.emacswiki.org/emacs/CfnLint.

## Installation

First [install](https://github.com/LaurenceWarne/cfn-lsp-extra#installation) `cfn-lsp-extra`.  Then you can install the package from melpa:

```elisp
(use-package lsp-cfn
  :magic (("\\({\n *\\)? *[\"']AWSTemplateFormatVersion" . lsp-cfn-json-mode)
          ;; SAM templates are also supported
          ("\\({\n *\\)? *[\"']Transform[\"']: [\"']AWS::Serverless-2016-10-31" . lsp-cfn-json-mode)
          ("\\(---\n\\)?AWSTemplateFormatVersion:" . lsp-cfn-yaml-mode)
          ("\\(---\n\\)?Transform: AWS::Serverless-2016-10-31" . lsp-cfn-yaml-mode))
  :hook ((lsp-cfn-yaml-mode . lsp-deferred)
         (lsp-cfn-json-mode . lsp-deferred))
  :config
  (setq completion-ignore-case t))
```

`(setq completion-ignore-case t)` is optional, but resource and property names are in CamelCase so you may find completion narrowing better with it.

## Usage

The above configuration will trigger `lsp` whenever a `json` or `yaml` is opened with the string `AWSTemplateFormatVersion:` appearing somwhere in the file.

Alternatively, if you have [`yasnippet`](https://github.com/joaotavora/yasnippet) installed, from an empty file type `aws` and then tab to complete, and that will generate a template skeleton and connect to the LSP server (similarly `sam` will generate the skeleton of a SAM template).

A list of currently implemented features can be found [here](https://github.com/LaurenceWarne/cfn-lsp-extra#features).
