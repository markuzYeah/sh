#! /usr/bin/env sh

fn_setup_init(){
  #
  which brew &> /dev/null || {
    err=10
    brewURL='https://github.com/mxcl/homebrew/tarball/master'
    srcDir='homebrew'
    #
    ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)" || exit $err
  }
  #
  err=11
  brew -v doctor &&
  brew -v update &&
  brew -v upgrade || exit $err
  #
  pkgsBasic="node redis"
  for pkg in $pkgsBasic; do
    [ "$pkg" = 'redis' ] && pkg='redis-server'
    which "$pkg" &> /dev/null || brew -v install "$pkg"
  done
}
#
fn_setup_sys(){
  #
  # clone repo
  #
  err=14
  cd $HOME
  gitRepo='sh'
  gitAcc='markuzYeah'
  gitAddress="git://github.com/$gitAcc/$gitRepo.git"

  cd $HOME

  [ -d "$HOME/$gitRepo" ] && return 0
  #
  plat='mac'
  gitURL="https://raw.github.com/$gitAcc/$gitRepo/setup.git.bash"
  python -c "import urllib2; print urllib2.urlopen('$gitURL').read()" | sh || exit $err
  echo "${HOST%%.*}, $plat"
  [ ${HOST%%.*} != "$plat" ] &&
  sed -i -e "s;HOST=.*;HOST=$plat.$HOST;" "$gitRepo/exportrc"

  (mv -n .bash_profile .backup
  ln -s "$gitRepo/bash_profile" .bash_profile ) &> /dev/null

  cd $CUR_DIR

  #
  # TODO:
  # setup startup scripts, bashrc, passwd, host
  #
  #
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
echo 'done settting up this mac'
