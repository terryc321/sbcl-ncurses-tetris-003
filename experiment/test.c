



#include <stdlib.h>
#include <stdio.h>
#include <curses.h>

int main(int argc,char **argv){

  int ch;
  char *str = "this is a test string";
  
  WINDOW *win;
  win = initscr();
  clear();
  raw();
  noecho();
  nodelay(win,1);
  cbreak();
 
  // setup
  if( has_colors() ){
    start_color();
    init_pair(1, COLOR_YELLOW , COLOR_BLUE);
    color_set(1,NULL);
  }

  attron(COLOR_PAIR(1));
  mvprintw(5,5,str);
  attroff(COLOR_PAIR(1));

  mvprintw(6,5,str);
  
  attron(COLOR_PAIR(1));
  mvprintw(7,5,str);
  attroff(COLOR_PAIR(1));


  while(1){
    ch = wgetch(win);
    if (ch == 'q'){
      break;
    }
  }
  clrtoeol();
  endwin();    
  
  // cleanup
  return 0;
}



