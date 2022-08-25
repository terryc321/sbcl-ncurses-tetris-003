

;;(quicklisp:quickload :uiop)

(uiop:define-package :main
    (:use :cl))

(in-package :main)

;; shared c library
(load "curses.lisp")

;; 
(load "test.lisp")

(test::setup)
;;(test::colors)
;;(test::test)
;;(test::game-loop)
(test::game-loop2)
(test::clear)











