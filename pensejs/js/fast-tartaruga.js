var tartarugaCode = "\n\
  <style> \n\
  body { \n\
    max-height: 360px; \n\
    overflow: hidden; \n\
  } \n\
 \n\
#canvasContainer { \n\
  width: 780px; \n\
  height: 360px; \n\
  top: 0; \n\
  left: 0; \n\
  border: 2px dotted #AAA \n\
} \n\
 \n\
#desenhoCanvas { \n\
  position: absolute; \n\
  left: 8px; \n\
  top: 8px; \n\
  z-index: 0; \n\
} \n\
 \n\
#tartarugaCanvas { \n\
  position: absolute; \n\
  left: 8px; \n\
  top: 8px; \n\
  z-index: 1; \n\
} \n\
</style> \n\
   \n\
  <body> \n\
   \n\
  <div id='canvasContainer'> \n\
  <canvas id='desenhoCanvas' width='780' height='360'></canvas> \n\
  <canvas id='tartarugaCanvas' width='780' height='360'></canvas> \n\
  </div> \n\
 \n\
</body> \n\
   \n\
  <script> \n\
 \n\
var desenhoCanvas = document.getElementById('desenhoCanvas'); \n\
var desenhoCtx = desenhoCanvas.getContext('2d'); \n\
 \n\
var tartarugaCtx = document.getElementById('tartarugaCanvas').getContext('2d'); \n\
 \n\
var larguraCanvas = document.getElementById('desenhoCanvas').width; \n\
var alturaCanvas = document.getElementById('desenhoCanvas').height; \n\
 \n\
tartarugaCtx.fillStyle = 'green'; \n\
desenhoCtx.strokeStyle = 'black'; \n\
desenhoCtx.lineWidth = 1; \n\
 \n\
var opcoesAnimacao = { \n\
  tamanhoFragmento: 4, \n\
  intervalo: 1,  // INTERVALO padrao = 10 \n\
}; \n\
 \n\
function definaIntervalo(novoIntervalo) { \n\
  opcoesAnimacao.intervalo = novoIntervalo; \n\
} \n\
 \n\
function definaTamanhoFragmento(novoTamanho) { \n\
  opcoesAnimacao.tamanhoFragmento = novoTamanho; \n\
} \n\
 \n\
function Ponto(x, y) { \n\
  this.x = x; \n\
  this.y = y; \n\
} \n\
 \n\
function Tartaruga(cabeca, angulo) { \n\
  this.cabeca = cabeca;\n\
  this.altura = 20;\n\
  this.angulo = angulo;\n\
  this.visivel = true;\n\
  this.canetaAtiva = true;\n\
  this.ocupado = false;\n\
  this.filaComandos = [];\n\
  this.pausado = false;\n\
} \n\
 \n\
Tartaruga.prototype.getX = function() { \n\
  return this.cabeca.x; \n\
}; \n\
 \n\
Tartaruga.prototype.getY = function() { \n\
  return this.cabeca.y; \n\
}; \n\
 \n\
Tartaruga.prototype.getAngulo = function() { \n\
  return this.angulo; \n\
}; \n\
 \n\
Tartaruga.prototype.setAngulo = function(novoAngulo) { \n\
  this.angulo = novoAngulo; \n\
 \n\
  if (this.filaComandos.length > 0) { \n\
    this.executeComandos(); \n\
  } \n\
}; \n\
 \n\
Tartaruga.prototype.acumuleComando = function(comando) { \n\
  this.filaComandos.push(comando); \n\
  this.despause(); \n\
}; \n\
 \n\
Tartaruga.prototype.executeComandos = function() { \n\
  if (!this.ocupado && !this.pausado && this.filaComandos.length > 0) { \n\
    this.filaComandos.shift()(); \n\
  } \n\
}; \n\
 \n\
Tartaruga.prototype.pare = function() { \n\
  this.filaComandos = []; \n\
}; \n\
 \n\
Tartaruga.prototype.pause = function() { \n\
  this.pausado = true; \n\
}; \n\
 \n\
Tartaruga.prototype.despause = function() { \n\
  this.pausado = false; \n\
  this.executeComandos(); \n\
}; \n\
 \n\
Tartaruga.prototype.apague = function() { \n\
  var x = this.cabeca.x; \n\
  var y = this.cabeca.y; \n\
  tartarugaCtx.clearRect(x - this.altura * 2, y - this.altura * 2, \n\
                         this.altura * 4, this.altura * 4); \n\
}; \n\
 \n\
Tartaruga.prototype.alterneCaneta = function() { \n\
  this.canetaAtiva = !this.canetaAtiva; \n\
}; \n\
 \n\
Tartaruga.prototype.desligueCaneta = function() { \n\
  this.canetaAtiva = false; \n\
  if (this.filaComandos.length > 0) { \n\
    this.executeComandos(); \n\
  } \n\
}; \n\
 \n\
Tartaruga.prototype.ligueCaneta = function() { \n\
  this.canetaAtiva = true; \n\
  if (this.filaComandos.length > 0) { \n\
    this.executeComandos(); \n\
  } \n\
}; \n\
 \n\
Tartaruga.prototype.alterneVisibilidade = function() { \n\
  this.apague(); \n\
  this.visivel = !this.visivel; \n\
  if (this.visivel) { \n\
    this.desenhe(); \n\
  } \n\
}; \n\
 \n\
Tartaruga.prototype.desenheSe = function() { \n\
  return; // NAO DESENHAR \n\
  var x = this.cabeca.x; \n\
  var y = this.cabeca.y; \n\
  var altura = this.altura; \n\
 \n\
  var anguloLado = 20; \n\
   \n\
  var distCauda = 0.6; \n\
 \n\
 \n\
  var r = grParaRad(this.angulo); \n\
  var dx = -altura * Math.cos(r); \n\
  var dy = altura * Math.sin(r); \n\
 \n\
  var rEsq = grParaRad(this.angulo - anguloLado); \n\
  var dxEsq = -altura * Math.cos(rEsq); \n\
  var dyEsq = altura * Math.sin(rEsq); \n\
 \n\
  var rDir = grParaRad(this.angulo + anguloLado); \n\
  var dxDir = -altura * Math.cos(rDir); \n\
  var dyDir = altura * Math.sin(rDir); \n\
   \n\
  tartarugaCtx.beginPath(); \n\
  tartarugaCtx.moveTo(x, y); \n\
   \n\
  tartarugaCtx.lineTo(x+dxEsq, y+dyEsq);\n\
  tartarugaCtx.lineTo(x+(dx*distCauda), y+(dy*distCauda));\n\
  tartarugaCtx.lineTo(x+dxDir, y+dyDir);\n\
  tartarugaCtx.closePath(); \n\
  tartarugaCtx.fill();   \n\
}; \n\
 \n\
Tartaruga.prototype.mova = function(destino) { \n\
  this.cabeca.x = destino.x; \n\
  this.cabeca.y = destino.y; \n\
}; \n\
 \n\
Tartaruga.prototype.centralize = function() { \n\
  this.cabeca.x = larguraCanvas / 2; \n\
  this.cabeca.y = alturaCanvas / 2; \n\
  this.angulo = 90; \n\
  this.desenheSe(); \n\
}; \n\
 \n\
Tartaruga.prototype.desenheQuadro = function(inicio, numeroQuadro, fragmentos, dx, dy) { \n\
  if (this.canetaAtiva) { \n\
    desenhoCtx.beginPath(); \n\
    desenhoCtx.moveTo(inicio.x + (numeroQuadro / fragmentos) * dx, \n\
                      inicio.y + (numeroQuadro / fragmentos) * dy); \n\
    desenhoCtx.lineTo(Math.round(inicio.x + ((numeroQuadro + 1) / fragmentos) * dx), \n\
                      Math.round(inicio.y + ((numeroQuadro + 1) / fragmentos) * dy)); \n\
    desenhoCtx.stroke();     \n\
  } \n\
   \n\
  if (this.visivel) { \n\
    this.apague(); \n\
  } \n\
   \n\
  this.mova( \n\
    new Ponto(inicio.x + ((numeroQuadro + 1) / fragmentos) * dx, \n\
              inicio.y + ((numeroQuadro + 1) / fragmentos) * dy)); \n\
   \n\
  if (this.visivel) { \n\
    this.desenheSe(); \n\
  } \n\
}; \n\
 \n\
Tartaruga.prototype.movaEDesenhe = function(destino) { \n\
   \n\
  var inicio = new Ponto(this.cabeca.x, this.cabeca.y); \n\
  var destino = new Ponto(destino.x, destino.y); \n\
  this.ocupado = true; \n\
  anime(this, inicio, destino, this.desenheQuadro); \n\
}; \n\
 \n\
function dist(a, b) { \n\
  var dx = b.x - a.x; \n\
  var dy = b.y - a.y; \n\
  return Math.sqrt(dx * dx + dy * dy); \n\
} \n\
 \n\
function anime(objeto, inicio, fim, funcaoDesenho, fragmentos, intervalo) { \n\
  fragmentos = fragmentos || Math.ceil(dist(inicio, fim) / opcoesAnimacao.tamanhoFragmento); \n\
  intervalo = intervalo || opcoesAnimacao.intervalo; \n\
 \n\
  var dx = fim.x - inicio.x; \n\
  var dy = fim.y - inicio.y; \n\
 \n\
  function desenheQuadro(numeroQuadro) { \n\
    setTimeout(function () { \n\
      if (numeroQuadro < fragmentos && objeto.ocupado) { \n\
        funcaoDesenho.call(objeto, inicio, numeroQuadro, fragmentos, dx, dy); \n\
        desenheQuadro(numeroQuadro + 1); \n\
      } else { \n\
        objeto.ocupado = false; \n\
 \n\
        if (objeto.filaComandos.length > 0) { \n\
          objeto.executeComandos(); \n\
        } \n\
      }       \n\
    }, intervalo) \n\
  } \n\
  desenheQuadro(0); \n\
} \n\
 \n\
function radParaGr(r) { \n\
  return 180 * r / Math.PI; \n\
} \n\
 \n\
function grParaRad(d) { \n\
  return Math.PI * d / 180; \n\
} \n\
 \n\
var t = new Tartaruga( \n\
  new Ponto(larguraCanvas / 2, alturaCanvas / 2), 90); \n\
 \n\
t.desenheSe(); \n\
 \n\
function pule(x, y) { \n\
  // t.acumuleComando(function () { \n\
    t.apague(); \n\
    t.mova(new Ponto(x, y)); \n\
    t.desenheSe(); \n\
  if (t.filaComandos.length > 0) { \n\
    t.executeComandos(); \n\
  } \n\
  // }); \n\
} \n\
 \n\
function ande(x, y) { \n\
  t.movaEDesenhe(new Ponto(x, y)); \n\
} \n\
 \n\
function pare() { \n\
  t.pare(); \n\
} \n\
 \n\
function frente(distancia) { \n\
  t.acumuleComando(function () { \n\
    var r = grParaRad(t.getAngulo()); \n\
    var dx = distancia * Math.cos(r); \n\
    var dy = -distancia * Math.sin(r); \n\
     \n\
    ande(t.getX() + dx, t.getY() + dy); \n\
  }); \n\
} \n\
\n\
function teleporte(distancia) { \n\
t.acumuleComando(function () { \n\
  var r = grParaRad(t.getAngulo()); \n\
  var dx = distancia * Math.cos(r); \n\
  var dy = -distancia * Math.sin(r); \n\
  \n\
  pule(t.getX() + dx, t.getY() + dy); \n\
});\n\
} \n\
\n\
 \n\
function tras(distancia) { \n\
  frente(-distancia); \n\
} \n\
 \n\
function fr(distancia) { \n\
  frente(distancia); \n\
} \n\
 \n\
function tr(distancia) { \n\
  tras(distancia); \n\
} \n\
 \n\
function fd(distancia) { \n\
  frente(distancia); \n\
} \n\
\n\
function jump(distancia) { \n\
  teleporte(distancia); \n\
} \n\
 \n\
function vireADireita(angulo) { \n\
  t.acumuleComando(function () { \n\
    t.setAngulo((t.getAngulo() - angulo) % 360); \n\
    t.apague(); \n\
    t.desenheSe(); \n\
  }); \n\
} \n\
 \n\
function vireAEsquerda(angulo) { \n\
  vireADireita(-angulo); \n\
} \n\
 \n\
function vd(angulo) { \n\
  vireADireita(angulo); \n\
} \n\
 \n\
function ve(angulo) { \n\
  vireAEsquerda(angulo); \n\
} \n\
 \n\
function rt(angulo) { \n\
  vireADireita(angulo); \n\
} \n\
 \n\
function lt(angulo) { \n\
  vireAEsquerda(angulo); \n\
} \n\
 \n\
function forward(distancia) { \n\
  frente(distancia); \n\
} \n\
 \n\
function turnRight(angulo) { \n\
  vireADireita(angulo); \n\
} \n\
\n\
function penOn() { \n\
t.acumuleComando(function() { \n\
t.ligueCaneta(); \n\
}); \n\
} \n\
 \n\
function penOff() { \n\
t.acumuleComando(function() { \n\
  t.desligueCaneta(); \n\
}); \n\
} \n\
 \n\
 \n\
</script> \n\
";
