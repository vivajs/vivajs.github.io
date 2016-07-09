;;; Page structure, see content/hello.lisp
;; (:html
;;  (:tag :attribute value)
;;  (:p "One plus two is " (:print (+ 1 2)))

;; go to "content" folder
(cd-viva)

(defparameter *structure*
  ;; new-chapterp (t starts new chapter) filename title
  '((t "o-caminho-do-programa")
    (nil "o-que-e-um-programa")
    (nil "o-primeiro-programa")
    (nil "glossario-1")
    (t "variaveis-expressoes-e-instrucoes")
    (nil "instrucoes-de-atribuicao")
    (t "funcoes")
    (nil "chamadas-de-funcoes")))


(defun build-site ()
  (let ((chapter 0)
        (subsection 0)
        (prev-filename "")
        (cur-filename "")
        (next-filename "")
        (cur-elem nil))
    (dotimes (n (length *structure*))
      (setf cur-elem (nth n *structure*))
      
      ;; define prev, current, and next pages
      (if (< n 1)
          (setf prev-filename "index.html")
          (setf prev-filename (cadr (nth (- n 1) *structure*))))
      (setf cur-filename (cadr (nth n *structure*)))
      (if (= n (- (length *structure*) 1))
          (setf next-filename "end.html")
          (setf next-filename (cadr (nth (+ n 1) *structure*))))
      
      (incf subsection)
      (if (car cur-elem)
          (progn 
            (incf chapter)
            (setf subsection 0)))
      (format t "~a~a (P)~a ~a (N)~a~%"
              chapter
              (if (> subsection 0)
                  (format nil ".~a" subsection)
                  "")
              prev-filename
              (cadr cur-elem)
              next-filename))))

(defmacro write-html-article (filename prev next)
  (let ((lisp-filename (concatenate 'string filename ".lisp"))
        (html-filename (concatenate 'string filename ".html"))
        (prev-filename (concatenate 'string prev ".html"))
        (next-filename (concatenate 'string next ".html"))
        (html-title (replace-all
                     (concatenate 'string "Viva JS! "
                                  (string-capitalize filename))
                     "-" " ")))
    (pcl-with-gensyms
     (in)
     (with-open-file (in lisp-filename)
       `(with-html-to-file (,html-filename :pretty nil)
          (html
           (:html
            :lang "en"
            (:head
             (:meta :charset "utf-8")
             (:title ,html-title)
             (:link :rel "stylesheet" :href "../css/ejs-sandbox.css"))
            (:body
             (:header
              (:a :class "imgNav" :href ,prev-filename
                  (:img :src "img/prev.png" :alt "prev"))
              (:a :class "imgNav" :href "index.html"
                  (:img :src "img/home.png" :alt "home"))
              (:a :class "imgNav" :href ,next-filename
                  (:img :src "img/next.png" :alt "next")))
             
             ,(read in)
             
             (:footer
              (:a :class "imgNav" :href ,prev-filename
                  (:img :src "img/prev.png" :alt "prev"))
              (:a :class "imgNav" :href "index.html"
                  (:img :src "img/home.png" :alt "home"))
              (:a :class "imgNav" :href ,next-filename
                  (:img :src "img/next.png" :alt "next")))

             (:script :src "../js/ejs-codemirror.js")
             (:script :src "../js/ejs-tartaruga.js")
             (:script :src "../js/ejs-sandbox.js")
             (:script :src "../js/feature-check.js")))))))))

;; https://www.rosettacode.org/wiki/Read_entire_file#Common_Lisp
(defun load-file-as-string (path)
  (with-open-file (stream path)
    (let ((data (make-string (file-length stream))))
      (read-sequence data stream)
      data)))

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
