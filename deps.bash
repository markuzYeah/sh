#! /usr/bin/env sh

fn_setup_redis(){
  #redisVer='2.6.12'
  redisVer='2.8.0-rc2'
  redisCurVer="$(redis-server --version |cut -d' ' -f3| cut -d'=' -f2)"
  if [ "$redisCurVer" = "$redisVer" ]; then
    return
  fi

 # redisURL="http://redis.googlecode.com/files/redis-$redisVer.tar.gz"
  redisURL="http://download.redis.io/releases/redis-$redisVer.tar.gz"
  err=10
  srcDir="redis-$redisVer"

  cd "$TMP" &&
  curl "$redisURL" | tar -zvx &&
  cd "$srcDir" && 
  make && 
  sleep 1 &&
  cd "$TMP/$srcDir/src" && 
  #make test &&
  cp redis-benchmark redis-check-aof redis-check-dump redis-cli redis-server "$BIN" &&
  cd "$CUR_DIR" || exit $err
}

fn_setup_nodejs(){
  
  #ndVer='0.10.15'
  ndVer='0.11.5'

  ndCurVer="$(node --version| tr -d 'v')"
  if [ "$ndCurVer" = "$ndVer" ]; then
    return
  fi

  ndURL="http://nodejs.org/dist/v$ndVer/node-v$ndVer.tar.gz"

  err=11
  cd "$TMP" &&
  curl "$ndURL" | tar -zvx &&
  cd "node-v$ndVer" &&
  ./configure --prefix="$SRC" &&
  make &&
  make install &&
  #make test &&
  cp "out/Release/node" "$BIN/node-v$ndVer" &&
  ln -s "$BIN/node-v$ndVer" "$BIN/node" &&
  cp -R "deps/npm" "$BIN/npm-node-v$ndVer" &&
  ln -s "$BIN/npm-node-v$ndVer/bin/npm-cli.js" "$BIN/npm" &&
  cd "$CUR_DIR" || exit $err

}

main(){
  
  CUR_DIR="$PWD"
  TMP="$CUR_DIR/.tmp/"
  BIN="$CUR_DIR/.bin/"
  SRC="$CUR_DIR/.src/"

  err=98
  [ -d "$TMP" ] || { mkdir -p "$TMP" || exit $err;}
  [ -d "$BIN" ] || { mkdir -p "$BIN" || exit $err;} 
  [ -d "$SRC" ] || { mkdir -p "$SRC" || exit $err;} 

  fn_setup_redis
  fn_setup_nodejs
  #fn_setup_apache
}

main
echo 'done'



