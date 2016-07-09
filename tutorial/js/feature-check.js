try {
  eval('"use strict"; class MyClass { }');
} catch (e) {
  console.log(e);
  var warning = document.createElement("div");
  warning.style.backgroundColor = "#922";
  warning.style.color = "#FFF";
  warning.style.padding = "8px";
  warning.style.marginBottom = "15px";
  warning.appendChild(document.createTextNode("Warning: " + e));
  var firstP = document.getElementsByTagName("p")[0];
  firstP.insertBefore(warning, firstP.firstChild);
}
