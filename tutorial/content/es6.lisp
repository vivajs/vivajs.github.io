(:article
 (:h2 "ARTICLE TEMPLATE HEADER")

 (:p "content")

 (:pre :data-language "text/html"
       "class Rectangle {
constructor (width, height) {
this.width  = width;
this.height = height;
 }
}
var r = new Rectangle(50, 20);
")

 (:p "Just Text")

 (:pre :data-language "javascript"
       "class Rectangle {
constructor (width, height) {
this.width  = width;
this.height = height;
 }
}
var r = new Rectangle(50, 20);
")

 (:p "Does a previous definition carry over?")

 (:pre :data-language "javascript"
       "console.log(sq(9) > 50);")

 (:pre :data-language "javascript"
       "console.log(\"Hello\");")

 ) ;; END article
