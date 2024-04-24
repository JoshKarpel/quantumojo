#!/usr/bin/env just --justfile

alias p := package
alias c := clean
alias r := run
alias t := test
alias w := watch
alias wt := watch-test

default: test

clean:
  rm -rf targets/
  rm -f tests/quantumojo.mojopkg

package: clean
  mkdir -p targets/
  mojo package quantumojo -o targets/quantumojo.mojopkg

run CMD:
  mojo run {{CMD}}

test: package
  cp targets/quantumojo.mojopkg tests/quantumojo.mojopkg
  mojo test

watch CMD:
  watchfiles '{{CMD}}' quantumojo/ examples/ tests/ --ignore-paths tests/quantumojo.mojopkg

watch-test: (watch 'just test')
