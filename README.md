# lsp-cfn.el
[![MELPA](https://melpa.org/packages/lsp-cfn-badge.svg)](https://melpa.org/#/lsp-cfn)

`lsp-mode` integration with [cfn-lsp-extra](https://github.com/LaurenceWarne/cfn-lsp-extra) (a Cloudformation language server), heavily inspired by https://www.emacswiki.org/emacs/CfnLint.

## Installation

First [install](https://github.com/LaurenceWarne/cfn-lsp-extra#installation) `cfn-lsp-extra`.  Then you can install it from melpa:

```elisp
(use-package lsp-cfn
  :magic (("\\({\n *\\)? *[\"']AWSTemplateFormatVersion" . lsp-cfn-json-mode)
          ("\\(---\n\\)?AWSTemplateFormatVersion:" . lsp-cfn-yaml-mode))
  :hook ((lsp-cfn-yaml-mode . lsp-deferred)
         (lsp-cfn-json-mode . lsp-deferred))
  :config
  (setq company-keywords-ignore-case t))
```

If you're using company, `(setq company-keywords-ignore-case t)` is optional, but completions will be a lot better with it.

## Usage

The above configuration will trigger `lsp` whenever a `json` or `yaml` is opened with the string `AWSTemplateFormatVersion:` appearing somwhere in the file.

Alternatively, if you have [`yasnippet`](https://github.com/joaotavora/yasnippet) installed, from an empty file type `aws` and then tab to complete, and that will generate a template skeleton and connect to the LSP server.

A list of currently implemented features can be found [here](https://github.com/LaurenceWarne/cfn-lsp-extra#features).
