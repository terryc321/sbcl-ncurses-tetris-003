#!/bin/bash


#gcc -c some shared library magic ...
#-L/home/username/foo

#gcc -c -Wall -Werror -fPIC fix.c
#gcc -o constants -Wall -Werror -fPIC constants.c

gcc -c -Wall -Werror -fPIC fix.c

gcc -shared -o libfix.so fix.o -lncurses -lpthread -lgc


gcc -o constants -Wall -Werror constants.c -lncurses













