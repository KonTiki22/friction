Rectangle = {}
Rectangle.__index = Rectangle

function Rectangle:create(location, width, height, color, friction)
    local rectangle = {}
    setmetatable(rectangle, Rectangle)
    rectangle.location = location
    rectangle.width = width
    rectangle.height = height
    rectangle.color = color
    rectangle.friction = friction or 0.005
    return rectangle
end

function Rectangle:draw()
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.location.x, self.location.y, self.width, self.height)
    love.graphics.setColor(r,g,b,a)

end


function Rectangle:checkCross(mover)
    if (mover.location.x > self.location.x and mover.location.x < self.location.x + self.width) then
        if (mover.location.y > self.location.y and mover.location.y < self.location.y + self.height) then
            frict = mover.velocity:norm()
            if frict then
                frict:mul(self.friction)
                mover:applyForce(frict)
            end
        end
    end
    
end
