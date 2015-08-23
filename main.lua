require "player"
require "bullet"
require "enemy"
require "menu"
function love.load ()
	medium = love.graphics.newFont(45)
	gamestate = "menu"
	love.graphics.newImage("images/background.png")
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
	--- Buttons
	button_spawn(300,200,"Começar","start")
	button_spawn(350,300,"Sair","quit")
	player.load()
end
function love.keypressed(key)
	player.shoot(key)
	end

function love.update(dt)
	if gamestate == "playing" then
	UPDATE_PLAYER(dt)
	UPDATE_BULLET(dt)
	UPDATE_ENEMY(dt)
	end
end
function love.draw()
	if gamestate == "playing" then
	love.graphics.setColor(255,255,255)
	DRAW_PLAYER()
	DRAW_BULLET()
	love.graphics.print("Score: " .. score ,350, 16)
	DRAW_ENEMY()
	end
	if gamestate == "menu" then
		button_draw()
	end
end
function love.mousepressed(x,y)
	if gamestate == "menu" then
	button_click(x,y)
	end
end
