(:article
 (:h2 "O Caminho do programa")

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
