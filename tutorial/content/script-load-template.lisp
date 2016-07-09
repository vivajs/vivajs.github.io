(:article
 (:h2 "ARTICLE TEMPLATE HEADER")

 (:p "content")

 (:pre :data-language "text/html"
       (:print (file-string "script-a.js")))
 
 (:p "Just Text")

 (:pre :data-language "javascript"
       "console.log(sq(9) > 50);")

 (:pre :data-language "javascript"
       "console.log(\"Hello\");")

 ) ;; END article
