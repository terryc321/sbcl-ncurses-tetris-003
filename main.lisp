

;;(quicklisp:quickload :uiop)

(uiop:define-package :main
    (:use :cl))

(in-package :main)

;; shared c library

(load "curses.lisp")

;; attempt load macros before usage
(load "test-macros.lisp")
(load "test.lisp")

(load "pieces.lisp")


(test::setup)
;;(test::colors)
;;(test::test)
;;(test::game-loop)
(test::game-loop2)
(test::clear)











