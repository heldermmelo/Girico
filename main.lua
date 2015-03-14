-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
--Oulta a barra de status desde o começo
display.setStatusBar( display.HiddenStatusBar )
 
-- Inicializa variáveis de exibição da imagem de fundo em duas variáveis
_W = display.contentWidth; -- Get the width of the screen
_H = display.contentHeight; -- Get the height of the screen
scrollSpeed = 6; -- Set Scroll Speed of background
 
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
-- e mover o fundo de novo.
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
end
 
-- Create a runtime event to move backgrounds
Runtime:addEventListener( "enterFrame", move )