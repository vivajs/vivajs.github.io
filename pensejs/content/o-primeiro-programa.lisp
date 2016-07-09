(:section
 (:p "Conteudo")

 (:pre :data-language "javascript"
       "function eGrande(x) {
  if (x > 9000) {
    console.log('É grande!!');
  } else {
    console.log('Não muito grande.')
  }
}")

 (:p "
Testar sinal de um numero")
 
 (:pre :data-language "javascript"
       (:print (load-file-as-string "js/sinal.js")))

 ) ;; END section
