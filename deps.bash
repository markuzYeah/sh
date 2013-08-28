#! /usr/bin/env sh

fn_setup_redis(){
  #redisVer='2.6.12'
  

  redisVer='2.8.0-rc3'
  [ -d "$BIN/redis-$redisVer" ] && {
    echo 'skiping redis ...'
    sleep 2
    return
  }



  # redisCurVer="$(redis-server --version |cut -d' ' -f3| cut -d'=' -f2)"
  # if [ "$redisCurVer" = "$redisVer" ]; then
  #   return
  # fi

 # redisURL="http://redis.googlecode.com/files/redis-$redisVer.tar.gz"
  redisURL="http://download.redis.io/releases/redis-$redisVer.tar.gz"
  err=10
  srcDir="redis-$redisVer"

  cd "$BIN"
  rm redis-benchmark redis-check-aof redis-check-dump redis-cli redis-sentinel redis-server 2>/dev/null

  curl "$redisURL" | tar -zvx &&
  cd "$srcDir" && 
  make && 
  sleep 1 &&
  #make test &&
  ln -s "$srcDir/src/redis-benchmark" "$srcDir/src/redis-check-aof" "$srcDir/src/redis-check-dump" "$srcDir/src/redis-cli" "$srcDir/src/redis-sentinel" "$srcDir/src/redis-server" "$BIN/." &&
  cd "$CUR_DIR" || exit $err
}

fn_setup_nodejs(){
  
  ndVer='0.10.17'
  #ndVer='0.11.5'

  [ -d "$BIN/node-v$ndVer" ] && {
    echo 'skipping nodejs...' 
    sleep 2
    return
  }

  # ndCurVer="$(node --version| tr -d 'v')"
  # if [ "$ndCurVer" = "$ndVer" ]; then
  #     echo
  #     echo "node version $ndVer already installed"
  #     echo
  #   return
  # fi

  ndURL="http://nodejs.org/dist/v$ndVer/node-v$ndVer.tar.gz"

  cd "$BIN"
  rm node npm 2>/dev/null

  err=11
  curl "$ndURL" | tar -zvx && 
  cd "$BIN/node-v$ndVer"
  #./configure && make & make install && cd "$BIN"
  ./configure && make & cd "$BIN"
  # #make test &&
  ln -s "node-v$ndVer/out/Release/node" "$BIN/node" &&
  ln -s "node-v$ndVer/deps/npm/bin/npm-cli.js" "$BIN/npm" &&
  cd "$CUR_DIR" || exit $err

}


fn_setup_mongodb(){
  echo 'mongodb installing ...'
}

fn_setup_ruby(){
  echo 'ruby installing ...'
}

fn_setup_nginx(){
  echo 'nginx installing ...'
}

fn_setup_test(){
  echo '\n\nNOW tme to test\nthis step must be done separated, everytime a VM reboots, juts in case'
}

main(){
  
  CUR_DIR="$PWD"
  BIN="$HOME/bin/"

  err=98

  [ -d "$BIN" ] || { mkdir -p "$BIN" || exit $err;} 

  fn_setup_redis
  fn_setup_mongodb
  fn_setup_nodejs
  fn_setup_ruby
  fn_setup_nginx
  fn_setup_test
}

main
echo '\n\ndone'



