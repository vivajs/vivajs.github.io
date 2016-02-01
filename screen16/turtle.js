function Turtle(avatarContext, boardContext, id, name, color) {
  this.avatarContext = avatarContext;
  this.boardContext = boardContext;

  this.id = id;
  this.name = name;
  this.color = color;

  this.x = 200;
  this.y = 200;

  this.width = 8;
  this.height = 13;
  
  this.display(this.x, this.y);
}

Turtle.prototype.display = function() {
  this.avatarContext.beginPath();
  this.avatarContext.moveTo(this.x, this.y);
  this.avatarContext.lineTo(this.x - (this.width / 2), this.y + this.height);
  this.avatarContext.lineTo(this.x + (this.width / 2), this.y + this.height);
  this.avatarContext.lineTo(this.x, this.y);
  
  this.avatarContext.strokeStyle = this.color;
  this.avatarContext.stroke();
}

Turtle.prototype.moveTo = function(x, y) {
  this.avatarContext.clearRect(this.x - this.width, this.y - this.height, this.width * 2, 10 + this.height * 2);
  this.x = x;
  this.y = y;
  this.display();
}

Turtle.prototype.rotate = function() {
  this.avatarContext.save();
  this.avatarContext.translate(this.x, this.y);
  this.avatarContext.rotate(0.3);
}
