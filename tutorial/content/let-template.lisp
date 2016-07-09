(:article
 (:h2 "ARTICLE TEMPLATE HEADER")

 (let ((script-a (file-string "script-a.js"))
       (script-b
        "// script B"))
   (html   
    (:p "content")

    (:pre :data-language "text/html"
          (:print script-a))
    
    (:p "Just Text")

    (:pre :data-language "javascript"
          (:print script-b))

    (:p "Does a previous definition carry over?")

    (:pre :data-language "javascript"
          "console.log(sq(9) > 50);")

    (:pre :data-language "javascript"
          "console.log(\"Hello\");")
    ) ;; END html
   ) ;; END let
 ) ;; END article
