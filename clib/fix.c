
/*
https://www.cprogramming.com/tutorial/shared-libraries-linux-gcc.html



*/

#include <stdlib.h>
#include <ncurses.h>


int color_pair(int n) {
  return COLOR_PAIR(n);
}



void demo(){
  initscr();			/* Start curses mode 		*/
  if(has_colors() == FALSE)
    {	endwin();
      printf("Your terminal does not support color\n");
      exit(1);
    }
  start_color();			/* Start color 			*/
  init_pair(1, COLOR_RED, COLOR_BLACK);

  attron(COLOR_PAIR(1));
  printw("Your terminal does not support color\n");    
  //print_in_middle(stdscr, LINES / 2, 0, 0, "Viola !!! In color ...");
  attroff(COLOR_PAIR(1));
  getch();
  endwin();
}






