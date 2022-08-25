



### ncurses fix

COLOR_PAIR is a c macro , not available to us in sbcl through the foreign
library

 
    A_NORMAL        Normal display (no highlight)
    A_STANDOUT      Best highlighting mode of the terminal.
    A_UNDERLINE     Underlining
    A_REVERSE       Reverse video
    A_BLINK         Blinking
    A_DIM           Half bright
    A_BOLD          Extra bright or bold
    A_PROTECT       Protected mode
    A_INVIS         Invisible or blank mode
    A_ALTCHARSET    Alternate character set
    A_CHARTEXT      Bit-mask to extract a character
    COLOR_PAIR(n)   Color-pair number n 
    
	
	

build a shared library with a routine to give us the ability to perform
COLOR_PAIR and thus get color from ncurses

yak and shaving ...

$ gcc -c -Wall -Werror -fpic foo.c

Step 2: Creating a shared library from an object file

Now we need to actually turn this object file into a shared library. We will call it libfoo.so:

gcc -shared -o libfoo.so foo.o

Step 3: Linking with a shared library

As you can see, that was actually pretty easy. We have a shared library. Let us compile our main.c and link it with libfoo. We will call our final program test. Note that the -lfoo option is not looking for foo.o, but libfoo.so. GCC assumes that all libraries start with lib and end with .so or .a (.so is for shared object or shared libraries, and .a is for archive, or statically linked libraries).

$ gcc -Wall -o test main.c -lfoo
/usr/bin/ld: cannot find -lfoo
collect2: ld returned 1 exit status

Telling GCC where to find the shared library

Uh-oh! The linker does not know where to find libfoo. GCC has a list of places it looks by default, but our directory is not in that list.2 We need to tell GCC where to find libfoo.so. We will do that with the -L option. In this example, we will use the current directory, /home/username/foo:

$ gcc -L/home/username/foo -Wall -o test main.c -lfoo

Step 4: Making the library available at runtime

Good, no errors. Now let us run our program:

$ ./test
./test: error while loading shared libraries: libfoo.so: cannot open shared object file: No such file or directory

Oh no! The loader cannot find the shared library.3 We did not install it in a standard location, so we need to give the loader a little help. We have a couple of options: we can use the environment variable LD_LIBRARY_PATH for this, or rpath. Let us take a look first at LD_LIBRARY_PATH:
Using LD_LIBRARY_PATH

$ echo $LD_LIBRARY_PATH

There is nothing in there. Let us fix that by prepending our working directory to the existing LD_LIBRARY_PATH:

$ LD_LIBRARY_PATH=/home/username/foo:$LD_LIBRARY_PATH
$ ./test
./test: error while loading shared libraries: libfoo.so: cannot open shared object file: No such file or directory

What happened? Our directory is in LD_LIBRARY_PATH, but we did not export it. In Linux, if you do not export the changes to an environment variable, they will not be inherited by the child processes. The loader and our test program did not inherit the changes we made. Thankfully, the fix is easy:

$ export LD_LIBRARY_PATH=/home/username/foo:$LD_LIBRARY_PATH
$ ./test
This is a shared library test...
Hello, I am a shared library


