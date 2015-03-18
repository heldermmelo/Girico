-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
--Oulta a barra de status desde o começo
display.setStatusBar( display.HiddenStatusBar )
--inicializa o módulo de física
--physics =require("physics")

--physics.start()
--physics.setDrawMode("hybrid")
 
-- Inicializa variáveis de exibição da imagem de fundo em duas variáveis. Inicializa variáveis de movimento do carro
_W = display.contentWidth; -- Get the width of the screen
_H = display.contentHeight; -- Get the height of the screen

scrollSpeed = 6; -- Set Scroll Speed of background
speed=0
movimentox=0;
 
-- Adiciona primeiro background!
local bg1 = display.newImageRect("estradaImagem.png", 320, 480)
bg1.anchorX=0.0;
bg1.anchorY=0.0;
 
-- Adiciona segundo background
local bg2 = display.newImageRect("estradaImagem.png", 320, 480)
bg2.anchorX=0.0;
bg2.anchorY=bg1.anchorY*2;
 
-- Adiciona terceiro background
local bg3 = display.newImageRect("estradaImagem.png", 320, 480)
bg3.anchorX=0.0;
bg3.anchorY=bg1.anchorY*3;

-- Adiciona quarto background
local bg4 = display.newImageRect("estradaImagem.png", 320, 480)
bg4.anchorX=0.0;
bg4.anchorY=bg1.anchorY*4;
 
local function move(event)
 
-- move fundo para baixo, à velocidade da variável "scrollSpeed"
bg1.y = bg1.y + scrollSpeed
bg2.y = bg2.y + scrollSpeed
bg3.y = bg3.y + scrollSpeed
bg4.y = bg4.y + scrollSpeed
 
-- Estabelece listeners para perceber quando a imagem vai acabar
-- e mover o background para o começo da tela.
if (bg1.y + bg1.contentHeight) >480*4 then
bg1:translate( 0, -480 )
end
if (bg2.y +  bg2.contentHeight) > 480*3 then
bg2:translate( 0, -480)
end
if (bg3.y +  bg3.contentHeight) > 480*2 then
bg3:translate( 0, -480)
end
if (bg4.y +  bg4.contentHeight) > 480 then
bg4:translate( 0, -480)
end
local carroHeroi=display.newImageRect("carrinho.png", 160,240)
--physics.addBody( carroHeroi, "static", { friction=0, bounce=0 })
-- Adiciona botão esquerdo
 local left = display.newImage ("btn_arrow.jpg")
 left.x = 45; left.y = 475;
 left:scale(0.2,0.2)
 left.rotation = 180;
-- Adiciona botão direito
 local right = display.newImage ("btn_arrow.jpg")
 right.x = 120; right.y = 475;
 right:scale(0.2, 0.2)
 -- When left arrow is touched, move character left
 function left:touch()
 movimentox = speed-0.2;
 
 end
 left:addEventListener("touch",left)
-- When right arrow is touched, move character right
 function right:touch()
 movimentox = speed+0.2;
 end
 right:addEventListener("touch",right)
 
 -- Move carro à direita
 local function moveCarro (event)
 carroHeroi:translate( (speed+movimentox),0);

 end
  Runtime:addEventListener("enterFrame", moveCarro)
 
 

end
--para o jogador quando nenhum botão estiver sendo apertado!
local function stop (event)
 if event.phase =="ended" then
 movimentox = 0;
 end
 end
 Runtime:addEventListener("touch", stop )
  
-- Create a runtime event to move backgrounds
Runtime:addEventListener( "enterFrame", move )
