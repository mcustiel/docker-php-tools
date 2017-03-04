#!/bin/bash

function fail {
    echo $1
    exit 1
}

function print_usage {
    echo "Usage: ./install [-n|--no-copy] [-d|--destination-dir DIR]"
    echo "Options:"
    echo "    -d DIR"
    echo "    --destination-dir DIR Copy php-tool-run files to the specified directory"
    echo "                          (defaults to /usr/local/bin)"
}

CURDIR=$(dirname $0)

DESTDIR=/usr/local/bin

options=($@)

while [ "${#options[@]}" -gt 0 ]; do
  case "${options[0]}" in
    -d|--destination-dir)
      DESTDIR=$(realpath ${options[1]})
      if [ ! -d $DESTDIR ]; then
        fail "Option ${options[0]} requires a path to a directory as an argument."
      fi
      options=(${options[@]:1})
      ;;
    -h|--help|--usage)
      print_usage
      exit 0
      ;;
    *)
      print_usage
      echo ""
      fail "Invalid argument ${options[0]}"
      ;;
  esac
  options=(${options[@]:1})
done

cp -v $CURDIR/php-tool-run $DESTDIR
cp -v $CURDIR/php5-tool-run $DESTDIR

