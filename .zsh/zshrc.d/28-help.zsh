#!/bin/sh

help.findsed() {
  if [ -z "$@" ]
  then
    echo "help.findsed <path> <file mask> <from string> <to string>"
    exit 0
  fi
  find $1 -type f -name "$2" -exec sed -i "s/\$3/\$4/g" {} \;
}

help.reactlc() {
  echo "MOUNTING"
  echo "constructor() => render() => componentDidMount()"
  echo
  echo "UPDATES"
  echo "setState() => render() => componentDidUpdate()"
  echo
  echo "UNMOUNTING"
  echo "componentWillUnmount()"
  echo
  echo "ERROR"
  echo "componentDidCatch()"
}
