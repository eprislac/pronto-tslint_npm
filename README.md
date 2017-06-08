# Pronto runner for TSLint (using tslint from npm)
(forked from doits/pronto-eslint_npm)

![Build Status](https://travis-ci.org/eprislac/pronto-tslint_npm.svg?branch=master "Build Status")
[![Code Climate](https://codeclimate.com/github/eprislac/pronto-tslint_npm/badges/gpa.svg)](https://codeclimate.com/github/eprislac/pronto-tslint_npm)
[![Test Coverage](https://codeclimate.com/github/eprislac/pronto-tslint_npm/badges/coverage.svg)](https://codeclimate.com/github/eprislac/pronto-tslint_npm/coverage)
[![Issue Count](https://codeclimate.com/github/eprislac/pronto-tslint_npm/badges/issue_count.svg)](https://codeclimate.com/github/eprislac/pronto-tslint_npm)

Pronto runner for [TSlint](https://palantir.github.io/tslint/), pluggable linting utility for TypeScript. [What is Pronto?](https://github.com/mmozuras/pronto)

Uses official tslint executable installed by `npm`.

## Prerequisites

You'll need to install [tslint by yourself with npm][tslint-install]. If `tslint` is in your `PATH`, everything will simply work, otherwise you have to provide pronto-tslint-npm your custom executable path (see [below](#configuration-of-tslintnpm)).

[eslint-install]: https://palantir.github.io/tslint/

## Installation

```
gem install pronto-tslint_npm
```

## Configuration of TSLint

Configuring TSLint via [tslint.json][tslint.json] will work just fine with pronto-eslint-npm.

[tslint.json]: https://palantir.github.io/tslint/usage/configuration/

<!-- [tslintignore]: http://eslint.org/docs/user-guide/configuring#ignoring-files-and-directories -->

## Configuration of TSLintNPM

pronto-tslint-npm can be configured by placing a `.pronto_tslint_npm.yml` inside the directory where pronto is run.

Following options are available:

| Option            | Meaning                                                                                  | Default                             |
| ----------------- | ---------------------------------------------------------------------------------------- | ----------------------------------- |
| tslint_executable | TSLint executable to call.                                                               | `tslint` (calls `tslint` in `PATH`) |
| files_to_lint     | What files to lint. Absolute path of offending file will be matched against this Regexp. | `(\.ts)$`                     |

Example configuration to call custom eslint executable and only lint files ending with `.my_custom_extension`:

```yaml
# .pronto_tslint_npm.yml
tslint_executable: '/my/custom/node/path/.bin/tslint'
files_to_lint: '\.my_custom_extension$'
```
