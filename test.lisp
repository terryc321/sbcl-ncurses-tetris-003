
(defpackage :pieces
    (:use :cl :cl-user))


;;(ql:quickload :uiop)
(defpackage :test
    (:use :cl))

(in-package :test)


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




(defun elapsed(tick tock)
  (- tock tick))

(defun invalidate()
  (setq invalid t))


(defun offset-with-color(color x y)
  (cond
    ((eq color 'pieces::red)
     (with-red (offset-draw x y)))
    ((eq color 'pieces::blue)
     (with-blue (offset-draw x y)))
    ((eq color 'pieces::green)
     (with-green (offset-draw x y)))
    (t
     (offset-draw x y))))





(defun find-offset(obj)
  (let ((id (car (cdr (assoc 'pieces::id obj)))))
    
    t))

(defun rotate-anticlockwise(obj)
  (let ((id (car (cdr (assoc 'pieces::id obj))))
	(xy (car (cdr (assoc 'pieces::xy obj))))
	(color (car (cdr (assoc 'pieces::color obj)))))
    (destructuring-bind (x y) xy
      (curses::mvprintw 1 0 (format nil "xy = ~A ~%" xy))
      (curses::mvprintw 2 0 (format nil "id = ~A ~%" id))
      (curses::mvprintw 3 0 (format nil "color = ~A ~%" color))
      (curses::mvprintw 4 0 (format nil "id int? = ~A ~%" (integerp id)))

      (pieces::transform 
       (pieces::move-piece-to x y (funcall (nth id (list
					    #'pieces::make-piece-0
					    #'pieces::make-piece-2
					    #'pieces::make-piece-1
					    
					    #'pieces::make-piece-4
					    #'pieces::make-piece-3
					    
					    #'pieces::make-piece-8
					    #'pieces::make-piece-5
					    #'pieces::make-piece-6
					    #'pieces::make-piece-7
					    
					    #'pieces::make-piece-10
					    #'pieces::make-piece-9
					    
					    #'pieces::make-piece-14
					    #'pieces::make-piece-11
					    #'pieces::make-piece-12
					    #'pieces::make-piece-13
					    
					    #'pieces::make-piece-18
					    #'pieces::make-piece-15
					    #'pieces::make-piece-16
					    #'pieces::make-piece-17))))
       'pieces::color
       color))))


(defun rotate-clockwise(obj)
  (let ((id (car (cdr (assoc 'pieces::id obj))))
	(xy (car (cdr (assoc 'pieces::xy obj))))
	(color (car (cdr (assoc 'pieces::color obj)))))
    (destructuring-bind (x y) xy
      (curses::mvprintw 1 0 (format nil "xy = ~A ~%" xy))
      (curses::mvprintw 2 0 (format nil "id = ~A ~%" id))
      (curses::mvprintw 3 0 (format nil "color = ~A ~%" color))
      (curses::mvprintw 4 0 (format nil "id int? = ~A ~%" (integerp id)))

      (pieces::transform 
       (pieces::move-piece-to x y (funcall (nth id (list
					    #'pieces::make-piece-0
					    #'pieces::make-piece-2
					    #'pieces::make-piece-1
					    
					    #'pieces::make-piece-4
					    #'pieces::make-piece-3
					    
					    #'pieces::make-piece-6
					    #'pieces::make-piece-7
					    #'pieces::make-piece-8
					    #'pieces::make-piece-5
					    
					    #'pieces::make-piece-10
					    #'pieces::make-piece-9
					    
					    #'pieces::make-piece-12
					    #'pieces::make-piece-13
					    #'pieces::make-piece-14
					    #'pieces::make-piece-11
					    
					    #'pieces::make-piece-16
					    #'pieces::make-piece-17
					    #'pieces::make-piece-18
					    #'pieces::make-piece-15))))
       'pieces::color
       color))))


(defun points-without-row(row points)
  (cond
    ((null points) nil)
    (t (let ((point (car points)))
	 (destructuring-bind (x y) point
	   (if (= row y)
	       (points-without-row row (cdr points))
	       (cons point (points-without-row row (cdr points)))))))))


(defun points-above-row-descend(row points)
  (cond
    ((null points) nil)
    (t (let ((point (car points)))
	 (destructuring-bind (x y) point
	   (if (> y row)
	       (cons (list x (- y 1)) (points-above-row-descend row (cdr points)))
	       (cons point (points-above-row-descend row (cdr points)))))))))


;; board is a list of pieces
;; func acts on pieces
(defun remove-full-row(row piece)
  (let ((points (car (cdr (assoc 'pieces::points piece)))))
    (pieces::transform piece 'pieces::points 
		       (points-above-row-descend row (points-without-row row points)))))





(defun full-row-remove(board)
  (catch 'found-row
    (let ((all-points (apply #'append (mapcar (lambda (x) (car (cdr (assoc 'pieces::points x)))) board)))
	  (point-count (make-array 30)))
      (dolist (point all-points)
	(destructuring-bind (x y) point
	  (incf (aref point-count y))))
      (loop for y from 1 to 20 do
	(when (= (aref point-count y) 10)
	  ;;(throw 'found-row (full-row-p (remove-board-row y board)))
	  ;;(throw 'found-row (mapcar (lambda (piece) (remove-full-row y piece)) board))
	  ;;(full-row-remove ))))
	  (throw 'found-row (full-row-remove (mapcar (lambda (piece) (remove-full-row y piece)) board))))))
    board))



      




(defun full-row-p(board)
  (catch 'found-row
    (let ((all-points (apply #'append (mapcar (lambda (x) (car (cdr (assoc 'pieces::points x)))) board)))
	  (point-count (make-array 30 :initial-element 0)))
      (dolist (point all-points)
	(destructuring-bind (x y) point
	  (incf (aref point-count y))))
      (loop for y from 1 to 20 do
	(when (= (aref point-count y) 10)
	  (throw 'found-row t))))
    nil))






;; down-count is how long to wait when a piece is stuck before recognising as such and generating new piece
;; single box moving along with tick of clock
;; piece is 0
(defun new-game()
  (setq board '())
  (setq obj (pieces::new-piece))
  
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
	     (curses::mvprintw y 20 "                                                                                                                                                                    ")))
       
       (with-white
	   (loop for y from 1 to 20 do
	     (loop for x from 1 to 10 do
	       (offset-draw x y))))
       
       ;; draw pieces we know about
       (dolist (piece board)
	 ;;(curses::mvprintw 1 0 (format nil "sanity.piece = ~A ~%" piece))
	 ;;(curses::mvprintw 2 0 (format nil "sanity.ppoints = ~A ~%" (assoc 'pieces::points piece)))
	 (let ((color (car (cdr (assoc 'pieces::color piece)))))
	   ;;(curses::mvprintw 2 0 (format nil "sanity.color = ~A ~%" color))
	 
	   (let ((points (car (cdr (assoc 'pieces::points piece)))))
	     ;;(curses::mvprintw 0 0 (format nil "sanity.points = ~A ~%" points))
	     (dolist (point points)
	       (destructuring-bind (x y) point
		 (offset-with-color color x y))))))
       

       ;;(curses::attron curses::A-STANDOUT)
       (pieces::draw-piece obj)
       ;;(curses::attroff curses::a-standout)
       
       
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


       (with-blue  (pieces::draw-piece-0 (+ pos-x 30) pos-y))
       (with-blue  (pieces::draw-piece-1 (+ pos-x 35) pos-y))
       (with-blue  (pieces::draw-piece-2 (+ pos-x 40) pos-y))
       (with-blue  (pieces::draw-piece-3 (+ pos-x 45) pos-y))
       (with-blue  (pieces::draw-piece-4 (+ pos-x 50) pos-y))
       (with-blue  (pieces::draw-piece-5 (+ pos-x 30) (- pos-y 5)))
       (with-blue  (pieces::draw-piece-6 (+ pos-x 35) (- pos-y 5)))
       (with-blue  (pieces::draw-piece-7 (+ pos-x 40) (- pos-y 5)))
       (with-blue  (pieces::draw-piece-8 (+ pos-x 45) (- pos-y 5)))
	 
       (with-blue  (pieces::draw-piece-9 (+ pos-x 30) (- pos-y 10)))
       (with-blue  (pieces::draw-piece-10 (+ pos-x 35) (- pos-y 10)))

       (with-blue  (pieces::draw-piece-11 (+ pos-x 30) (- pos-y 15)))
       (with-blue  (pieces::draw-piece-12 (+ pos-x 35) (- pos-y 15)))
       (with-blue  (pieces::draw-piece-13 (+ pos-x 40) (- pos-y 15)))
       (with-blue  (pieces::draw-piece-14 (+ pos-x 45) (- pos-y 15)))
       
       (with-blue  (pieces::draw-piece-15 (+ pos-x 30) (- pos-y 20)))
       (with-blue  (pieces::draw-piece-16 (+ pos-x 35) (- pos-y 20)))
       (with-blue  (pieces::draw-piece-17 (+ pos-x 40) (- pos-y 20)))
       (with-blue  (pieces::draw-piece-18 (+ pos-x 45) (- pos-y 20)))
       

       
       (curses::refresh)
       (curses::mvprintw 5 0 (format nil "piece is ~a ~%" piece))
       ;;(curses::mvprintw 6 0 (format nil "board is ~a ~%" board))
       
      );;when invalid
       

     
     (setq ch (curses::wgetch window))
     (when (= ch (char-code #\q))
       (go quit))
     
     (when (= ch (char-code #\a)) ;; left

       (when (pieces::consistent-p (pieces::move-piece-left obj) board)
	 (setq obj (pieces::move-piece-left obj)))
       
       (setq pos-x (- pos-x 1))
       (invalidate)

       )

     ;; turn piece anti-clockwise .....
     (when (= ch (char-code #\w))

       (let ((rot (rotate-anticlockwise obj)))
	 (when (pieces::consistent-p rot board)
	   (setq obj rot)
	   (invalidate)))

       )
     

     
     ;; turn piece clockwise .......
     (when (= ch (char-code #\e))
       (let ((rot (rotate-clockwise obj)))
	 (when (pieces::consistent-p rot board)
	   (setq obj rot)
	   (invalidate)))
       )

     
     (when (= ch (char-code #\s))  ;; down

       
       (when (pieces::consistent-p (pieces::move-piece-down obj) board)
	 (setq down-count 2)
	 (setq obj (pieces::move-piece-down obj)))
       
       (setq pos-y (- pos-y 1))
       (invalidate)
       
       )

     (when (= ch (char-code #\d))  ;; right
       
       (when (pieces::consistent-p (pieces::move-piece-right obj) board)
	 (setq obj (pieces::move-piece-right obj)))

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
       
       (when (pieces::consistent-p (pieces::move-piece-down obj) board)
	 (setq down-count 2)
	 (setq obj (pieces::move-piece-down obj)))

       (if (not (pieces::consistent-p (pieces::move-piece-down obj) board))
	   (decf down-count))

       (when (zerop down-count)
	 ;; fix piece here -- and next piece
	 (setq board (cons obj board))
	 ;; --- check for full rows ---

	 (when (full-row-p board))
	 (curses::mvprintw 1 0 (format nil "full row ~%"))
	 (setq board (full-row-remove board))
	   
	 ;; next piece
	 (setq obj (pieces::new-piece))
	 (setq pos-x 5)
	 (setq pos-y 20)

	 
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





  






  












