

(uiop:define-package :pieces
    (:use :cl :cl-user))

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

