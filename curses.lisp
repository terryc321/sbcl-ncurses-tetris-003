

;; highly impressed at common lisp ffi ability to get this working with just these headers

;; even more impressed i managed to make it work.



(defpackage "CURSES"
  (:use "CL" "CL-USER" "SB-ALIEN"))

(in-package "CURSES")


(load-shared-object "/home/terry/balthazar/sbcl-ncurses-tetris-003//clib/libfix.so")

;; sanity check - runs a c program prints stuff on the console terminal and waits for key press
(define-alien-routine demo void)

;; COLOR_PAIR is a C macro , not in the shared library as a callable
(define-alien-routine color-pair int
  (p int))


(load-shared-object "/usr/lib/x86_64-linux-gnu/libncurses.so.6.2")


(define-alien-routine has-colors int)

(define-alien-routine init-pair int
  (pair int)
  (foreground int)
  (background int))


(defvar COLOR-BLACK     0)
(defvar COLOR-RED       1)
(defvar COLOR-GREEN     2)
(defvar COLOR-YELLOW    3)
(defvar COLOR-BLUE      4)
(defvar COLOR-MAGENTA   5)
(defvar COLOR-CYAN      6)
(defvar COLOR-WHITE     7)



;; A- reminder it is an attribute
;; (attr-on (or'd A B))

(defvar A-NORMAL 0)
(defvar A-STANDOUT 65536)
(defvar A-UNDERLINE 131072)
(defvar A-REVERSE  262144)
(defvar A-BLINK    524288)
(defvar A-DIM      1048576)
(defvar A-BOLD     2097152)
(defvar A-PROTECT  16777216)
(defvar A-INVIS    8388608)
(defvar A-CHARTEXT 255)


(define-alien-routine getmaxx int
  (win (* int)))

(define-alien-routine getmaxy int
  (win (* int)))


(define-alien-routine color-set int
  (s int))

(define-alien-routine attron int
  (a int))

(define-alien-routine attroff int
  (a int))


(define-alien-routine init-color int
  (r int)
  (g int)
  (b int))


(define-alien-routine start-color int)

(define-alien-routine clear  int)

(define-alien-routine raw  int)

(define-alien-routine noecho  int)

(define-alien-routine nodelay int
  (w (* int))
  (b boolean))


(define-alien-routine clrtoeol  int)

(define-alien-routine cbreak  int)

(define-alien-routine wgetch  int
  (w (* int)))

(define-alien-routine refresh  int)

(define-alien-routine initscr  (* int))

(define-alien-routine endwin  int)

(define-alien-routine mvprintw
  int
  (y int)
  (x int)
  (str c-string))

(define-alien-routine printw  int
  (str c-string))







