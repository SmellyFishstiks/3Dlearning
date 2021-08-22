
-- 3D learning with love
-- by Smelly




function love.load()
 
 
 -- set defualt things here, like screen and shortcuts etc.
 g=love.graphics
 m=math
 
 floor = m.floor
 ceil = m.ceil
 tan = m.tan
 sin = m.sin
 cos = m.cos
 π = m.pi
 
 g.setDefaultFilter("nearest","nearest")
 g.setLineStyle("rough")
 g.setLineWidth(1)
 
 screen = g.newCanvas( ceil(g.getWidth()/resolution), ceil(g.getHeight()/resolution) )
 
 -- time
 time=0
 
 -- reqiure files here.
 -- (make this cleaner maybe later.)
 
 vector = require("class/vector")
 tri = require("class/tri")
 mesh = require("class/mesh")
 world = require("class/world")
 camera = require("class/camera")
 require("class/shape")
 
 
 require("code/transformations")
 
 -- initalize testing
 require("code/playground")
 

end

function love.update()
 time=time+1
 
 -- wip, but to show implimentation
 movementTest()
 
 testCamera:render()
end



function love.draw()
 
 -- draw data to the screen canvas here
 g.setCanvas(screen)
  g.clear(1,1,1)
  
  -- insert drawing here
  testCamera:draw()
  
 g.setCanvas()
 
 
 -- draw canvas data to screen
 g.scale(resolution,resolution)
  g.draw(screen)
 g.origin()
 
end
