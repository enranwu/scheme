(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (cons-all first rests)
  (define (helper s)
    (append (list first) s)
    )
  (map helper rests)
  )

(define (zip pairs)
  (list (map car pairs)
        (map cadr pairs)
    )
  )

;; Problem 16
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 16
    (define (helper l i)
      (if (null? l) nil
        (cons (list i (car l)) (helper (cdr l) (+ i 1)))
        )
      )
  (helper s 0)
  )
  ; END PROBLEM 16

;; Problem 17
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 17
  (cond
    ((= total 0)
      '(()))
    ((or (< total 0) (null? denoms))
      nil)
    (else
      (append
        (cons-all (car denoms) (list-change (- total (car denoms)) denoms))
        (list-change total (cdr denoms))
        )
      )
    )
  )
  ; END PROBLEM 17

;; Problem 18
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 18
         expr
         ; END PROBLEM 18
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 18
         expr
         ; END PROBLEM 18
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 18
           (append (list form params) (let-to-lambda body))
           ; END PROBLEM 18
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 18
          (cons
            (cons 'lambda (cons
              (car (zip (let-to-lambda values)))
              (let-to-lambda body)))
            (cadr (zip (let-to-lambda values)))
            )
           ; END PROBLEM 18
           ))
        (else
         ; BEGIN PROBLEM 18
         (map let-to-lambda expr)
         ; END PROBLEM 18
         )))
