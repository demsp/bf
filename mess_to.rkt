(define (message_to mess)(mess "Hello "))
;modul1.mess + message_to.mess
(define (modul1 mess)(display (string-append mess "World")))
(message_to modul1)
; Hello World
(define (dispatch m)(m 1))
(define (x a )(+ a 10))
(dispatch x)
; 11
(define (x1 a)
(define (y1 b)
(+ a b)
)
y1)
(dispatch (x1 100)) ; 101
