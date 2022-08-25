
(ql:quickload :fiveam)

(uiop:define-package :test-pieces
    (:use :cl :cl-user :fiveam :pieces))


(in-package :pieces)

(fiveam::def-suite example-suite :description "The example test suite.")
(fiveam::in-suite example-suite)

(fiveam:test piece0 (fiveam:is (equalp `( (color blue) (id 0) (points  ((0 0)    (0 1)    (1 1)    (1 0)  )))
				       (pieces::make-piece-0))))

(fiveam:test piece1 (fiveam:is (equalp `( (color blue) (id 1) (points  ((0 2)    (0 1)    (1 1)    (1 0)  )))
				       (pieces::make-piece-1))))

(fiveam:test piece2 (fiveam:is (equalp `( (color blue) (id 2) (points ( (2 1)    (1 1)    (1 0)    (0 0)  )))
				       (pieces::make-piece-2))))

(fiveam:test piece3 (fiveam:is (equalp  `( (color blue) (id 3) (points ( (1 2)    (0 1)    (1 1)    (0 0)  )))
				       (pieces::make-piece-3))))


(fiveam:test piece4 (fiveam:is (equalp `( (color blue) (id 4) (points(  (0 1)    (1 1)    (1 0)    (2 0)  )))
				       (pieces::make-piece-4))))

(fiveam:test piece5 (fiveam:is (equalp   `( (color blue) (id 5) (points  ((1 1)    (0 0)    (1 0)    (2 0)  )))
				       (pieces::make-piece-5))))

(fiveam:test piece6 (fiveam:is (equalp  `( (color blue) (id 6) (points  ((1 1)    (0 0)    (0 1)    (0 2)  )))
				       (pieces::make-piece-6))))

(fiveam:test piece7 (fiveam:is (equalp  `( (color blue) (id 7) (points ( (0 1)    (1 1)    (2 1)    (1 0)  )))
				       (pieces::make-piece-7))))

(fiveam:test piece8 (fiveam:is (equalp `( (color blue) (id 8) (points  ((1 2)    (0 1)    (1 0)    (1 1)  )))
				       (pieces::make-piece-8))))

(fiveam:test piece9 (fiveam:is (equalp  `( (color blue) (id 9) (points ( (0 0)    (1 0)    (2 0)    (3 0)  )))
				       (pieces::make-piece-9))))

(fiveam:test piece10 (fiveam:is (equalp `( (color blue) (id 10) (points  ((0 0)    (0 1)    (0 2)    (0 3)  )))
				       (pieces::make-piece-10))))

(fiveam:test piece11 (fiveam:is (equalp  `( (color blue) (id 11) (points  ((0 0)    (1 0)    (1 1)    (1 2)  )))
				       (pieces::make-piece-11))))

(fiveam:test piece12 (fiveam:is (equalp   `( (color blue) (id 12) (points  ((0 1)    (0 0)    (1 0)    (2 0)  )))
				       (pieces::make-piece-12))))

(fiveam:test piece13 (fiveam:is (equalp `( (color blue) (id 13) (points ( (0 0)    (0 1)    (0 2)    (1 2)  )))
				       (pieces::make-piece-13))))

(fiveam:test piece14 (fiveam:is (equalp  `( (color blue) (id 14) (points ( (0 1)    (1 1)    (2 1)    (2 0)  )))
				       (pieces::make-piece-14))))

(fiveam:test piece15 (fiveam:is (equalp  `( (color blue) (id 15) (points ( (0 0)    (0 1)    (0 2)    (1 0)  )))
				       (pieces::make-piece-15))))


(fiveam:test piece16 (fiveam:is (equalp  `( (color blue) (id 16) (points  ((0 0)    (0 1)    (1 1)    (2 1)  )))
				       (pieces::make-piece-16))))

(fiveam:test piece17 (fiveam:is (equalp  `( (color blue) (id 17) (points ( (0 2)    (1 2)    (1 1)    (1 0)  )))
				       (pieces::make-piece-17))))

(fiveam:test piece18 (fiveam:is (equalp  `( (color blue) (id 18) (points ( (0 0)    (1 0)    (2 0)    (2 1)  )))
				       (pieces::make-piece-18))))



(fiveam:test move1 (fiveam:is (equalp  `( (color blue) (id 18) (points ( (0 0)    (1 0)    (2 0)    (2 1)  )))
				       (pieces::make-piece-18))))



;;(fiveam:test piece1 (fiveam:is (= 3 (/ 2 0))))
(fiveam:run!)


