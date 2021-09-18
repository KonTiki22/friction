require("vector")
require("mover")
require("rectangle")

function love.load()
   width = love.graphics.getWidth()
   height = love.graphics.getHeight()
   love.graphics.setBackgroundColor(128/255, 128/255, 128/255)

   location = Vector:create(width/2, height/2)
   velocity = Vector:create(0,0)
   rectLoc1 = Vector:create(100,10)
   rectLoc2 = Vector:create(500,10)
   color1 = {255/255, 255/255,110/255,0.5}
   color2 = {255/255, 0, 0,0.5}
   rect1 = Rectangle:create(rectLoc1, 200, 300, color1, -0.05)
   rect2 = Rectangle:create(rectLoc2, 200, 300, color2, 0.05)
   mover=Mover:create(location, velocity, 1, 20)
   wmover = Mover:create (location, velocity, 5, 60)
   wmover.size = 30

    wind = Vector:create(0.01, 0)
    isWind=false
    gravity = Vector:create(0, 0.01)
    isGravity = false
    floating = Vector:create(0, -0.02)
    isFloating=false
    
end

function love.draw()
    mover:draw()
    wmover:draw()
    rect1:draw()
    rect2:draw()

    love.graphics.print(tostring(wmover.velocity), wmover.location.x+20, wmover.location.y)

    love.graphics.print(tostring(mover.velocity), mover.location.x+20, mover.location.y)
    love.graphics.print("w:" .. tostring(isWind) .." g: " .. tostring(isGravity) .. " f: " ..tostring(isFloating))
end

function love.update()
    mover:applyForce(gravity)
    mover:applyForce(wind)
    mover:applyForce(floating)
    wmover:applyForce(gravity)
    wmover:applyForce(wind)
    wmover:applyForce(floating)
    rect1:checkCross(mover)
    rect2:checkCross(mover)
    rect1:checkCross(wmover)
    rect2:checkCross(wmover)

--[[    friction = (mover.velocity *  -1):norm()
    if friction then
        friction:mul(0.005)
        mover:applyForce(friction)
        wmover:applyForce(friction)
    end]]--
    mover:update()
    mover:checkBoundaries()
    wmover:update()
    wmover:checkBoundaries()
    --[[
    if isGravity then 
        mover:applyForce(gravity)
    end
    if isWind then 
        mover:applyForce(wind)
    end
    if isFloating then 
        mover:applyForce(floating)
    end
    mover:update()
    mover:checkBoundaries()

    if isGravity then 
        wmover:applyForce(gravity)
    end
    if isWind then 
        wmover:applyForce(wind)
    end
    if isFloating then 
        wmover:applyForce(floating)
    end
    wmover:update()
    wmover:checkBoundaries()]]--
end

function love.keypressed(key)
    if key == 'g' then
        isGravity=not isGravity
    end

    if key == 'f' then
        isFloating = not isFloating
    end
    if key=='w' then
        isWind= not isWind
        if isWind then
            wind = wind*-1
        end
    end
end
