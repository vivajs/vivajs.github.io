(:section
 (:p "
Conteúdo
")

 (:p "p. 91")

 (:pre :data-language "javascript"
       "let sum = (term, a, next, b) => {
if (a > b) {
return 0;
}
return (term(a) + (sum(term, next(a), next, b)));
}

let inc = (n) => n + 1;

let cube = (x) => x * x * x;

let sumCubes = (a, b) => {
return sum(cube, a, inc, b);
}

console.log(sumCubes(1, 10));
")

 ) ;; END section
