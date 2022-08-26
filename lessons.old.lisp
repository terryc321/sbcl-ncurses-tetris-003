
;; broken code from test.lisp


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




