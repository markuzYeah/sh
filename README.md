### To setup dev env and install deps on Ubuntu or OSX, run the following.

python -c 'import urllib2; print urllib2.urlopen("https://raw.github.com/markuzYeah/sh/master/installer.bash").read()' | sh

### And to compile and install nodejs v0.10.15 and redis v2.8.0-rc2 on $PATH/.bin

python -c 'import urllib2; print urllib2.urlopen("https://raw.github.com/markuzYeah/sh/master/deps.bash").read()' | sh

# todo

test all this install *after* all compilation is done

