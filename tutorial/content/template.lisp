(:html
 :lang "en"
 (:head
  (:meta :charset "utf-8")
  (:title "TITLE")
  (:link :rel "stylesheet" :href "../css/ejs-sandbox.css"))
 (:body
  (:article
   (:p "content")
   
   (:pre :data-language "text/html"
         "forward(50);
turnRight(30);
forward(20);")
   
   (:p "Just Text")
   
   (:pre :data-language "javascript"
         "function sq(x) {
  return x * x;
}

console.log(sq(9));"))
  
  (:script :src "../js/ejs-codemirror.js")
  (:script :src "../js/ejs-tartaruga.js")
  (:script :src "../js/ejs-sandbox.js")))



