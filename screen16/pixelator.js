var pixelator = function(context) {
  // http://stackoverflow.com/questions/4899799/whats-the-best-way-to-set-a-single-pixel-in-an-html5-canvas
  
  var id = context.createImageData(1, 1);
  var d = id.data;
  
  function drawPixel(x, y, color) {
    d[0] = color[0];
    d[1] = color[1];
    d[2] = color[2];
    d[3] = color[3];
    context.putImageData(id, x, y);
  }

  function drawLine(startX, startY, endX, endY, color) {
    context.beginPath();
    context.moveTo(startX, startY);
    context.lineTo(endX, endY);
    context.lineWidth = 1;
    context.strokeStyle = color;
    context.stroke();
  }
  
  return {
    drawPixel: drawPixel,
    drawLine: drawLine,
  };
};


