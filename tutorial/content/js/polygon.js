// polygon.js
// Choose your polygon's number of sides 
var sides = 6;  // hexagon

var sideLength = 50;
var interiorAngle = (sides - 2) * 180 / sides;  // geometric formula
var turnAngle = 180 - interiorAngle;

for (var i = 0; i < sides; i++) {
  forward(sideLength);
  turnRight(turnAngle);
}
