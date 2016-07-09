;;; Run CLISP
;;; load tutorial/write-html.lisp
;;; eval whole file (Ctrl-Enter)
;;; (write-html-article "FILENAME")  ;; no .lisp extension

(:article
 (:h2 "HEADER")

 (:p "Content for Turtle")

 (:pre :data-language "text/html"
       "forward(50);
turnRight(30);
forward(70);")

 (:p "Just Text")

 (:pre :data-language "javascript"
       "function sq(x) {
  return x * x;
}

console.log(sq(9));")

 (:p "Load a script")
 
 (:pre :data-language "text/html"
       (:print (load-file-as-string "js/polygon.js")))
 
 ) ;; END article
