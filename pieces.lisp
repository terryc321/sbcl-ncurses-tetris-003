
;;(ql:quickload :uiop)

(uiop:define-package :test
    (:use :cl))

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

;; (defun draw-xy(x y)
;;   (format t "draw at (~a , ~a) " x y))

;; (defun with-blue(x)
;;   x)

;; flip ncurses axes upside down
(defun offset-draw(x y)
  (let ((middle-x 30)
	(middle-y 30))
    (test::draw-xy (+ middle-x (* x 2)) (- middle-y y))
    (test::draw-xy (+ 1 middle-x (* x 2)) (- middle-y y))))



(defun transform(xs key val)
  (cond
    ((null xs) xs)
    ((eq (car (car xs)) key)
     (cons (list key val) (cdr xs)))
    (t (cons (car xs)
	     (transform (cdr xs) key val)))))





(defun move-piece-to(x y piece)
  ;;(format t "piece = ~a : assoc points piece = ~a ~%" piece (assoc 'points piece))
  (let ((points (car (cdr (assoc 'points piece)))))
    ;; (format t "points = ~a ~%" points)
    ;; (format t "len.points = ~A ~%" (length points))
    (transform 
    (transform piece 'points
	       (mapcar #'(lambda (pos)
			   (destructuring-bind (x2 y2) pos
			     (list (+ x x2) (+ y y2))))
		       points))
    'xy (list x y))))




(defun move-piece-left(piece)
  (let ((xy (car (cdr (assoc 'xy piece)))))
    (destructuring-bind (x y) xy
      (let ((points (car (cdr (assoc 'points piece)))))
	(transform 
	 (transform piece 'points  
		    (mapcar #'(lambda (pos)
				(destructuring-bind (x2 y2) pos
				  (list (- x2 1) y2)))
			    points))
	 'xy (list (- x 1) y))))))




(defun move-piece-right(piece)
  (let ((xy (car (cdr (assoc 'xy piece)))))
    (destructuring-bind (x y) xy
      (let ((points (car (cdr (assoc 'points piece)))))
	(transform 
	 (transform piece 'points    
		    (mapcar #'(lambda (pos)
				(destructuring-bind (x2 y2) pos
				  (list (+ x2 1) y2)))
			    points))
	 'xy (list (+ x 1) y))))))




(defun move-piece-down(piece)
  (let ((xy (car (cdr (assoc 'xy piece)))))
    (destructuring-bind (x y) xy
      (let ((points (car (cdr (assoc 'points piece)))))
	(transform 	
	 (transform piece 'points    
		    (mapcar #'(lambda (pos)
				(destructuring-bind (x2 y2) pos
				  (list x2 (- y2 1))))
			    points))
	 'xy (list x (- y 1)))))))




(defun draw-piece(obj)
  (let ((color (car (cdr (assoc 'color obj)))))    
    (let ((points (car (cdr (assoc 'points obj)))))
      (dolist (point points)
	(destructuring-bind (x y) point
	  (test::offset-with-color color x y))))))




(defun make-piece-0()  `( (color blue) (xy 0 0) (id 0) (points  ((0 0)    (0 1)    (1 1)    (1 0)  ))))



(defun draw-piece-0(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 1) (+ y 0))
  )

(defun make-piece-1()  `( (color blue) (xy 0 0) (id 1) (points  ((0 2)    (0 1)    (1 1)    (1 0)  ))))


(defun draw-piece-1(x y)
  (offset-draw (+ x 0) (+ y 2))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 1) (+ y 0)))


(defun make-piece-2()  `( (color blue) (xy 0 0) (id 2) (points ( (2 1)    (1 1)    (1 0)    (0 0)  ))))

(defun draw-piece-2(x y)
  (offset-draw (+ x 2) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 0) (+ y 0)))


(defun make-piece-3()  `( (color blue) (xy 0 0) (id 3) (points ( (1 2)    (0 1)    (1 1)    (0 0)  ))))

(defun draw-piece-3(x y)
  (offset-draw (+ x 1) (+ y 2))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 0) (+ y 0)))


(defun make-piece-4()  `( (color blue) (xy 0 0) (id 4) (points(  (0 1)    (1 1)    (1 0)    (2 0)  ))))

(defun draw-piece-4(x y)
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 2) (+ y 0))
  )

(defun make-piece-5()  `( (color blue) (xy 0 0) (id 5) (points  ((1 1)    (0 0)    (1 0)    (2 0)  ))))

(defun draw-piece-5(x y)
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 2) (+ y 0))
  )

(defun make-piece-6()  `( (color blue) (xy 0 0) (id 6) (points  ((1 1)    (0 0)    (0 1)    (0 2)  ))))

(defun draw-piece-6(x y)
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 0) (+ y 2))
  )


(defun make-piece-7()  `( (color blue) (xy 0 0) (id 7) (points ( (0 1)    (1 1)    (2 1)    (1 0)  ))))

(defun draw-piece-7(x y)
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 2) (+ y 1))
  (offset-draw (+ x 1) (+ y 0))
  )


(defun make-piece-8()  `( (color blue) (xy 0 0) (id 8) (points  ((1 2)    (0 1)    (1 0)    (1 1)  ))))

(defun draw-piece-8(x y)
  (offset-draw (+ x 1) (+ y 2))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 1) (+ y 1))
  )

;; ---------

(defun make-piece-9()  `( (color blue) (xy 0 0) (id 9) (points ( (0 0)    (1 0)    (2 0)    (3 0)  ))))

(defun draw-piece-9(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 2) (+ y 0))
  (offset-draw (+ x 3) (+ y 0))
  )

(defun make-piece-10()  `( (color blue) (xy 0 0) (id 10) (points  ((0 0)    (0 1)    (0 2)    (0 3)  ))))

(defun draw-piece-10(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 0) (+ y 2))
  (offset-draw (+ x 0) (+ y 3))
  )

;; --------------

(defun make-piece-11()  `( (color blue) (xy 0 0) (id 11) (points  ((0 0)    (1 0)    (1 1)    (1 2)  ))))

(defun draw-piece-11(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 1) (+ y 2))
  )


(defun make-piece-12()  `( (color blue) (xy 0 0) (id 12) (points  ((0 1)    (0 0)    (1 0)    (2 0)  ))))

(defun draw-piece-12(x y)
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 1) (+ y 0))
  (offset-draw (+ x 2) (+ y 0))
  )


(defun make-piece-13()  `( (color blue) (xy 0 0) (id 13) (points ( (0 0)    (0 1)    (0 2)    (1 2)  ))))

(defun draw-piece-13(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 0) (+ y 2))
  (offset-draw (+ x 1) (+ y 2))
  )


(defun make-piece-14()  `( (color blue) (xy 0 0) (id 14) (points ( (0 1)    (1 1)    (2 1)    (2 0)  ))))

(defun draw-piece-14(x y)
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 2) (+ y 1))
  (offset-draw (+ x 2) (+ y 0))
  )


;;--------------------------

(defun make-piece-15()  `( (color blue) (xy 0 0) (id 15) (points ( (0 0)    (0 1)    (0 2)    (1 0)  ))))

(defun draw-piece-15(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 0) (+ y 2))
  (offset-draw (+ x 1) (+ y 0))
  )



(defun make-piece-16()  `( (color blue) (xy 0 0) (id 16) (points  ((0 0)    (0 1)    (1 1)    (2 1)  ))))

(defun draw-piece-16(x y)
  (offset-draw (+ x 0) (+ y 0))
  (offset-draw (+ x 0) (+ y 1))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 2) (+ y 1))
  )


(defun make-piece-17()  `( (color blue) (xy 0 0) (id 17) (points ( (0 2)    (1 2)    (1 1)    (1 0)  ))))

(defun draw-piece-17(x y)
  (offset-draw (+ x 0) (+ y 2))
  (offset-draw (+ x 1) (+ y 2))
  (offset-draw (+ x 1) (+ y 1))
  (offset-draw (+ x 1) (+ y 0))
  )


(defun make-piece-18()  `( (color blue) (xy 0 0) (id 18) (points ( (0 0)    (1 0)    (2 0)    (2 1)  ))))

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
    ;; all points on board , more or less
    (let ((points (car (cdr (assoc 'points obj)))))
      (dolist (point points)
	(destructuring-bind (x y) point
	  (when (< x 1) (throw 'nop nil))
	  (when (> x 10)(throw 'nop nil))
	  (when (< y 1) (throw 'nop nil))
	  (when (> y 23) (throw 'nop nil))
	  ;; any collision with 
	  (dolist (obj2 board)	
	    (let ((points2 (car (cdr (cl:assoc 'points obj2)))))
	      (dolist (point2 points2)
		(destructuring-bind (x2 y2) point2
		  (when (and (= x x2)(= y y2))
		    (throw 'nop nil)))))))))
      
    t))


   

(defun elapsed(tick tock)
  (- tock tick))

(defun invalidate()
  (setq invalid t))


(defun pick(xs)
  (let ((k (random (length xs))))
    (nth k xs)))

	     

(defun new-piece ()
  (let ((color (pick '(blue red magenta black green yellow cyan))))
    (transform 
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
						    #'make-piece-18))))
     'color
     color)))


					
