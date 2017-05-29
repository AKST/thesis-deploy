#!/bin/bash

server_files() {
  find ../analysis \
    -type d \( -path ../analysis/env -o -path ../analysis/.git -o -path "*/__pycache__" \) -prune -o \
    -type f -o -type d
}

ui_files() {
  find ../ui \
    -type d \( -path ../ui/.git -o \
               -path ../ui/node_modules -o \
               -path ../ui/tmp -o \
               -path ../ui/dist \) -prune -o \
    -type f -o -type d
}

move_to_staging() {
  local new_loc=$(echo $1 | sed 's/^../staging/')
  if [ -d "$1" ]; then
    [ -d "$new_loc" ] && continue
    mkdir "$new_loc"
  else
    cp $1 $new_loc
  fi
}

main() {
  local root=$(pwd)
  local staging_dir=$root/staging
  local server_dir=$root/staging/analysis
  local ui_dir=$root/staging/ui

  rm -rf ./staging
  mkdir "$staging_dir"
  mkdir "$server_dir"
  mkdir "$ui_dir"

  for file in `server_files`; do
    move_to_staging $file
  done

  for file in `ui_files`; do
    move_to_staging $file
  done

}

main $@
