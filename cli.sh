#!/bin/zsh
echo 'start';
if [ $1 = 'f' ]; then
    echo 'freezed';
    dart run build_runner build
fi;
if [ $1 = 'r' ]; then
    echo 'riverpod';
    flutter pub run build_runner watch
fi;
echo 'end';