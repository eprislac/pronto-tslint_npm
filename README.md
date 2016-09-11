# Pronto runner for ESLint (using eslint from npm)

[![Code Climate](https://codeclimate.com/github/doits/pronto-eslint_npm.svg)](https://codeclimate.com/github/doits/pronto-eslint_npm)
[![Build Status](https://travis-ci.org/doits/pronto-eslint_npm.svg?branch=master)](https://travis-ci.org/doits/pronto-eslint_npm)
[![Gem Version](https://badge.fury.io/rb/pronto-eslint_npm.svg)](http://badge.fury.io/rb/pronto-eslint_npm)
[![Dependency Status](https://gemnasium.com/doits/pronto-eslint_npm.svg)](https://gemnasium.com/doits/pronto-eslint_npm)

Pronto runner for [ESlint](http://eslint.org), pluggable linting utility for JavaScript and JSX. [What is Pronto?](https://github.com/mmozuras/pronto)

Uses system wide installed eslint in contrast to [pronto-eslint][pronto-eslint].

[pronto-eslint]: https://github.com/mmozuras/pronto-eslint

## Prerequisites

You'll need to install [eslint by yourself with npm][eslint-install].

[eslint-install]: http://eslint.org/docs/user-guide/getting-started

## Configuration of ESLint

Configuring ESLint via [.eslintrc and consorts][eslintrc] and excludes via [.eslintignore][eslintignore] will work just fine with pronto-eslint.

[eslintrc]: http://eslint.org/docs/user-guide/configuring#configuration-file-formats

[eslintignore]: http://eslint.org/docs/user-guide/configuring#ignoring-files-and-directories

## Configuration of ESLintNPM

Pronto::ESLintNPM can be configured by placing a `.pronto_eslint_npm.yml` inside the directory
where pronto is run.

Following options are available:

| Option            | Meaning                                                                           | Default                             |
| ----------------- | --------------------------------------------------------------------------------- | ----------------------------------- |
| eslint_executable | ESLint executable to call                                                         | `eslint` (calls `eslint` in `PATH`) |
| files_to_lint     | What files to lint. Absolute path of the file will be matched against this regexp | `(\.js|\.es6)$`                     |

Example configuration to call custom eslint executable and only lint files ending with `.my_custom_extension`:

```yaml
# .pronto_eslint_npm.yaml
eslint_executable: '/my/cusom/node/path/.bin/eslint'
files_to_lint: '\.my_custom_extension$'
```
