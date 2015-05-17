--Oulta a barra de status desde o começo
display.setStatusBar( display.HiddenStatusBar )
--inicializa o módulo de física
physics =require("physics")

physics.start()
physics.setGravity(0,0)
--physics.setDrawMode("hybrid")
 
-- Inicializa variáveis de exibição da imagem de fundo em duas variáveis. Inicializa variáveis de movimento do carro
_W = display.contentWidth; -- Get the width of the screen
_H = display.contentHeight; -- Get the height of the screen
--carrega música
 backgroundMusic = audio.loadStream("04.mp3")
	backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 }  )
scrollSpeed = 35; -- Define a velocidade do background.
speed=0--define a velocidade com que o carro se move para os lados

movimentox=0;-- o carro permanece sem ir para os lados, se nenhum botão é apertado
pontuacao=0
local composer = require ("composer")
composer.gotoScene( "menu" )