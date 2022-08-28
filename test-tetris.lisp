

(ql:quickload :fiveam)


(defpackage :test-tetris
    (:use :cl :fiveam))

(in-package :test-tetris)

(tetris::show-board (tetris::make-board))

(occupied-p '() 1 2)

(occupied-p '((2 1)) 1 2)

(occupied-p '((1 2 1)) 1 2)

(occupied-p '((1 3)) 1 2)

(occupied-p '(()(1 2 3)) 1 2)

(occupied-p '('asdf 'peter ()(1 2)) 1 2)

(occupied-p '('asdf 'peter ()(1 2)(1 . 2)) 1 2)

(make-board)

(occupy 1 2 (occupy 3 4 (occupy 4 5 (make-board))))

(member (cons 1 2) '('asdf 'peter ()(1 2)(1 . 2)) :test #'equalp)

(member (list 1 2) '('asdf 'peter ()(1 2)(1 . 2)) :test #'equalp)


(show-board (occupy 1 2 (occupy 3 4 (occupy 4 5 (make-board)))))

(show-board (occupy 12 2 (occupy 3 4 (occupy 4 5 (make-board)))))

(show-board (make-board))


;; uniform hash design
;;

;; 
;; ( (key val) (key val) ..)

(transform '((type box)(x 1)(y 2)) 'x 3)

(transform '((type box)(x 1)(y 2)) 'y 3)

(transform '((type box)(x 1)(y 2)) 'type 'flat)

(assoc-val 'x (box 2 3))

(box 2 3)

(get-x (transform '((type box)(x 1)(y 2)) 'x 3))

(get-y (transform '((type box)(x 1)(y 2)) 'y 3))

(get-x (transform '((type box)(x 1)(y 2)) 'type 'flat))

(box-squares (box 0 0))

(box-squares (box 2 0))

(box-squares (box 1 0))

(box-squares (box 1 1))

(member '(1 2) '(box (x 3)(y 4)(xy 3 4)(1 2)))

(member '(1 2) '(box (x 3)(y 4)(xy 3 4)(1 2)) :test #'eq)

(member '(1 2) '(box (x 3)(y 4)(xy 3 4)(1 2)) :test #'eql)

(member '(1 2) '(box (x 3)(y 4)(xy 3 4)(1 2)) :test #'equal)

(member '(1 2) '(box (x 3)(y 4)(xy 3 4)(1 2)) :test #'equalp)

(assoc 'alpha '((type box) (x 3)(y 4)(xy 3 4)(1 2)) :test #'eq)

(assoc 'alpha '((type box) (x 3)(y 4)(xy 3 4)(1 2)(alpha 5)) :test #'eq)

(assoc 'x '((type box) (x 3)(y 4)(xy 3 4)(1 2)) :test #'eq)

(assoc 'y '((type box) (x 3)(y 4)(xy 3 4)(1 2)) :test #'eq)

(box 2 3 )

(box-move-right (box-move-left (box-move-left (box-move-right (box 2 3 )))))

(box-move-down (box 2 3))

(box-move-down (box-move-down (box 2 3)))





;; interactive learning experience
;; ----------------------------------------------------------------
;; idea is to avoid crashing out of the application
;; using an array indexing out of bounds - crashes the application
;; division by zero - crashes the appl
;; taking the car of an integer - crashes the application
;; using an integer as a vector - crashes the application
;; have a gui available to explore ideas






