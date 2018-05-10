# git-infer

Commit your staged files with an auto-generated message.

## Installation

Just make sure `git-infer` is executable and in your $PATH.

## Examples

```
$ echo node_modules > .gitignore

$ git add .gitignore

$ git infer
[master (root-commit) 2b34524] Add .gitignore
 1 file changed, 1 insertion(+)
 create mode 100644 .gitignore

$ echo build >> .gitignore

$ git add .gitignore

$ git infer
[master 0b7132a] Update .gitignore
 1 file changed, 1 insertion(+)
```
