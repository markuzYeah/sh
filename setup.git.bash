#! /usr/bin/env sh

main(){
  #
  # clone repo
  #
  err=12
  gitRepo='.dotfiles'
  gitAcc='tomatoNuts'
  gitAddress="$gitAcc/$gitRepo.git"
  gitURL="github.com"
  #
  cd $HOME
  git clone "git://$gitURL/$gitAddress" && cd "$gitRepo" &&
  git remote set-url origin "git@$gitURL:$gitAddress" ||  exit $err
  #
  # setup startup scripts, bashrc, passwd, host
  #
  err=13
  bak=~/.backup
  #
  [ -d "$bak" ] || { mkdir -p "$bak" || exit $err;}
  #
  files="bashrc vimrc vim zshrc aliasrc exportrc fns gitignore_global"
  for file in $files; do
    # mv -n option DOESN'T overwrite a file.
    (mv -n "$HOME/.$file" "$bak"
     ln -s "$gitRepo/$file" "$HOME/.$file") &> /dev/null
  done
  git config --global core.excludesfile ~/.gitignore_global 
  #
  cd "$CUR_DIR"
}
#
main
echo 'done setting up basic git'
