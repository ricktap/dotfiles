#!/usr/bin/env bash

# internal print method
function _output () {
  COL=${3:-33}
  printf "\r[ \033[0;%dm%2s\033[0m ] %s " "$COL" "$2" "$1"
}

# prints a horizontal line
function hl () {
  printf "%80s\n" "" | tr " " "#"
}

# prints an info text
function info () {
  _output "$1" "INFO" "36"
  printf "\n"
}

function user () {
  _output "$1" " ?! "
}

function success () {
  _output "$1" " OK " "32"
  printf "\n"
}

function fail () {
  _output "$1" "FAIL" "31"
  printf "\n\n"
  exit
}