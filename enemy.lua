enemy = {}
enemy.timer = 0
enemy.timerLim = math.random(1,2)
enemy.amount = math.random(1,3)
enemy.side = math.random(1,4)
score = 0
function enemy.genereate(dt)
	enemy.timer = enemy.timer + dt
		if enemy.timer > enemy.timerLim then
		-- Spawn 
			for i=1, enemy.amount do
			if enemy.side == 1 then -- Top
				enemy.spawn(screenWidth / 2 - 250,-50)
				end
				if enemy.side == 2 then
				enemy.spawn(screenWidth / 2 + 250,-50)
			end
			if enemy.side == 3 then
				enemy.spawn(screenWidth /2 + math.random(500,650),-50)
			end	
				if enemy.side == 4 then
				enemy.spawn(screenWidth/2 - math.random(500,650),-50)
			end	
			enemy.side = math.random(1,4)
			end

		enemy.amount = math.random(1,3)
		enemy.timerLim = 1
		enemy.timer = 0
		end
end


--- Propriedades
enemy.width = 80
enemy.height = 40
enemy.speed = 3500
enemy.friction = 7.50
enemy.img = love.graphics.newImage("images/enemy.png")
--- Tabela de spawn
function enemy.spawn(x,y)
	table.insert (enemy, {x = x , y = y, xvel = 0,yvel = 0 , width = enemy.width,height = enemy.height})

end
	-- Inserir inimigo
function enemy.draw()
	for i,v in ipairs(enemy) do 
		love.graphics.draw(enemy.img,v.x,v.y)
		end
	end
	
	-- Fisica
function enemy.physics(dt)
	for i,v in ipairs(enemy) do
		if player.x + player.width > v.x and player.x < v.x + v.width and player.y + player.height > v.y and player.y < v.y + v.height then
			gamestate = "menu"
		end
		v.x = v.x + v.xvel * dt
		v.y = v.y + v.yvel * dt
		v.xvel = v.xvel * (1 - math.min(dt*enemy.friction, 1)) 
		v.yvel = v.yvel * (1 - math.min(dt*enemy.friction, 1)) 
	end
end
	-- IA
	function enemy.IA(dt)
		for i,v in ipairs(enemy) do
			-- X
			if player.x + player.width / 2 < v.x + v.width / 2 then
				if v.xvel > -enemy.speed then
					v.xvel = v.xvel - enemy.speed *dt
					end
				end
			if player.x + player.width / 2 > v.x + v.width / 2 then
				if v.xvel < enemy.speed then
					v.xvel =  v.xvel + enemy.speed * dt
					end
				end
			-- Y
			if player.y + player.height / 2 < v.y + v.height / 2 then
				if v.yvel > -enemy.speed then
					v.yvel =  v.yvel - enemy.speed *dt
					end
				end
			if player.y + player.height / 2 > v.y + v.height / 2 then
				if v.yvel < enemy.speed then
					v.yvel = v.yvel + enemy.speed *dt
					end
				end
				
	end
end

-- Colisão

function enemy.bullet_col()
	for i,v in ipairs(enemy) do
		for ia,va in ipairs(bullet) do 
			if va.x + va.width > v.x and
			va.x < v.x + v.width and
			va.y + va.height > v.y and
			va.y < v.y + v.height then
				score = score + 1
				table.remove(enemy, i)
				table.remove(bullet, ia)
			end
end
			end
		end


-- Função de chamada

function DRAW_ENEMY()
	enemy.draw()
end
function UPDATE_ENEMY(dt)
	enemy.genereate(dt)
	enemy.IA(dt)
	enemy.physics(dt)
	enemy.bullet_col()

end