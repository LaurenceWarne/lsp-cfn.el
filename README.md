# lsp-cfn.el

`lsp-mode` integration with [cfn-lsp-extra](https://github.com/LaurenceWarne/cfn-lsp-extra) (a Cloudformation language server), heavily inspired by https://www.emacswiki.org/emacs/CfnLint.

## Installation

First [install](https://github.com/LaurenceWarne/cfn-lsp-extra#installation) `cfn-lsp-extra`.  ~~You can then install this package from source, e.g. using ![quelpa-use-package](https://github.com/quelpa/quelpa-use-package)~~ *There currently appears to be issues with the quelpa installation.*:

```elisp
(use-package lsp-cfn
  :ensure nil
  :demand t
  :quelpa (lsp-cfn :fetcher github :repo "LaurenceWarne/lsp-cfn.el")
  :hook ((lsp-cfn-yaml-mode . lsp-deferred)
         (lsp-cfn-json-mode . lsp-deferred))
  :config
  (setq company-keywords-ignore-case t))
``

Or [straight](https://github.com/radian-software/straight.el):

```elisp
(use-package lsp-cfn
  :demand t
  :straight (lsp-cfn
	         :type git
	         :host github
             :repo "LaurenceWarne/lsp-cfn.el")
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
