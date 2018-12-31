#!/usr/bin/env bash

function install_dotfiles () {
  info 'installing dotfiles'

  overwrite_all=false
  backup_all=false
  skip_all=false

  # shellcheck disable=2044
  for source in $(find "$_DIR_/src" -maxdepth 2 -name \*.\*symlink)
  do

    filename=$(basename "${source%.*}")
    dest="$INSTALL_DIR/$filename"
    if [[ "$source" =~ .dotsymlink ]]; then
      dest="$INSTALL_DIR/.$filename"
    fi

    if [ -f "$dest" ] || [ -d "$dest" ]
    then

      overwrite=false
      backup=false
      skip=false

      if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
      then

        user "File already exists: $(basename "$source"), what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -r -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac
      fi

      # handle overwrites
      if [ "$overwrite" == "true" ] || [ "$overwrite_all" == "true" ]
      then
        rm -rf "$dest"
        success "removed $dest"

      # handle backups
      elif [ "$backup" == "true" ] || [ "$backup_all" == "true" ]
      then
        mv "$dest" "$dest.backup"
        success "moved $dest to $dest.backup"
      fi

      # handle skips
      if [ "$skip" == "true" ] || [ "$skip_all" == "true" ]
      then
        success "skipped $source"

      # linking file
      else
        ln -fs "$source" "$dest"
        success "linked $source to $dest"
      fi
    fi

  done
}

function install_zsh () {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

function install_homebrew () {
  if test "$(uname)" = "Darwin" && test ! "$(command -v brew)"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

function configure_osx () {
  echo "this is osx"
}