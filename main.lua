height = love.graphics.getHeight()
width = love.graphics.getWidth()

function love.load()
	Snow = {}
	maxsnow = 0

	ground = { x = 0, y = height - 20 }
end

function love.update(dt)
	for i = 1, maxsnow do
		if #Snow < maxsnow then
			flake = {
				x = math.random(width),
				y = 0,
				size = math.random(2),
				speed = math.random(20, 40),
				dir = math.random(-1, 1)
			}
			table.insert(Snow, flake)
		end
	end

	for i, k in ipairs(Snow) do
		k.y = k.y + k.speed * dt
		k.x = snowFloat(k, dt)
		-- remove snow when it touches the ground
		if k.y >= ground.y and k.x > 0 and k.x < width then
			table.remove(Snow, i)
		end
		-- remove snow from outside the screen
		if k.x < 0 or k.x > width then
			table.remove(Snow, i)
		end
	end
end

function love.draw()
	love.graphics.setBackgroundColor(10/255, 20/255, 30/255) -- transition from previous LOVE2D versions
	love.graphics.setColor(1, 1, 1)

	for _, k in ipairs(Snow) do
		love.graphics.setPointSize(k.size)
		love.graphics.points(k.x, k.y)
	end

	love.graphics.line(ground.x, ground.y, width, ground.y)

	love.graphics.print("Use mousewheel to add/remove snowflakes. There's " .. #Snow .. " snowflakes at the moment", 0, ground.y)
end

function snowFloat(flake, dt)
	local currentdir = flake.dir
	local flakeX = lerp(flake.x, flake.x + currentdir * flake.speed/2, dt)
	
	return flakeX
end

-- add snow
 function love.wheelmoved(x, y) 
    if y > 0 then 
   		maxsnow = maxsnow + 1
   	elseif y < 0 then
     		maxsnow = maxsnow - 1
   	end
end

-- linear interpolation formula
-- (not entirely sure if it actually changes anything in this example but there you go)
function lerp(a, b, t)
    return a + (b - a) * t
end
