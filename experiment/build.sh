#!/bin/bash



rm -f test.o test

#gcc -I/usr/include test.c -o test.o
#ld  -L/usr/lib/x86_64-linux-gnu/ -shared -fPIC -o test test.o  -lncurses 

gcc test.c -lncurses




