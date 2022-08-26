



;;----------------------- above broken code from old test.lisp ----------

(with-cyan 
      (loop for y from 0 to 21 do
	    (loop for x from 0 to 11 do
		  (offset-draw x y))))



       ((= piece 1)
	(with-blue
	    (offset-draw 1 1)
	  (offset-draw 1 2)
	  (offset-draw 2 2)
	  (offset-draw 2 3)
	  ))
       ((= piece 2)
	(with-blue
	    (offset-draw 1 1)
	  (offset-draw 2 1)
	  (offset-draw 2 2)
	  (offset-draw 3 2)
	  ))
       ((= piece 3)
	(with-blue
	    (offset-draw 1 2)
	  (offset-draw 1 3)
	  (offset-draw 2 1)
	  (offset-draw 2 2)
	  ))
       ((= piece 4)
	(with-blue
	    (offset-draw 2 1)
	  (offset-draw 3 1)
	  (offset-draw 1 2)
	  (offset-draw 2 2)
	  ))
       ((= piece 5)
	(with-blue
	    (offset-draw 2 1)
	  (offset-draw 1 2)
	  (offset-draw 2 2)
	  (offset-draw 3 2)
	  ))
       ((= piece 6)
	(with-blue
	    (offset-draw 1 1)
	  (offset-draw 1 2)
	  (offset-draw 1 3)
	  (offset-draw 2 2)
	  ))
       ((= piece 7)
	(with-blue
	    (offset-draw 1 1)
	  (offset-draw 2 1)
	  (offset-draw 3 1)
	  (offset-draw 2 2)
	  ))
       ((= piece 8)
	(with-blue
	    (offset-draw 1 2)
	  (offset-draw 2 1)
	  (offset-draw 2 2)
	  (offset-draw 2 3)
	  ))
       ((= piece 9)
	(with-blue
	    (offset-draw 1 1)
	  (offset-draw 2 1)
	  (offset-draw 3 1)
	  (offset-draw 4 1)
	  ))
       ((= piece 10)
	(with-blue
	    (offset-draw 1 1)
	  (offset-draw 1 2)
	  (offset-draw 1 3)
	  (offset-draw 1 4)
	  ))
       ((= piece 11)
	(with-blue
	    (offset-draw 1 3)
	  (offset-draw 2 1)
	  (offset-draw 2 2)
	  (offset-draw 2 3)
	  ))

       ((= piece 12)
	(with-blue
	    (offset-draw 1 1)
	  (offset-draw 1 2)
	  (offset-draw 2 2)
	  (offset-draw 3 2)
	  ))

       ((= piece 13)
	(with-blue
	    (offset-draw 1 1)
	  (offset-draw 2 1)
	  (offset-draw 1 2)
	  (offset-draw 1 3)
	  ))

       ((= piece 14)
	(with-blue
	    (offset-draw 1 1)
	  (offset-draw 2 1)
	  (offset-draw 3 1)
	  (offset-draw 3 2)
	  ))

       ((= piece 15)
	(with-blue
	    (offset-draw 1 1)
	  (offset-draw 1 2)
	  (offset-draw 1 3)
	  (offset-draw 2 3)
	  ))

       ((= piece 16)
	(with-blue
	    (offset-draw 1 1)
	  (offset-draw 2 1)
	  (offset-draw 3 1)
	  (offset-draw 1 2)
	  ))

       ((= piece 17)
	(with-blue
	    (offset-draw 1 1)
	  (offset-draw 2 1)
	  (offset-draw 2 2)
	  (offset-draw 2 3)
	  ))

       ((= piece 18)
	(with-blue
	    (offset-draw 3 1)
	  (offset-draw 1 2)
	  (offset-draw 2 2)
	  (offset-draw 3 2)
	  ))

       

;; compiler notes
(declaim (optimize (speed 0) (space 0) (safety 0)(debug 3)))


(defpackage "TETRIS" (:use "CL" "CL-USER"))(in-package "TETRIS")

(defvar tb #(#(1 1 -2 0 -1 0 0 0 1 0) #(0 0 0 0 0 -1 0 -2 0 -3) #(2 2 -1 0 0 0 -1 -1 0 -1)
  #(6 4 -1 0 -1 -1 -1 -2 0 -2) #(3 5 -1 -1 -1 0 0 0 1 0) #(4 6 -1 0 0 0 0 -1 0 -2) #(5 3 1 0 1 -1 0 -1 -1 -1)
  #(10 8 1 0 1 -1 1 -2 0 -2) #(7 9 -1 0 -1 -1 0 -1 1 -1)  #(8 10 0 0 1 0 0 -1 0 -2) #(9 7 -1 0 0 0 1 0 1 -1)
  #(12 12 -1 0 -1 -1 0 -1 0 -2) #(11 11 -1 -1 0 -1 0 0 1 0) #(14 14 0 -2 0 -1 1 -1 1 0) #(13 13 -1 0 0 0 0 -1 1 -1)
	     #(18 16 0 0 0 -1 0 -2 -1 -1) #(15 17 0 0 -1 -1 0 -1 1 -1) #(16 18 0 0 0 -1 0 -2 1 -1) #(17 15 -1 0 0 0 1 0 0 -1)))
(defvar hid 2)
(defvar h2 0)(defvar h3 0)
(defvar h4 0)(defvar h5 0)
(defvar h6 0)(defvar h7 0)
(defvar h8 0)(defvar h9 0)
(defvar bd (make-array '(12 22))) (defvar pk #(0 0 0))(defvar tk 0) (defvar ots #(0 0 0 0 0 0))
(defun pk()  (setf (aref pk 0) (random 20))  (setf (aref pk 1) 5)  (setf (aref pk 2) 20))

;; bd never accessed directly (aref bd x y) is not allowed in code - unless here.
(defun aref-bd(x y)
  (cond
    ((or (< x 1) (> x 10) (< y 1)(> y 20)) 100)
    (t (aref bd x y))))


(defun ots() (let* ((s (aref pk 0)) (x (aref pk 1)) (y (aref pk 2)) (en (aref tb s))
		    (pv (aref en 0)) (nx (aref en 1)) (en2 (aref tb pv)) (en3 (aref tb nx))	(c2 (aref en 2))(c3 (aref en 3))(c4 (aref en 4))(c5 (aref en 5))(c6 (aref en 6))(c7 (aref en 7))(c8 (aref en 8))(c9 (aref en 9))(d2 (aref en2 2))(d3 (aref en2 3))(d4 (aref en2 4))(d5 (aref en2 5))(d6 (aref en2 6))(d7 (aref en2 7))(d8 (aref en2 8))(d9 (aref en2 9))(e2 (aref en3 2))(e3 (aref en3 3))(e4 (aref en3 4))(e5 (aref en3 5))(e6 (aref en3 6))(e7 (aref en3 7))(e8 (aref en3 8))(e9 (aref en3 9)))	       
	       (setq h2 (+ x c2))  (setq h3 (+ y c3)) ; cords when fix
	       (setq h4 (+ x c4))  (setq h5 (+ y c5))
	       (setq h6 (+ x c6))  (setq h7 (+ y c7))
	       (setq h8 (+ x c8))  (setq h9 (+ y c9))
	       (setf (aref ots 0) (if (or (> (aref-bd (+ x c2) (+ y c3)) 0) ; instant collision
					  (> (aref-bd (+ x c4) (+ y c5)) 0)
					  (> (aref-bd (+ x c6) (+ y c7)) 0)
					  (> (aref-bd (+ x c8) (+ y c9)) 0))
				      nil pk))
	       (setf (aref ots 1) (if (or (> (aref-bd (+ x c2 -1) (+ y c3)) 0) ;; 1 : left
					  (> (aref-bd (+ x c4 -1) (+ y c5)) 0) ;; same sprite moved left
					  (> (aref-bd (+ x c6 -1) (+ y c7)) 0)
					  (> (aref-bd (+ x c8 -1) (+ y c9)) 0))
				      nil (make-array 3 :initial-contents (list s (- x 1) y))))
	       (setf (aref ots 2) (if (or (> (aref-bd (+ x c2 1) (+ y c3)) 0) ;; 2 : right
					  (> (aref-bd (+ x c4 1) (+ y c5)) 0) ;; same sprite moved right
					  (> (aref-bd (+ x c6 1) (+ y c7)) 0)
					  (> (aref-bd (+ x c8 1) (+ y c9)) 0))
				      nil (make-array 3 :initial-contents (list s (+ x 1) y))))
	       (setf (aref ots 3) (if (or (> (aref-bd (+ x c2) (+ y c3 -1)) 0) ;; 3 : down
					  (> (aref-bd (+ x c4) (+ y c5 -1)) 0) ;; same sprite moved down
					  (> (aref-bd (+ x c6) (+ y c7 -1)) 0)
					  (> (aref-bd (+ x c8) (+ y c9 -1)) 0))
				      nil (make-array 3 :initial-contents (list s x (- y 1)))))
	       (setf (aref ots 4) (if (or (> (aref-bd (+ x d2) (+ y d3)) 0) ;; 4 : rotate
					  (> (aref-bd (+ x d4) (+ y d5)) 0) ;; different shape or sprites
					  (> (aref-bd (+ x d6) (+ y d7)) 0)
					  (> (aref-bd (+ x d8) (+ y d9)) 0))
				      nil (make-array 3 :initial-contents (list pv x y))))
	       (setf (aref ots 5) (if (or (> (aref-bd (+ x e2) (+ y e3)) 0) ;; 5 : rotate other direction
					  (> (aref-bd (+ x e4) (+ y e5)) 0) ;; different shape or sprites
					  (> (aref-bd (+ x e6) (+ y e7)) 0)
					  (> (aref-bd (+ x e8) (+ y e9)) 0))
				      nil (make-array 3 :initial-contents (list nx x y))))))

(defun hid() (setq hid 2))
(defun clr() ;; clr bd  -- put my border around it
  (setq bd (make-array '(12 22)))
  (loop for x from 0 to 11 do (setf (aref bd x 0) 1) (setf (aref bd x 21) 1))
  (loop for y from 0 to 21 do (setf (aref bd 0 y) 1) (setf (aref bd 11 y) 1)))
(defun new-gam() (clr)(hid)(pk)) ;; clr bd , reset hid , new puk
(defun new-pk() (pk)) ;; (h2,h3) , (h4,h5) , (h6,h7) , (h8,h9)
(defun fix-here()
  (setf (aref bd h2 h3) hid)
  (setf (aref bd h4 h5) hid)
  (setf (aref bd h6 h7) hid)
  (setf (aref bd h8 h9) hid)
  (incf hid))

(defun scroll-down()
  (let ((tot 0))
    (loop for y from 1 to 20 do
      (setq tot 0)
      (loop for x from 1 to 10 do
	(if (> (aref-bd x y) 0) (incf tot)))
      (when (= tot 10)
	(loop for y from (+ y 1) to 20 do
	  (loop for x from 1 to 10 do
	    (setf (aref bd x (- y 1)) (aref bd x y))))))))
	  
(defvar win) ; ncurses win
(defvar msg-y 2)
(defun msg(m &optional (x 1) (y msg-y)) ;; like a teletype terminal
  (when (> msg-y 40) ;; scrollback
    (if (= y msg-y) (setq y 1))
    (setq msg-y 1)
    (curses::mvprintw 2 1 (format nil "                  " )))
  (cond ((and (= x 2)(= y msg-y)) (curses::mvprintw y x (format nil "~a" m)) (incf msg-y))
	(t (curses::mvprintw y x (format nil "~a" m)))))
(defun put(x y m) (curses::mvprintw (- 40 y) (+ (* x 3) 10) (format nil "~a" m)))
(defun cput(x y m) (put x y (code-char (+ m (char-code #\a)))))

(defun show()
  (curses::mvprintw 1 1 (format nil "tk ~a " tk))
  (curses::attron 1)
  (loop for y from 21 downto 0 do
    (loop for x from 0 to 11 do
      (let ((s (aref bd x y)))
	(cond
	  ((zerop s) (put x y " "))
	  (t (cput x y s))))))
  (curses::attroff 1)

  
  
  (cput h2 h3 hid)
  (cput h4 h5 hid)
  (cput h6 h7 hid)
  (cput h8 h9 hid)
  (curses::refresh))
(defvar tk-lim 10000000)
(defvar clock 0)
(defun elapsed() (- (get-universal-time) clock))
(defun start-timer() (setq clock (get-universal-time)))
(defun out-of-time-p() (> (elapsed) 2))
(defvar status "alive")
(defvar ch 0)
(defun gamlup()
  (prog ()
   new-gam
     (new-gam)
     ;; 
     ;;(progn (setf (aref pk 0) 17)  (setf (aref pk 1) 5)  (setf (aref pk 2) 20))
     (setq msg-y 1)

   new-level
     (start-timer)
   top
     (setq ch (curses::wgetch win))
     (when (= ch (char-code #\q)) (msg "qut") (go over)) ; qut	 

     (msg (format nil ": elapsed [~a] " (elapsed)) 30 2)
     (show)
     (ots) ; brins
     (when (not (and 'stay (aref ots 0)))
       (setq status "deaddeaddeaddeaddeaddeaddeaddeaddeaddeaddeaddeaddead")(msg status)(go over))
     (when (or (and 'out-of-time (out-of-time-p) (not (aref ots 3))) ; fkd
	       (not (or (aref ots 1)(aref ots 2)(aref ots 3)(aref ots 4)(aref ots 5)))) ;;nowhere to go
       (msg "fix")
       (fix-here)
       (scroll-down) 
       (new-pk) 
       (go new-level))
     (when (and 'out-of-time (out-of-time-p) (> tk tk-lim)); dwn forced
       (msg "<time")
       (setq pk (aref ots 3))
       (setq tk 0) 
       (go new-level))
     ;; free will
     (when (and 'left (= ch (char-code #\a)) (msg "lft") (aref ots 1)) ;lft
       (setq pk (aref ots 1))
       (go top))
     (when (and 'down (= ch (char-code #\d))(msg "rgt") (aref ots 2)) ;dwn
       (setq pk (aref ots 2))
       (go top))
     (when (and 'right (= ch (char-code #\s))(msg "dwn") (aref ots 3));rgt
       (setq pk (aref ots 3))
       (go top))
     (when (and 'rot (= ch (char-code #\e))(msg "rot2") (aref ots 4));rot
       (setq pk (aref ots 4))
       (go top))
     (when (and 'rot2 (= ch (char-code #\w))(msg "rot3") (aref ots 5));rot2
       (setq pk (aref ots 5))
       (go top))
     
     (go top)
   over
     (msg "** WOULD YOU LIKE TO PLAY A NEW GAME ? y / n > ")
   over-loop
     (setq ch (curses::wgetch win))
     (when (= ch (char-code #\n)) (msg "qut qut") (go really-over)) ; qut qut	 
     (when (= ch (char-code #\y)) (go new-gam)) ; qut qut
     (go over-loop)
   really-over );prog
  );;gamlup
(defun gamset() (setq win (curses::initscr))(curses::clear)(curses::raw)(curses::noecho)(curses::nodelay win t)(curses::cbreak)(curses::mvprintw 5 5 "we are the champions !")
  )
(defun gamclr() (curses::clrtoeol)(curses::endwin))
(defun run-normal()
  (gamset)
  
  (when ;; 
      (curses::has-colors)
    (curses::start-color)
    (curses::init-pair 1 curses::color_yellow curses::color_blue)
    (curses::color-set 1 ))

  
  (gamlup)
  (gamclr))


;;------ state of computation ------------
(defun dump-state()
  (format t "~%tetris board - excluding the moving piece~%")
  (loop for y from 21 downto 0 do
    (format t "~%")
    (loop for x from 0 to 11 do
      (let ((s (aref bd x y)))
	(cond
	  ((zerop s) (format t " "))
	  (t (format t "~a" (code-char (+ s (char-code #\a)))))))))
  (format t "~%~%moving piece has coordinates ~%")
  (format t "h2,h3 (~a,~a) " h2 h3)
  (format t "h4,h5 (~a,~a) " h4 h5)
  (format t "h6,h7 (~a,~a) " h6 h7)
  (format t "h8,h9 (~a,~a) " h8 h9)
  (format t "~%")
  (sb-debug:list-backtrace)
  )

(defun recover-from-ncurses()
  (curses::clrtoeol) ;; clean up curses terminal 
  (curses::endwin)
  (dump-state))

  
(defun run()
  (sb-ext:enable-debugger)
  (setq sb-debug:*debug-beginner-help-p* t)
  
  (handler-bind
      ((sb-int:invalid-array-index-error
	 (lambda (err)
	   (recover-from-ncurses)
	   (format t "Got error: ~a~%" err)))
       (sb-sys:interactive-interrupt
	 (lambda (err)
	   (recover-from-ncurses)
	   (format t "Got interrupted: ~a~%" err))))
    (run-normal)))















;; redirect stdout to file
;; redirect stderr to same file


;; ------------------------------ bug hunting -----------------------------------












