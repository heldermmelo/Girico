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
pontuacao=28
--[[local Main = {}
local startButtonListeners = {}
local showGameView = {}
local bgScroll = {}
local movePlayer = {}
local createBlocks = {}
local velocidade = {}
local update = {}
local alert = {}

function Main()
  titleBg = display.newImageRect('mainscreen.png', _W, _H)
  titleBg.x = _W2
  titleBg.y = _H2
  
  playBtn = display.newImage('play.png')
  playBtn.x = _W2
  playBtn.y = 120
  titleView = display.newGroup(titleBg, playBtn)  
  startButtonListeners('add')
end

function startButtonListeners(action)
  if(action == 'add') then
    playBtn:addEventListener('tap', showGameView)
  else
    playBtn:removeEventListener('tap', showGameView)
  end
end

function showGameView:tap(e)
  transition.to(titleView, {time = 300, x = -titleView.height, onComplete = function() startButtonListeners('rmv') 
    display.remove(titleView) titleView = nil end})
end--]]
 --Novo Marcador de combustível
score = display.newRect( 320, 360, 20, 300 )
score.anchorY=496
scoreTxt = display.newText( "GAS:", 285,358, "Helvetica", 16 )



local function updateScore()
     print(score.height)  
     score.height = score.height - 5
	   
end

local scoreTimer = timer.performWithDelay(1000, updateScore, 0)

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


local carroHeroi=display.newImage("carrinho.png")
carroHeroi.x = 120
carroHeroi.y = 360
carroHeroi.myName="carroHeroi"

--Adiciona física
physics.addBody( carroHeroi, "kinematic", { friction=0, bounce=0 })


-- Adiciona botão esquerdo
 local left = display.newImage ("btn_arrow.jpg")
 left.x = 45; left.y = 430;
 left:scale(0.4,0.4)
 left.rotation = 180;



-- Adiciona botão direito
 local right = display.newImage ("btn_arrow.jpg")
 right.x = 290; right.y = 430;
 right:scale(0.4, 0.4)



 -- Quando botão de left é apertado, carro se move à esquerda
 function left:touch()
 movimentox = speed-5;
  end
 left:addEventListener("touch",left)


-- Quando a seta de right é apertada, carro se move à esquerda.
 
 function right:touch()
 movimentox = speed+5;
 end
 right:addEventListener("touch",right)
 
--Função que move o carro

 local function moveCarro (event)
carroHeroi.x=carroHeroi.x+movimentox
 
end
 
 --- estabelecendo a aparição e movimento de combustível 
 






local createFuel = function()
	fuel = display.newImage( "Fuel.png",math.random(20,_W-80), -25, math.random(8,14)) 
	physics.addBody( fuel, "cinematic",{ density=0, friction=0, bounce=0} )
	fuel:setLinearVelocity(0, scrollSpeed*15)
	fuel.myName="fuel"
    return fuel 	
end

f = timer.performWithDelay( 1900, createFuel, 0 )
--Cria zumbis
local createZumbi = function(event)
	zumbi = display.newImage( "zumbi.png",math.random(20,_W-80), -25, math.random(8,14)) 
	physics.addBody( zumbi, "cinematic",{ density=2, friction=0, bounce=1} )
	zumbi:setLinearVelocity(0, scrollSpeed*15)
	zumbi.myName="zumbi"
    return zumbi	
end

z = timer.performWithDelay( 800, createZumbi, 0 )
--Cria pobres inocentes 

local createInocente = function(event)
	inocente = display.newImage( "chibi.png",math.random(20,_W-80), -25, math.random(8,14)) 
	physics.addBody( inocente, "cinematic",{ density=2, friction=0, bounce=1} )
	inocente:setLinearVelocity(0, scrollSpeed*15)
	inocente.myName="inocente"
    return inocente	
end

i = timer.performWithDelay( 5000, createInocente, 0 )

 local function onCollision( event )
    if (event.phase == "began" ) then
        if (event.object1.myName=="carroHeroi" and event.object2.myName=="fuel") 
        	then
			event.object2:removeSelf( );
			score.height=score.height+5;
			elseif  (event.object1.myName=="carroHeroi" and event.object2.myName=="zumbi") 
			then 
			pontuacao = pontuacao + 1
			elseif  (event.object1.myName=="carroHeroi" and event.object2.myName=="inocente") 
			then 
			pontuacao = pontuacao -1
        end 
       print(pontuacao)
 end end
   
    				
 
    

Runtime:addEventListener( "collision", onCollision )
 --move o carro
 Runtime:addEventListener("enterFrame", moveCarro) 
 
 
 	


--pára o jogador quando nenhum botão estiver sendo apertado!
local function stop (event)
 		if (event.phase =="ended") then
		 movimentox = 0;
		 end
 end
 Runtime:addEventListener("touch", stop )
  

Runtime:addEventListener( "enterFrame", move )

--encerra o jogo
 
 function gameOvo( )
 	
	if(score.height ==0) 	then gameOvo= display.newText( "GAME OVO, BRODER", display.contentCenterX, display.contentCenterY, "Helvetica", 30) 	scrollSpeed=0
 	gameIsActive = false  
 	physics.pause()
	timer.cancel(z)
	timer.cancel(i)
	timer.cancel(f)
  	audio.stop(backgroundMusicChannel)
	if (pontuacao <=25)
	then
	display.newText("(Mas tu é ruinzinho hein?)", (display.contentCenterX), (display.contentCenterY - 50),"Helvetica", 20)
	elseif (pontuacao >= 25 )
	then
	display.newText("(VOCÊ É O REI DESTA BIROSCA!!!", (display.contentCenterX), (display.contentCenterY - 50),"Helvetica", 20)
	end
 	end	
	
end
		
Runtime:addEventListener("enterFrame", gameOvo)
local options = {
   width = 60,
   height = 20,
   numFrames = 6
}
local spriteSheet = graphics.newImageSheet( "spritesheet.png", options )
