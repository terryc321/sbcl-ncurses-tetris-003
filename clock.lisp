

(uiop:define-package :clock
    (:use :cl))

(in-package :clock)


(defun test()
  (sleep 3))

(defun test2()
  (let ((a (get-internal-real-time))
	(b 0)
	(c 0))
    (test)
    (setq b (get-internal-real-time))
    (setq c (float (/ (- b a) internal-time-units-per-second)))
    (format t "time taken ~a seconds ~%" c)))


	  
  
