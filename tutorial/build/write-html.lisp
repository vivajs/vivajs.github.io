;;; Page structure, see content/hello.lisp
;; (:html
;;  (:tag :attribute value)
;;  (:p "One plus two is " (:print (+ 1 2)))

;; go to "content" folder
(cd-viva)

(defmacro write-html-article (filename title)
  (pcl-with-gensyms
   (in)
   (with-open-file (in filename)
     `(with-html-to-file ((concatenate
                           'string
                           (slice ,filename 0 -5) ".html"))
        (html
         (:html
          :lang "en"
          (:head
           (:meta :charset "utf-8")
           (:title ,title)
           (:link :rel "stylesheet" :href "../css/ejs-sandbox.css")
           (:script :src "../js/ejs-codemirror.js")
           (:script :src "../js/ejs-tartaruga.js")
           (:script :src "../js/ejs-sandbox.js"))
          (:body
           ,(read in))))))))

;; (defun write-html (filename)
;;   (with-open-file (in filename)
;;     (with-html-to-file ((concatenate
;;                          'string
;;                          (slice filename 0 -5) ".html"))
;;       (html (read in)))))

;; (defmacro read-html-mac (filename)
;;   (with-open-file (in filename)
;;     `(html ,@(read in))))        

;; (defun read-html (filename)
;;   (with-open-file (in filename)
;;     ;; (html (read in))))
;;     (html (:b "bold"))
;;     (read in)))
