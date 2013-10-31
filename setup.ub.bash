#! /usr/bin/env sh

fn_setup_init(){
  pkgsBasic="build-essential curl wget git-core openssl libssl-dev gfortran"
  pkgsBasic="$pkgsBasic openssh-server openssh-client libreadline-dev"
  pkgsBasic="$pkgsBasic libsqlite3-dev libbz2-dev libssl-dev tcl8.5 curl"
  #pkgsBasic="$pkgsBasic vim-nox zsh"
  pkgsBasic="$pkgsBasic vim-nox zsh git-flow"
  pkgsInstall="$pkgsBasic"
  #
  # NOTE: This will edit you /etc/apt/source.list file
  # adding apt-get restricted repositories by editing
  # /etc/apt/sources.list file
  #
  err=10
  if ! [ -f '/etc/apt/sources.list.bak' ]; then
    sudo chmod 777 /etc/apt &&
    sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak &&
    sudo cat /etc/apt/sources.list.bak | sed -e 's;^# deb http; deb http;' -e 's;^# deb-src ; deb-src ;' > /etc/apt/sources.list &&
    sudo chmod 755 /etc/apt || exit $err
  fi
  #
  err=11
  sudo apt-get -y update &&
  sudo apt-get -y upgrade &&
  sudo apt-get -y install --no-install-recommends $pkgsInstall &&
  sudo apt-get -y autoremove || exit $err
}
#
fn_setup_sys(){
  #
  # clone repo
  #
  err=12
  gitRepo='dotfiles'
  gitAcc='markuzYeah'
  gitAddress="git://github.com/$gitAcc/$gitRepo.git"
  #
  cd $HOME
  [ -d "$HOME/.dotfiles" ] && exit 0
  git clone "$gitAddress" || exit $err
  #
  # setup startup scripts, bashrc, passwd, host
  #
  # err=13
  # bak=~/.backup
  # #
  # [ -d "$bak" ] || { mkdir -p "$bak" || exit $err;}
  # mv ~/.bashrc  ~/.vimrc ~/.vim ~/.zshrc ~/.backups/. 2>/dev/null
  # sed -i -e "s;HOST=.*;HOST=ub.$HOST;" "$HOME/.dotfiles/exportrc"
  #  (ln -s ~/.dotfiles/bashrc ~/.bashrc
  #  ln -s ~/.dotfiles/.dircolors ~/.dircolors
  #  ln -s ~/.dotfiles/zshrc ~/.zshrc
  #  ln -s ~/.dotfiles/aliasrc ~/.aliasrc
  #  ln -s ~/.dotfiles/exportrc ~/.exportrc
  #  ln -s ~/.dotfiles/fns ~/.fns
  #  ln -s ~/.dotfiles/vimrc ~/.vimrc
  #  ln -s ~/.dotfiles/vim ~/.vim ) 2>/dev/null
  #  #
  #  cd "$CUR_DIR"
}
#
main(){
  CUR_DIR="$PWD"
  TMP="$CUR_DIR/.tmp/"
  BIN="$CUR_DIR/.bin/"
  SRC="$CUR_DIR/.src/"
  #
  err=98
  [ -d "$TMP" ] || { mkdir -p "$TMP" || exit $err;}
  [ -d "$BIN" ] || { mkdir -p "$BIN" || exit $err;}
  [ -d "$SRC" ] || { mkdir -p "$SRC" || exit $err;}
  fn_setup_init
  fn_setup_sys

  
}
main
echo 'done'
