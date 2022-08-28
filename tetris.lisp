

;;(quicklisp:quickload :uiop)
(defpackage :tetris
    (:use :cl))
(in-package :tetris)


(defun make-board () nil)

;; board is a list of occupied squares
;; square is occupied if there is an entry in the board for square x y
(defun occupied-p (board x y)  (member (list x y) board :test #'equalp))

(defun occupy(board x y)
  (cons (list x y) board))


(defun show-board(board &optional (stream t))
  (format stream "~% ##################################")
  (loop for y from 20 downto 1 do
    (format stream "~% # ")
    (loop for x from 1 to 10 do
      (if (occupied-p board x y)
	  (format stream " X ")
	  (format stream " . ")))
    (format stream " # "))
  (format stream "~% ##################################~%"))

(defun transform(xs key val)
  (cond
    ((null xs) nil)
    ((eq (car (car xs)) key)
     (cons (list key val) (cdr xs)))
    (t (cons (car xs)
	     (transform (cdr xs) key val)))))


(defun assoc-val(sym alist)
  (let ((out (assoc sym alist)))
    (if (listp out)
	(second out)
	(progn
	  (format t "~%WARNING assoc-val symbol [~a] not found in alist [~a]~%" sym alist)
	  nil))))
	


(defun get-x (alist)
  (assoc-val 'x alist))

(defun get-y (alist)
  (assoc-val 'y alist))

(defun get-type (alist)
  (assoc-val 'type alist))
 

;; box
;; 0,0      1,0
;; 0,-1     1,-1
(defun box-squares(x y)
  (let ((squares '((0 0) (1 0) (0  -1)(1 -1))))
    (mapcar (lambda (pos)
	      (destructuring-bind (mx my) pos
		(list (+ x mx) (+ y my))))
	    squares)))


(defun box-turn-right(box) box)

(defun box-turn-left(box) box)

(defun box-move-right(box)
  (transform box 'x (+ 1 (get-x box))))

(defun box-move-left(box)
  (transform box 'x (- (get-x box) 1)))

(defun box-move-down(box)
  (transform box 'y (- (get-y box) 1)))

(defun box-move-to(box x y)
  (transform (transform box 'x x) 'y y))

(defun box(x y) (list '(type box) (list 'x x) (list 'y y)))

;; does this box occupy square x y
(defun box-occupy-p(x y) t)





