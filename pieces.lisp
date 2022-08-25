
(declaim (debug 3))
;;(ql:quickload :uiop)

(uiop:define-package :pieces
    (:use :cl :cl-user))


(in-package :pieces)




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

(defun draw-xy(x y)
  (format t "draw at ~a.~a " x y))
(defun with-blue(x)
  x)



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
  (format t "piece = ~a : assoc points piece = ~a ~%" piece (assoc 'points piece))
  (let ((points (cdr (assoc 'points piece))))
    (format t "points = ~a ~%" points)
    (format t "len.points = ~A ~%" (length points))
    (transform piece 'points
	       (mapcar #'(lambda (pos)
			   (destructuring-bind (x2 y2) pos
			     (list (+ x x2) (+ y y2))))
		       points))))




(defun move-piece-left(piece)
  (let ((points (cdr (assoc 'points piece))))
    (transform piece 'points  
	       (mapcar #'(lambda (pos)
			   (destructuring-bind (x2 y2) pos
			     (list (- x2 1) y2)))
		       points))))

(defun move-piece-right(piece)
  (let ((points (cdr (assoc 'points piece))))
    (transform piece 'points    
	       (mapcar #'(lambda (pos)
			   (destructuring-bind (x2 y2) pos
			     (list (+ x2 1) y2)))
		       points))))


(defun move-piece-down(piece)
  (let ((points (cdr (assoc 'points piece))))
    (transform piece 'points    
	       (mapcar #'(lambda (pos)
			   (destructuring-bind (x2 y2) pos
			     (list x2 (- y2 1))))
		       points))))




(defun draw-piece(obj)
  (let ((points (cdr (assoc 'points obj))))
    (dolist (point points)
      (format t "points = ~A ~%" points)
      (format t "point = ~A ~%" point)      
      (destructuring-bind (x y) point
	(offset-draw x y)))))




(defun make-piece-0()  `( (color blue) (id 0) (points  ((0 0)    (0 1)    (1 1)    (1 0)  ))))



(defun draw-piece-0(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 1) (+ y 0))
  )

(defun make-piece-1()  `( (color blue) (id 1) (points  ((0 2)    (0 1)    (1 1)    (1 0)  ))))


(defun draw-piece-1(x y)
  (offset-draw (+ x 0) (+ y 2))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 1) (+ y 0)))


(defun make-piece-2()  `( (color blue) (id 2) (points ( (2 1)    (1 1)    (1 0)    (0 0)  ))))

(defun draw-piece-2(x y)
  (offset-draw (+ x 2) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 0) (+ y 0)))


(defun make-piece-3()  `( (color blue) (id 3) (points ( (1 2)    (0 1)    (1 1)    (0 0)  ))))

(defun draw-piece-3(x y)
  (offset-draw (+ x 1) (+ y 2))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 0) (+ y 0)))


(defun make-piece-4()  `( (color blue) (id 4) (points(  (0 1)    (1 1)    (1 0)    (2 0)  ))))

(defun draw-piece-4(x y)
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 2) (+ y 0))
  )

(defun make-piece-5()  `( (color blue) (id 5) (points  ((1 1)    (0 0)    (1 0)    (2 0)  ))))

(defun draw-piece-5(x y)
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 2) (+ y 0))
  )

(defun make-piece-6()  `( (color blue) (id 6) (points  ((1 1)    (0 0)    (0 1)    (0 2)  ))))

(defun draw-piece-6(x y)
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 0) (+ y 2))
  )


(defun make-piece-7()  `( (color blue) (id 7) (points ( (0 1)    (1 1)    (2 1)    (1 0)  ))))

(defun draw-piece-7(x y)
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 2) (+ y 1))
  (offset-draw (+ x 1) (+ y 0))
  )


(defun make-piece-8()  `( (color blue) (id 8) (points  ((1 2)    (0 1)    (1 0)    (1 1)  ))))

(defun draw-piece-8(x y)
  (offset-draw (+ x 1) (+ y 2))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 1) (+ y 1))
  )

;; ---------

(defun make-piece-9()  `( (color blue) (id 9) (points ( (0 0)    (1 0)    (2 0)    (3 0)  ))))

(defun draw-piece-9(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 2) (+ y 0))
  (offset-draw (+ x 3) (+ y 0))
  )

(defun make-piece-10()  `( (color blue) (id 10) (points  ((0 0)    (0 1)    (0 2)    (0 3)  ))))

(defun draw-piece-10(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 0) (+ y 2))
  (offset-draw (+ x 0) (+ y 3))
  )

;; --------------

(defun make-piece-11()  `( (color blue) (id 11) (points  ((0 0)    (1 0)    (1 1)    (1 2)  ))))

(defun draw-piece-11(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 1) (+ y 2))
  )


(defun make-piece-12()  `( (color blue) (id 12) (points  ((0 1)    (0 0)    (1 0)    (2 0)  ))))

(defun draw-piece-12(x y)
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 2) (+ y 0))
  )


(defun make-piece-13()  `( (color blue) (id 13) (points ( (0 0)    (0 1)    (0 2)    (1 2)  ))))

(defun draw-piece-13(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 0) (+ y 2))
  (offset-draw (+ x 1) (+ y 2))
  )


(defun make-piece-14()  `( (color blue) (id 14) (points ( (0 1)    (1 1)    (2 1)    (2 0)  ))))

(defun draw-piece-14(x y)
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 2) (+ y 1))
  (offset-draw (+ x 2) (+ y 0))
  )


;;--------------------------

(defun make-piece-15()  `( (color blue) (id 15) (points ( (0 0)    (0 1)    (0 2)    (1 0)  ))))

(defun draw-piece-15(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 0) (+ y 2))
  (offset-draw (+ x 1) (+ y 0))
  )



(defun make-piece-16()  `( (color blue) (id 16) (points  ((0 0)    (0 1)    (1 1)    (2 1)  ))))

(defun draw-piece-16(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 2) (+ y 1))
  )


(defun make-piece-17()  `( (color blue) (id 17) (points ( (0 2)    (1 2)    (1 1)    (1 0)  ))))

(defun draw-piece-17(x y)
  (offset-draw (+ x 0) (+ y 2))
  (offset-draw (+ x 1) (+ y 2))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 1) (+ y 0))
  )


(defun make-piece-18()  `( (color blue) (id 18) (points ( (0 0)    (1 0)    (2 0)    (2 1)  ))))

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

       
       (draw-piece obj)

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
       
       
    ;;   (curses::refresh)
       ;; (curses::mvprintw 5 0 (format nil "piece is ~a ~%" piece))
       
      );;when invalid


     

     (format t "~% please enter action q=quit a=left d=right s=down w=turn left e=turn right : ~%")
     (setq ch (read))
     
     (when (eq ch 'q)
       (go quit))
     
     (when (eq ch 'a)  ;; move left

       (when (consistent-p (move-piece-left obj) board)
	 (setq obj (move-piece-left obj)))
       
       (setq pos-x (- pos-x 1))
       (invalidate)

       )

     ;; turn piece anti-clockwise .....
     (when (eq ch 'w)
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
     (when (eq  ch 'e) 
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


     
     (when (eq ch 's)  ;; down

       
       (when (consistent-p (move-piece-down obj) board)
	 (setq down-count 2)
	 (setq obj (move-piece-down obj)))
       
       (setq pos-y (- pos-y 1))
       (invalidate)
       
       )

     (when (eq ch 'd)  ;; right
       
       (when (consistent-p (move-piece-right obj) board)
	 (setq obj (move-piece-right obj)))

       (setq pos-x (+ pos-x 1))
       (invalidate)
       )

     
     ;; (when (= ch (char-code #\n))  ;; next piece -- if integerp 
     ;;   (if (integerp piece)
     ;; 	   (setq piece (+ piece 1))
     ;; 	   (setq piece 1))
     ;;   (if (> piece 18) (setq piece 0) nil)
     ;;   (invalidate))

     ;; (when (= ch 32) ;; pause game
     ;;   (if paused
     ;; 	   (setq tick (cl::get-internal-real-time)))
     ;;   (setq paused (not paused))
     ;;   (invalidate))

     
     ;; ;; elapsed time exceeded 
     ;; (setq tock (cl::get-internal-real-time))
     ;; (when (and (not paused)
     ;; 		(> (elapsed tick tock) one-second))
		
     ;;   ;;drop it down one level
       
     ;;   (when (consistent-p (move-piece-down obj) board)
     ;; 	 (setq down-count 2)
     ;; 	 (setq obj (move-piece-down obj)))

     ;;   (if (not (consistent-p (move-piece-down obj) board))
     ;; 	   (decf down-count))

     ;;   (when (zerop down-count)
     ;; 	 ;; fix piece here -- and next piece
     ;; 	 (setq board (cons obj board))
     ;; 	 ;; next piece
     ;; 	 (setq obj (new-piece))

	 
     ;; 	 )
	   
       
     ;;   (setq pos-y (- pos-y 1))
       

     ;;   (invalidate)

     ;;   ;; reset clock
     ;;   (setq tick (cl::get-internal-real-time))
       
     ;;   (curses::mvprintw 21 0 (format nil "realtime clock is ~a     ~%" tock))
     ;;   )
     
     
     ;; (when (= ch (char-code #\r))
     ;;   (setq pos-y 20) ;; reset height of object
     ;;   (invalidate))
       
   (go top)
   quit
     ))




  






  












