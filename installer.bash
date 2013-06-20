#! /usr/bin/env sh

#
##
#

gitAcc='markuzYeah'
gitRepo='sh'
gitBranch='master'

export GIT_PATH="$gitAcc/$gitRepo/$gitBranch"

if uname -v | grep -qi 'ubuntu'; then
  setup="https://raw.github.com/$GIT_PATH/setup.ub.bash"
  deps="https://raw.github.com/$GIT_PATH/deps.bash"

  python -c "import urllib2; print urllib2.urlopen('$setup').read()"|sh
  #python -c "import urllib2; print urllib2.urlopen('$deps').read()"|sh
    
#elif uname -v | grep -qi 'centos'; then
  
  #python -c "import urllib2; print urllib2.urlopen('$urlLinux').read()"|sh
elif uname -v | grep -qi 'darwin'; then
  setup="https://raw.github.com/$GIT_PATH/sh/setup.mac.bash"
  #deps="https://raw.github.com/$GIT_PATH/sh/deps.bash"

  python -c "import urllib2; print urllib2.urlopen('$setup').read()"|sh
  #python -c "import urllib2; print urllib2.urlopen('$deps').read()"|sh
fi


