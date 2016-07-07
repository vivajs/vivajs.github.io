(cd-viva)

(defun write-html (filename)
  (with-open-file (in filename)
    (with-open-file
        (out (concatenate 'string
                          (slice filename 0 -5) ".html")
             :direction :output)
      (with-html-output (out :pretty t)
        (emit-html (read in))))))
