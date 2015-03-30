-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
--Oulta a barra de status desde o começo
display.setStatusBar( display.HiddenStatusBar )
--inicializa o módulo de física
physics =require("physics")
physics.start()physics.setGravity(0,0)
--physics.setDrawMode("hybrid")
 
-- Inicializa variáveis de exibição da imagem de fundo em duas variáveis. Inicializa variáveis de movimento do carro
_W = display.contentWidth; -- Get the width of the screen
_H = display.contentHeight; -- Get the height of the screen

scrollSpeed = 35; -- Define a velocidade do background.
speed=0--define a velocidade com que o carro se move para os lados

movimentox=0;-- oc arro permanece sem ir para os lados, se nenhum botão é apertado
  local scoreText = display.newText( "Gasolina", 250, 90, native.systemFontBold, 32 )
gasolina = 60.00

local function lerp( v0, v1, t )
    return v0 + t * (v1 - v0)
end

local function showScore( target, value, duration, fps )
    if value == 0 then
        return
    end
    newScore = 60
    local passes = duration
    local increment = lerp( 0, value, 1/passes )

    local count = 0
    
	local function updateText()
        if count < passes then
            newScore = newScore - increment
            target.text = string.format( "%07d", newScore )
            count = count + 1
        else
            target.text = string.format( "%07d", value )
            Runtime:removeEventListener( "enterFrame", updateText )
        end
    end

    Runtime:addEventListener( "enterFrame", updateText )
end

local duration = 2000
local fps = 30
showScore( scoreText, gasolina, duration, fps )

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
end


local carroHeroi=display.newImage("carrinho1.png")
carroHeroi.x = 120
carroHeroi.y = 360
carroHeroi.myName="carroHeroi"

--Adiciona física
physics.addBody( carroHeroi, "kinematic", { friction=0, bounce=0 })


-- Adiciona botão esquerdo
 local left = display.newImage ("btn_arrow.jpg")
 left.x = 45; left.y = 475;
 left:scale(0.2,0.2)
 left.rotation = 180;



-- Adiciona botão direito
 local right = display.newImage ("btn_arrow.jpg")
 right.x = 120; right.y = 475;
 right:scale(0.2, 0.2)



 -- Quando botão de left é apertado, carro se move à esquerda
 function left:touch()
 movimentox = speed-3;
  end
 left:addEventListener("touch",left)


-- Quando a seta de right é apertada, carro se move à esquerda.
 
 function right:touch()
 movimentox = speed+3;
 end
 right:addEventListener("touch",right)
 
--Função que move o carro

 local function moveCarro (event)
carroHeroi.x=carroHeroi.x+movimentox
 
end
 
 --- estabelecendo a aparição e movimento de combustível 
 






local createFuel = function()
	fuel = display.newImage( "Fuel.png",math.random(20,_W-20), -25, math.random(8,14)) 
	physics.addBody( fuel, "cinematic",{ density=0, friction=0, bounce=0} )
	fuel:setLinearVelocity(0, scrollSpeed*30)
	fuel.myName="fuel"    return fuel 	
end
timer.performWithDelay( 800, createFuel, 0 )
local createZumbi = function()
	zumbi = display.newImage( "zumbi.png",math.random(20,_W-20), -25, math.random(8,14)) 
	physics.addBody( zumbi, "cinematic",{ density=0, friction=0, bounce=0.5} )
	zumbi:setLinearVelocity(0, scrollSpeed*30)
	zumbi.myName="zumbi"
    return zumbi	
end

timer.performWithDelay( 800, createZumbi, 0 )
  -- e se bater em algum obstaculo? local function onCollision( event )
    if ( event.phase == "began" ) then
        if(event.object1.myName=="carroHeroi" and event.object2.myName=="fuel") then
			event.object2:removeSelf();			newScore=newScore+2
        end
    end end

Runtime:addEventListener( "collision", onCollision )
 --move o carro Runtime:addEventListener("enterFrame", moveCarro) 
 


--pára o jogador quando nenhum botão estiver sendo apertado!
local function stop (event)
 		if event.phase =="ended" then
		 movimentox = 0;
		 end
 end
 Runtime:addEventListener("touch", stop )
  
-- Cria um evento em tempo de execução para mover o background
Runtime:addEventListener( "enterFrame", move )
