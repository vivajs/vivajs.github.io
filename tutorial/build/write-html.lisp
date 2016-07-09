;;; Page structure, see content/hello.lisp
;; (:html
;;  (:tag :attribute value)
;;  (:p "One plus two is " (:print (+ 1 2)))

;; go to "content" folder
(cd-viva)

(defparameter *structure*
  ;; new-chapterp, where t starts new chapter  filename  title
  '((t "o-caminho-do-programa" "O caminho do programa")
    (nil "o-que-e-um-programa" "O que é um programa?")
    (nil "o-primeiro-programa" "O primeiro programa")
    (nil "glossario-01" "Glossário")
    (t "variaveis-expressoes-e-instrucoes" "Variáveis, expressões e instruções")
    (nil "instrucoes-de-atribuicao" "Instruções de atribuição")
    (t "funcoes" "Funções")
    (nil "chamadas-de-funcoes" "Chamadas de funções")))


(defmacro write-html-article (filename html-title prev next)
  (let ((lisp-filename (concatenate 'string filename ".lisp"))
        (html-filename (concatenate 'string filename ".html"))
        (prev-filename (concatenate 'string prev ".html"))
        (next-filename (concatenate 'string next ".html")))
    (format t "WRITE-HTML-ARTICLE: ~a~%" filename)
    (pcl-with-gensyms
     (in)
     (with-open-file (in lisp-filename)
       `(with-html-to-file (,html-filename)
          (html
           (:html
            :lang "en"
            (:head
             (:meta :charset "utf-8")
             (:title ,(concatenate 'string html-title " - Viva JS!"))
             (:link :rel "stylesheet" :href "../css/ejs-sandbox.css"))
            (:body
             (:header
              (:a :class "imgNav" :href ,prev-filename
                  (:img :src "img/prev.png" :alt "prev"))
              (:a :class "imgNav" :href "index.html"
                  (:img :src "img/home.png" :alt "home"))
              (:a :class "imgNav" :href ,next-filename
                  (:img :src "img/next.png" :alt "next")))

             (:article
              (:h2 ,html-title)
              
              ,(read in)
              
              )  ;; END article
             
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

;;; main function
(defmacro build-site ()
  (let ((chapter 0)
        (subsection 0)
        (prev-file "")
        (cur-file "")
        (next-file "")
        (cur-elem nil)
        (write-commands ()))
    (dotimes (n (length *structure*))
      (setf cur-elem (nth n *structure*))
      
      ;; (format t "~a " (cadr cur-elem))
      ;; define prev, current, and next pages
      (if (< n 1)
          (setf prev-file "index")
          (setf prev-file (cadr (nth (- n 1) *structure*))))
      (setf cur-file (cadr (nth n *structure*)))
      (if (= n (- (length *structure*) 1))
          (setf next-file "end")
          (setf next-file (cadr (nth (+ n 1) *structure*))))
      
      (incf subsection)
      (if (car cur-elem)
          (progn 
            (incf chapter)
            (setf subsection 0)))
      (let ((chapter-subsection
             (format nil "~a~a."
                     chapter
                     (if (> subsection 0)
                         (format nil ".~a" subsection)
                         ""))))
        
        (push `(write-html-article ,(cadr cur-elem)
                                   ,(concatenate 'string chapter-subsection " " (caddr cur-elem))
                                   ,prev-file
                                   ,next-file) write-commands)))
    `(progn ,@(reverse write-commands))))

(defun generate-contents ()
  (let ((chapter 0)
        (subsection 0)
        (page nil)
        (links ()))
    (dotimes (n (length *structure*))
      (setf page (nth n *structure*))
      (incf subsection)
      (if (car page)
          (progn 
            (incf chapter) 
            (setf subsection 0)))
      (let ((chapter-subsection
             (format nil "~a~a. "
                     chapter
                     (if (> subsection 0)
                         (format nil ".~a" subsection)
                         ""))))
        
        (push `(:a :href ,(concatenate 'string (cadr page) ".html")
                   ,(concatenate 'string chapter-subsection (caddr page)) (:br)) links)))
    (reverse links)))

(defmacro write-index ()
  (format t "WRITE-INDEX: index~%")
  `(with-html-to-file ("index-generated.html")
     (html
      (:html
       :lang "en"
       (:head
        (:meta :charset "utf-8")
        (:title "JavaScript Tutorial - Viva JS!")
        (:link :rel "stylesheet" :href "../css/ejs-sandbox.css"))
       (:body
        (:article
         (:h2 "Viva JS! JavaScript Tutorial")
         (:section
          ,@(generate-contents))
         )  ;; END article
        (:article
         (:a :href "LICENSE.html" :target "_blank" "Licenças"))
        )))))

