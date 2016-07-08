(:html
 :lang "en"
 (:head
  (:meta :charset "utf-8")
  (:title "TITLE")
  (:link :rel "stylesheet" :href "../css/ejs-sandbox.css"))
 (:body
  (:article
   (:h2 "ARTICLE HEADING")
   (:p "content")
   
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
   
   (:p "Does a previous definition carry over?")
   
   (:pre :data-language "javascript"
         "console.log(sq(9) > 50);")
   
   (:pre :data-language "javascript"
         "console.log(\"Hello\");")

   ) ;; END article
  
  (:script :src "../js/ejs-codemirror.js")
  (:script :src "../js/ejs-tartaruga.js")
  (:script :src "../js/ejs-sandbox.js")))



