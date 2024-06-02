#!/usr/bin/env just --justfile

alias p := package
alias c := clean
alias r := run
alias t := test
alias w := watch
alias wt := watch-test

set ignore-comments

default: test

clean:
  rm -rf targets/
  rm -f tests/quantumojo.mojopkg

package:
  mkdir -p targets/
  mojo package quantumojo -o targets/quantumojo.mojopkg

run CMD:
  mojo run {{CMD}}

test: package
  # The tests are in a subdirectory,
  # so they can't see the top-level quantumojo package...
  # unless we add a __init__.mojo file to the tests directory...
  # but that somehow breaks `mojo test` discovery?
  find tests/ -type d -exec cp targets/quantumojo.mojopkg {}/quantumojo.mojopkg \;
  mojo test

watch CMD:
  watchfiles '{{CMD}}' quantumojo/ examples/ tests/**/*.mojo

watch-test: (watch 'just test')
