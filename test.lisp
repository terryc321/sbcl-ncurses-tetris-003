

;;(ql:quickload :uiop)

(uiop:define-package :test
    (:use :cl))

(in-package :test)



(defmacro with-black( &rest body)
  `(progn
     (curses::attron (curses::color-pair 1))
     ,@body
     (curses::attroff (curses::color-pair 1))))


(defmacro with-white( &rest body)
  `(progn
     (curses::attron (curses::color-pair 8))
     ,@body
     (curses::attroff (curses::color-pair 8))))


(defmacro with-red( &rest body)
  `(progn
     (curses::attron (curses::color-pair 2))
     ,@body
     (curses::attroff (curses::color-pair 2))))


(defmacro with-green( &rest body)
  `(progn
     (curses::attron (curses::color-pair 3))
     ,@body
     (curses::attroff (curses::color-pair 3))))


(defmacro with-yellow( &rest body)
  `(progn
     (curses::attron (curses::color-pair 4))
     ,@body
     (curses::attroff (curses::color-pair 4))))

(defmacro with-blue( &rest body)
  `(progn
     (curses::attron (curses::color-pair 5))
     ,@body
     (curses::attroff (curses::color-pair 5))))


(defmacro with-magenta( &rest body)
  `(progn
     (curses::attron (curses::color-pair 6))
     ,@body
     (curses::attroff (curses::color-pair 6))))


(defmacro with-cyan( &rest body)
  `(progn
     (curses::attron (curses::color-pair 7))
     ,@body
     (curses::attroff (curses::color-pair 7))))


(defmacro draw-xy(x y)
  `(curses::mvprintw ,y ,x " "))

(defmacro screen-width()
  '(curses::getmaxx window))

(defmacro screen-height()
  '(curses::getmaxy window))


(defun half(x)
  (floor (/ x 2)))


(defmacro clear-screen ()
  (let ((x (gensym))
	(y (gensym))
	(screen-width (gensym))
	(screen-height (gensym)))
    `(let
	 ((,screen-width (+ -1 (screen-width)))
	  (,screen-height (+ -1 (screen-height))))
       (loop for ,x from 0 to ,screen-width do
	     (loop for ,y from 0 to ,screen-height do
		   (draw-xy ,x ,y))))))





(defmacro border-around-screen()
  (let ((x (gensym))
	(y (gensym))
	(screen-width (gensym))
	(screen-height (gensym)))
    `(let
	 ((,screen-width  (+ -1 (screen-width)))
	  (,screen-height (+ -1 (screen-height))))
       (dolist (,y (list 0 ,screen-height))
	 (loop for ,x from 0 to ,screen-width do
	   (draw-xy ,x ,y)))
       (dolist (,x (list 0 ,screen-width))
	 (loop for ,y from 0 to ,screen-height do
	   (draw-xy ,x ,y))))))





;; ever decreasing border
(defmacro decreasing-border-screen()
  (let ((x (gensym))
	(y (gensym))
	(n (gensym))
	(screen-width (gensym))
	(screen-height (gensym)))
    `(let
	 ((,screen-width (half (+ -1 (screen-width))))
	  (,screen-height (half (+ -1 (screen-height))))
			  
	  (,n 0))
       (loop for n from 0 to (half ,screen-width) by 2 do
	 
	 (dolist (,y (list n (- (half ,screen-height) n)))
	   (loop for ,x from n to (- (half ,screen-width) n) do
	     (draw-xy ,x ,y)))
	 (dolist (,x (list n (- ,screen-width n)))
	   (loop for ,y from n to (- ,screen-height n) do
	     (draw-xy ,x ,y)))))))


(defmacro draw-box(mx my mwidth mheight)
  (let ((width (gensym))
	(height (gensym))
	(x (gensym))
	(y (gensym)))	       
    `(loop for ,x from ,mx to (+ ,mx ,mwidth) do
      (loop for ,y from ,my to (+ ,my ,mheight) do
	(draw-xy ,x ,y)))))







;;-----------------------------------------------------------
;;          no macros beyond this point
;; ----------------------------------------------------------


(defvar window nil)

(defun setup()
  (setq window (curses::initscr))
  (curses::clear)
  (curses::raw)
  (curses::noecho)
  (curses::nodelay window t)
  (curses::cbreak)
  (colors)
  )



(defun colors()

  ;; Y , X coords
  ;; (curses::mvprintw 1 1 "testing for colors...")

  ;; (if (curses::has-colors)
  ;;     (curses::mvprintw 2 1 "colors detected...")	
  ;;     (curses::mvprintw 2 1 "no colors detected"))

  (curses::start-color)
  
  (curses::init-pair 1 curses::COLOR-YELLOW curses::COLOR-BLACK)
  (curses::init-pair 2 curses::COLOR-YELLOW curses::COLOR-RED)
  (curses::init-pair 3 curses::COLOR-YELLOW curses::COLOR-GREEN)
  (curses::init-pair 4 curses::COLOR-YELLOW curses::COLOR-YELLOW)
  (curses::init-pair 5 curses::COLOR-YELLOW curses::COLOR-BLUE)
  (curses::init-pair 6 curses::COLOR-YELLOW curses::COLOR-MAGENTA)
  (curses::init-pair 7 curses::COLOR-YELLOW curses::COLOR-CYAN)
  (curses::init-pair 8 curses::COLOR-BLACK curses::COLOR-WHITE)

  );; colors



(defun test()

  (loop for dx from 4 to 8 do
    (loop for dy from 4 to 8 do 
  
  (with-black
      (draw-box 10 10 dx dy ))
  (with-red
      (draw-box (+ 10 (* dx 1)) 10 dx dy))
  (with-green
      (draw-box (+ 10 (* dx 2)) 10 dx dy))

  (with-yellow
      (draw-box (+ 10 (* dx 3)) 10 dx dy))

  (with-blue
      (draw-box (+ 10 (* dx 4)) 10 dx dy))

  (with-magenta
      (draw-box (+ 10 (* dx 5)) 10 dx dy))

  (with-cyan
      (draw-box (+ 10 (* dx 6)) 10 dx dy))

  (with-white
      (draw-box (+ 10 (* dx 7)) 10 dx dy))

  (curses::refresh)
  (curses::mvprintw 0 0 "press n key to proceed")  
  (wait-till-press-key-n window)

	  )))





(defun test3()
  (with-cyan
      (decreasing-border-screen))
  (curses::refresh)
  (curses::printw "press n key to proceed")  
  (wait-till-press-key-n window)
  )




(defun test2()
  
  ;; blue screen
  (with-black
      (clear-screen))
  (curses::refresh)
  (curses::printw "press n key to proceed")  
  (wait-till-press-key-n window)

  (with-white
      (clear-screen))
  (curses::refresh)
  (curses::printw "press n key to proceed")  
  (wait-till-press-key-n window)
  
  (with-blue
      (clear-screen))
  (curses::refresh)
  (curses::printw "press n key to proceed")  
  (wait-till-press-key-n window)

  (with-red
      (border-around-screen))
  (curses::refresh)
  (curses::printw "press n key to proceed")  
  (wait-till-press-key-n window)

  (with-cyan
      (decreasing-border-screen)) 
  (curses::refresh)
  (curses::printw "press n key to proceed")  
  (wait-till-press-key-n window)

  
  (curses::printw "press n key to proceed")  
  (wait-till-press-key-n window)

  )



(defun examples()
  
  
  (curses::color-set 1)
      
  (curses::attron (curses::color-pair 1))
  (curses::mvprintw 3 1 "yellow on blue")

  (curses::attron curses::A-STANDOUT)
  (curses::printw "now in standout yellow on blue")  
  (curses::attroff curses::a-standout)
  (curses::printw "now back to normal.")  

  (curses::attroff (curses::color-pair 1))


  (curses::attron curses::A-blink)
  (curses::printw "now blinking . no color pair ")  

  (curses::attron curses::A-reverse)
  
  (curses::printw "now reversed . no color pair ")  
  
  (curses::attroff curses::a-blink)
  (curses::printw "now reversed but no blink. ")  
  (curses::attron curses::A-reverse)

  (curses::attroff curses::a-reverse)
  (curses::printw "now normal plain text.")  

  (loop for color from 1 to 8 do
	(curses::attron (curses::color-pair color))
	(loop for n from 1 to 500 do
	      (curses::printw " "))	
	(curses::attroff (curses::color-pair color)))

  (loop for color from 1 to 8 do
	(curses::attron (curses::color-pair color))
	(loop for n from 1 to 500 do
	      (curses::printw "X"))	
	(curses::attroff (curses::color-pair color)))
  
  (curses::printw (format nil "the window has dimensions ~a by ~a "
			  (curses::getmaxx window) (curses::getmaxy window)))

  (curses::refresh)
  (curses::printw "press n key to proceed")  
  (wait-till-press-key-n window) 
  
  (loop for color from 0 to 8 do
    ;; put color on
    (if (= color 0) 
	(curses::attron (curses::color-pair 1))
	(curses::attron (curses::color-pair color)))
	
  (let ((x 0)
	(y 0)
	(max-x (curses::getmaxx window))
	(max-y (curses::getmaxy window)))
    (loop for x from 0 to max-x do
	  (loop for y from 0 to max-y do
	    (curses::printw "#"))))

  (curses::refresh)
  
  ;; go back to top
  ;;(curses::mvprintw 0 0 " ")
  (curses::mvprintw 0 0 "press n key to proceed : ")
  
  (curses::printw
   (format nil "the screen colour should be ~a :"
	   (nth color '(none black red green yellow blue magenta cyan white))))

  ;; update screen
  (curses::refresh)  
  ;; wait for key press
  ;;(curses::wgetch window)
  ;; disabled wait on getch so it will just pass through
  (wait-till-press-key-n window) 
  ;; take that color off 
  (curses::attroff (curses::color-pair color)))
  )



(defun wait-till-press-key-n(window)
  (prog ((ch nil))
    again
    (setq ch (curses::wgetch window))
    (when (= ch (char-code #\n))
      (go done))     
    (go again)
   done))




(defun game-loop()
  (curses::mvprintw 0 0 "press q key to proceed : ")
  (curses::refresh)
  (prog ((ch nil))
    again
    (setq ch (curses::wgetch window))
    (when (= ch (char-code #\q))
      (go done))     
    (go again)
   done))

(defun clear()
  (curses::clrtoeol)
  (curses::endwin))


;;--------------------------------------------------------------------------


(defun game-loop2()
  (with-black
      (clear-screen))
  (curses::refresh)
  ;;(curses::printw "press n key to proceed")  
  ;;(wait-till-press-key-n window)
  (new-game))

(defparameter board '())
(defparameter piece 0)
(defparameter pos-x 5)
(defparameter pos-y 20)
(defparameter tick 0)
(defparameter tock 0)
(defparameter invalid nil)
(defparameter half-second (floor (/ cl::internal-time-units-per-second 2)))
(defparameter one-second (floor cl::internal-time-units-per-second))
(defparameter paused nil)
(defparameter down-count 0)

  

;; flip ncurses axes upside down
(defun offset-draw(x y)
  (let ((middle-x 30)
	(middle-y 30))
    (draw-xy (+ middle-x (* x 2)) (- middle-y y))
    (draw-xy (+ 1 middle-x (* x 2)) (- middle-y y))))


(defun transform(xs key val)
  (cond
    ((null xs) xs)
    ((eq (car (car xs)) key)
     (cons (list key val) (cdr xs)))
    (t (cons (car xs)
	     (transform (cdr xs) key val)))))




(defun move-piece-to(x y piece)
  (let ((points (car (cdr (assoc 'points piece)))))
    (transform piece 'points
	       (mapcar #'(lambda (pos)
			   (destructuring-bind (x2 y2) pos
			     (list (+ x x2) (+ y y2))))
		       points))))


(defun move-piece-left(piece)
  (let ((points (car (cdr (assoc 'points piece)))))
    (transform piece 'points  
	       (mapcar #'(lambda (pos)
			   (destructuring-bind (x2 y2) pos
			     (list (- x2 1) y2)))
		       points))))

(defun move-piece-right(piece)
  (let ((points (car (cdr (assoc 'points piece)))))
    (transform piece 'points    
	       (mapcar #'(lambda (pos)
			   (destructuring-bind (x2 y2) pos
			     (list (+ x2 1) y2)))
		       points))))


(defun move-piece-down(piece)
  (let ((points (car (cdr (assoc 'points piece)))))
    (transform piece 'points    
	       (mapcar #'(lambda (pos)
			   (destructuring-bind (x2 y2) pos
			     (list x2 (- y2 1))))
		       points))))




(defun draw-piece(obj)
  (let ((points (car (cdr (assoc 'points obj)))))
    (dolist (point points)
    (destructuring-bind (x y) point
      (offset-draw x y)))))


(defun make-piece-0()  `( (color blue) (id 0) (points  (0 0)    (0 1)    (1 1)    (1 0)  )))



(defun draw-piece-0(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 1) (+ y 0))
  )

(defun make-piece-1()  `( (color blue) (id 1) (points  (0 2)    (0 1)    (1 1)    (1 0)  )))


(defun draw-piece-1(x y)
  (offset-draw (+ x 0) (+ y 2))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 1) (+ y 0)))


(defun make-piece-2()  `( (color blue) (id 2) (points  (2 1)    (1 1)    (1 0)    (0 0)  )))

(defun draw-piece-2(x y)
  (offset-draw (+ x 2) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 0) (+ y 0)))


(defun make-piece-3()  `( (color blue) (id 3) (points  (1 2)    (0 1)    (1 1)    (0 0)  )))

(defun draw-piece-3(x y)
  (offset-draw (+ x 1) (+ y 2))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 0) (+ y 0)))


(defun make-piece-4()  `( (color blue) (id 4) (points  (0 1)    (1 1)    (1 0)    (2 0)  )))

(defun draw-piece-4(x y)
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 2) (+ y 0))
  )

(defun make-piece-5()  `( (color blue) (id 5) (points  (1 1)    (0 0)    (1 0)    (2 0)  )))

(defun draw-piece-5(x y)
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 2) (+ y 0))
  )

(defun make-piece-6()  `( (color blue) (id 6) (points  (1 1)    (0 0)    (0 1)    (0 2)  )))

(defun draw-piece-6(x y)
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 0) (+ y 2))
  )


(defun make-piece-7()  `( (color blue) (id 7) (points  (0 1)    (1 1)    (2 1)    (1 0)  )))

(defun draw-piece-7(x y)
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 2) (+ y 1))
  (offset-draw (+ x 1) (+ y 0))
  )


(defun make-piece-8()  `( (color blue) (id 8) (points  (1 2)    (0 1)    (1 0)    (1 1)  )))

(defun draw-piece-8(x y)
  (offset-draw (+ x 1) (+ y 2))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 1) (+ y 1))
  )

;; ---------

(defun make-piece-9()  `( (color blue) (id 9) (points  (0 0)    (1 0)    (2 0)    (3 0)  )))

(defun draw-piece-9(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 2) (+ y 0))
  (offset-draw (+ x 3) (+ y 0))
  )

(defun make-piece-10()  `( (color blue) (id 10) (points  (0 0)    (0 1)    (0 2)    (0 3)  )))

(defun draw-piece-10(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 0) (+ y 2))
  (offset-draw (+ x 0) (+ y 3))
  )

;; --------------

(defun make-piece-11()  `( (color blue) (id 11) (points  (0 0)    (1 0)    (1 1)    (1 2)  )))

(defun draw-piece-11(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 1) (+ y 2))
  )


(defun make-piece-12()  `( (color blue) (id 12) (points  (0 1)    (0 0)    (1 0)    (2 0)  )))

(defun draw-piece-12(x y)
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 2) (+ y 0))
  )


(defun make-piece-13()  `( (color blue) (id 13) (points  (0 0)    (0 1)    (0 2)    (1 2)  )))

(defun draw-piece-13(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 0) (+ y 2))
  (offset-draw (+ x 1) (+ y 2))
  )


(defun make-piece-14()  `( (color blue) (id 14) (points  (0 1)    (1 1)    (2 1)    (2 0)  )))

(defun draw-piece-14(x y)
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 2) (+ y 1))
  (offset-draw (+ x 2) (+ y 0))
  )


;;--------------------------

(defun make-piece-15()  `( (color blue) (id 15) (points  (0 0)    (0 1)    (0 2)    (1 0)  )))

(defun draw-piece-15(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 0) (+ y 2))
  (offset-draw (+ x 1) (+ y 0))
  )



(defun make-piece-16()  `( (color blue) (id 16) (points  (0 0)    (0 1)    (1 1)    (2 1)  )))

(defun draw-piece-16(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 2) (+ y 1))
  )


(defun make-piece-17()  `( (color blue) (id 17) (points  (0 2)    (1 2)    (1 1)    (1 0)  )))

(defun draw-piece-17(x y)
  (offset-draw (+ x 0) (+ y 2))
  (offset-draw (+ x 1) (+ y 2))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 1) (+ y 0))
  )


(defun make-piece-18()  `( (color blue) (id 18) (points  (0 0)    (1 0)    (2 0)    (2 1)  )))

(defun draw-piece-18(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 2) (+ y 0))
  (offset-draw (+ x 2) (+ y 1))
  )


;; board is a collection of pieces
;; what happens when line is removed ? is that piece 'broken'?
;;
;;
;;
;; single colour board
;; is object even on the board ?
;; may be dropped in from above 
(defun consistent-p(obj board)
  (catch 'nop
    (let ((points (car (cdr (assoc 'points obj)))))      
      (dolist (obj2 board)
	(let ((points2 (car (cdr assoc 'points obj2))))
	  (dolist (point points)
	    (destructuring-bind (x y) point
	      (when (< x 1) (throw 'nop nil))
	      (when (> x 10)(throw 'nop nil))
	      (when (< y 1) (throw 'nop nil))
	      (when (> y 23) (throw 'nop nil))
	      (when (member point points :test #'equalp) (throw 'nop nil)))))))
    t))




   

(defun elapsed(tick tock)
  (- tock tick))

(defun invalidate()
  (setq invalid t))


(defun new-piece ()
  (move-piece-to 5 20 (funcall (nth (random 19) (list
						 #'make-piece-0
						 #'make-piece-1
						 #'make-piece-2
						 #'make-piece-3
						 #'make-piece-4
						 #'make-piece-5
						 #'make-piece-6
						 #'make-piece-7
						 #'make-piece-8
						 #'make-piece-9
						 #'make-piece-10
						 #'make-piece-11
						 #'make-piece-12
						 #'make-piece-13
						 #'make-piece-14
						 #'make-piece-15
						 #'make-piece-16
						 #'make-piece-17
						 #'make-piece-18)))))

					

;; down-count is how long to wait when a piece is stuck before recognising as such and generating new piece
;; single box moving along with tick of clock
;; piece is 0
(defun new-game()
  (setq board '())
  (setq obj (new-piece))
  
  (setq tick (get-internal-real-time))
  (setq tock 0)
  (setq invalid t)
  (setq piece 1)
  
  (prog ((ch nil))
     top

     ;; ------- redraw if board is invalid ----
     (when invalid
       ;; set invalid flag nil - it will not redraw or call curses::refresh when we
       ;; go over this code again
       (setq invalid nil)

       
       (with-black
	   (loop for y from 0 to 60  do
	     (curses::mvprintw y 20 "                                                                                                                                   ")))
       
       (with-white
	   (loop for y from 1 to 20 do
	     (loop for x from 1 to 10 do
	       (offset-draw x y))))

       (with-red
	   (dolist (coord board)
	     (destructuring-bind (x y) coord
	       (offset-draw x y))))

       (draw-piece obj)
       
       ;; (cond
       ;; 	 ((= piece 0) (with-blue  (draw-piece obj)))
       ;; 	 ((= piece 1) (with-blue  (draw-piece obj)))
       ;; 	 ((= piece 2) (with-blue  (draw-piece-2 pos-x pos-y)))
       ;; 	 ((= piece 3) (with-blue  (draw-piece-3 pos-x pos-y)))
       ;; 	 ((= piece 4) (with-blue  (draw-piece-4 pos-x pos-y)))
       ;; 	 ((= piece 5) (with-blue  (draw-piece-5 pos-x pos-y)))
       ;; 	 ((= piece 6) (with-blue  (draw-piece-6 pos-x pos-y)))
       ;; 	 ((= piece 7) (with-blue  (draw-piece-7 pos-x pos-y)))
       ;; 	 ((= piece 8) (with-blue  (draw-piece-8 pos-x pos-y)))
       ;; 	 ((= piece 9) (with-blue  (draw-piece-9 pos-x pos-y)))
       ;; 	 ((= piece 10) (with-blue  (draw-piece-10 pos-x pos-y)))
       ;; 	 ((= piece 11) (with-blue  (draw-piece-11 pos-x pos-y)))
       ;; 	 ((= piece 12) (with-blue  (draw-piece-12 pos-x pos-y)))
       ;; 	 ((= piece 13) (with-blue  (draw-piece-13 pos-x pos-y)))
       ;; 	 ((= piece 14) (with-blue  (draw-piece-14 pos-x pos-y)))
       ;; 	 ((= piece 15) (with-blue  (draw-piece-15 pos-x pos-y)))
       ;; 	 ((= piece 16) (with-blue  (draw-piece-16 pos-x pos-y)))
       ;; 	 ((= piece 17) (with-blue  (draw-piece-17 pos-x pos-y)))
       ;; 	 ((= piece 18) (with-blue  (draw-piece-18 pos-x pos-y)))
       ;; 	 (t nil))


       (with-blue  (draw-piece-0 30 pos-y))
       (with-blue  (draw-piece-1 35 pos-y))
       (with-blue  (draw-piece-2 40 pos-y))
       (with-blue  (draw-piece-3 45 pos-y))
       (with-blue  (draw-piece-4 50 pos-y))
       (with-blue  (draw-piece-5 30 (- pos-y 5)))
       (with-blue  (draw-piece-6 35 (- pos-y 5)))
       (with-blue  (draw-piece-7 40 (- pos-y 5)))
       (with-blue  (draw-piece-8 45 (- pos-y 5)))
	 
       (with-blue  (draw-piece-9 30 (- pos-y 10)))
       (with-blue  (draw-piece-10 35 (- pos-y 10)))

       (with-blue  (draw-piece-11 30 (- pos-y 15)))
       (with-blue  (draw-piece-12 35 (- pos-y 15)))
       (with-blue  (draw-piece-13 40 (- pos-y 15)))
       (with-blue  (draw-piece-14 45 (- pos-y 15)))
       
       (with-blue  (draw-piece-15 30 (- pos-y 20)))
       (with-blue  (draw-piece-16 35 (- pos-y 20)))
       (with-blue  (draw-piece-17 40 (- pos-y 20)))
       (with-blue  (draw-piece-18 45 (- pos-y 20)))
       
       
       (curses::refresh)
       (curses::mvprintw 5 0 (format nil "piece is ~a ~%" piece))
      );;when invalid
       

     
     (setq ch (curses::wgetch window))
     (when (= ch (char-code #\q))
       (go quit))
     
     (when (= ch (char-code #\a)) ;; left

       (when (consistent-p (move-piece-left obj) board)
	 (setq obj (move-piece-left obj)))
       
       (setq pos-x (- pos-x 1))
       (invalidate)

       )

     ;; turn piece anti-clockwise .....
     (when (= ch (char-code #\w))
       (cond
	 ((= piece 1) (setq piece 2))
	 ((= piece 2) (setq piece 1))
	 
	 ((= piece 3) (setq piece 4))
	 ((= piece 4) (setq piece 3))

	 ((= piece 5) (setq piece 8))
	 ((= piece 6) (setq piece 5))
	 ((= piece 7) (setq piece 6))
	 ((= piece 8) (setq piece 7))

	 ((= piece 9) (setq piece 10))
	 ((= piece 10) (setq piece 9))
	 
	 ((= piece 11) (setq piece 14))
	 ((= piece 12) (setq piece 11))
	 ((= piece 13) (setq piece 12))
	 ((= piece 14) (setq piece 13))

	 ((= piece 15) (setq piece 18))
	 ((= piece 16) (setq piece 15))
	 ((= piece 17) (setq piece 16))
	 ((= piece 18) (setq piece 17))
	 
	 
	 (t nil))
       (invalidate)

       )

     
     ;; turn piece clockwise .......
     (when (= ch (char-code #\e))
       (cond
	 ((= piece 1) (setq piece 2))
	 ((= piece 2) (setq piece 1))
	 ((= piece 3) (setq piece 4))
	 ((= piece 4) (setq piece 3))
	 
	 ((= piece 5) (setq piece 6))
	 ((= piece 6) (setq piece 7))
	 ((= piece 7) (setq piece 8))
	 ((= piece 8) (setq piece 5))

	 ((= piece 9) (setq piece 10))
	 ((= piece 10) (setq piece 9))

	 ((= piece 11) (setq piece 12))
	 ((= piece 12) (setq piece 13))
	 ((= piece 13) (setq piece 14))
	 ((= piece 14) (setq piece 11))

	 ((= piece 15) (setq piece 16))
	 ((= piece 16) (setq piece 17))
	 ((= piece 17) (setq piece 18))
	 ((= piece 18) (setq piece 15))
	 
	 
	 (t nil))
       (invalidate)

       )


     
     (when (= ch (char-code #\s))  ;; down

       
       (when (consistent-p (move-piece-down obj) board)
	 (setq down-count 2)
	 (setq obj (move-piece-down obj)))
       
       (setq pos-y (- pos-y 1))
       (invalidate)
       
       )

     (when (= ch (char-code #\d))  ;; right
       
       (when (consistent-p (move-piece-right obj) board)
	 (setq obj (move-piece-right obj)))

       (setq pos-x (+ pos-x 1))
       (invalidate)
       )

     
     (when (= ch (char-code #\n))  ;; next piece -- if integerp 
       (if (integerp piece)
	   (setq piece (+ piece 1))
	   (setq piece 1))
       (if (> piece 18) (setq piece 0) nil)
       (invalidate))

     (when (= ch 32) ;; pause game
       (if paused
	   (setq tick (cl::get-internal-real-time)))
       (setq paused (not paused))
       (invalidate))

     
     ;; elapsed time exceeded 
     (setq tock (cl::get-internal-real-time))
     (when (and (not paused)
		(> (elapsed tick tock) one-second))
		
       ;;drop it down one level
       
       (when (consistent-p (move-piece-down obj) board)
	 (setq down-count 2)
	 (setq obj (move-piece-down obj)))

       (if (not (consistent-p (move-piece-down obj) board))
	   (decf down-count))

       (when (zerop down-count)
	 ;; fix piece here -- and next piece
	 (setq board (cons obj board))
	 ;; next piece
	 (setq obj (new-piece))

	 
	 )
	   
       
       (setq pos-y (- pos-y 1))
       

       (invalidate)

       ;; reset clock
       (setq tick (cl::get-internal-real-time))
       
       (curses::mvprintw 21 0 (format nil "realtime clock is ~a     ~%" tock))
       )
     
     
     (when (= ch (char-code #\r))
       (setq pos-y 20) ;; reset height of object
       (invalidate))
       
   (go top)
   quit
     ))


  






  












