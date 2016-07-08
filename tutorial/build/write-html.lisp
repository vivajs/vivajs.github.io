(cd-viva)

(defmacro write-html-mac (filename)
  (pcl-with-gensyms
   (in)
   (with-open-file (in filename)
     `(with-html-to-file ((concatenate
                           'string
                           (slice ,filename 0 -5) ".html"))
        (html ,@(read in))))))

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
