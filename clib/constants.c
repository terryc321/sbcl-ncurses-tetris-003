

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


int main(){

  /*
  	 ncurses constants
	 
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
  */
  
  printf("(defvar *A-NORMAL* %u)\n", A_NORMAL);
  printf("(defvar *A-STANDOUT* %u)\n", A_STANDOUT);  
  printf("(defvar *A-UNDERLINE* %u)\n", A_UNDERLINE); 
  printf("(defvar *A-REVERSE*  %u)\n", A_REVERSE);  
  printf("(defvar *A-BLINK*    %u)\n", A_BLINK);  
  printf("(defvar *A-DIM*      %u)\n", A_DIM);  
  printf("(defvar *A-BOLD*     %u)\n", A_BOLD);  
  printf("(defvar *A-PROTECT*  %u)\n", A_PROTECT);  
  printf("(defvar *A-INVIS*    %u)\n", A_INVIS);  
  printf("(defvar *A-CHARTEXT* %u)\n", A_CHARTEXT);  


  
  

  

  return 0;
}

	  



