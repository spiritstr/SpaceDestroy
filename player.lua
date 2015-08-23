player={}
function player.load()
	player.width = 50
	player.height = 50
	--player.x = 400
	--player.y = 500
	player.xvel = 0
	player.yvel = 0
	player.friction = 9.5
	player.speed = 2500
	player.img = love.graphics.newImage ("images/player.png")
	player.x=love.graphics.getWidth()/2
	player.y=love.graphics.getHeight()/2 
	-- 	Background
	background =  love.graphics.newImage("images/background.png")
	backgroundY = -600
end

function player.draw()
		love.graphics.draw(background, 0, backgroundY)
		love.graphics.draw(player.img,player.x,player.y)
end 
-- Fisica

function player.physics(dt)
		player.x = player.x + player.xvel * dt
		player.y = player.y + player.yvel * dt
		player.xvel = player.xvel * (1 - math.min(dt*player.friction, 1)) 
		player.yvel = player.yvel * (1 - math.min(dt*player.friction, 1)) 
end

-- Limitação de tela
-- Movimentação
function player.boundary()
	if player.x <0 then
	player.x = 0
		player.xvel = 0
	end
	if player.y <0 then	
	player.y = 0
	player.yvel = 0
	end
	if player.x + player.width > screenWidth then
	player.x =  screenWidth - player.width
	player.xvel = 0
	end
	if player.y + player.height > screenHeight then
		player.y = screenHeight - player.height
		player.yvel = 0
	
	end
end


function player.move(dt)

		-- Eixo X
	if love.keyboard.isDown('right') and player.xvel < player.speed then
	player.xvel = player.xvel + player.speed * dt
end
if love.keyboard.isDown('left') and player.xvel > -player.speed then
	player.xvel = player.xvel - player.speed * dt
end

-- Eixo Y
if love.keyboard.isDown('up') and player.yvel > -player.speed then	
	player.yvel = player.yvel - player.speed * dt
end
if love. keyboard.isDown('down') and player.yvel < player.speed then	
	player.yvel = player.yvel + player.speed * dt
end
	
end
	function player.shoot(key)
	if key == ' ' then
	bullet.spawn(player.x + player.width / 2 - bullet.width / 2 ,player.y - bullet.height,'up')
	end
end
-- Função

	function DRAW_PLAYER()
		player.draw()
	end

	function UPDATE_PLAYER(dt)
		backgroundY = backgroundY + 1
		if backgroundY >= 0 then
			backgroundY = -600
		end
		player.physics(dt)
		player.boundary()
		player.move(dt)
	end