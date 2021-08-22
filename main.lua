
-- 3D learning with love
-- by Smelly




function love.load()
 
 
 -- set defualt things here, like screen and shortcuts etc.
 g=love.graphics
 m=math
 
 floor = m.floor
 ceil = m.ceil
 abs = m.abs
function sign(n)
 if n<0 then
  return -1
 end
 
 return 1
end
 tan = m.tan
 sin = m.sin
 cos = m.cos
 π = m.pi
 
 g.setDefaultFilter("nearest","nearest")
 g.setLineStyle("rough")
 g.setLineWidth(2)
 
 screen = g.newCanvas( ceil(g.getWidth()/resolution.x), ceil(g.getHeight()/resolution.y) )
 
 -- time
 time=0
 
 -- reqiure files here.
 -- (make this cleaner maybe later.)
 
 vector = require("class/vector")
 tri = require("class/tri")
 mesh = require("class/mesh")
 world = require("class/world")
 camera = require("class/camera")
 
 
 require("code/file/new")
 require("code/file/read")
 require("code/file/shape")
 
 
 require("code/transformations")
 
 -- initalize testing
 require("code/playground")
 
 
 outlineShader = love.graphics.newShader( love.filesystem.newFileData("outline.glsl") )
 
 outlineShader:send("col",{0,0,0,1})
 outlineShader:send("scale",{1/testCamera.width,1/testCamera.height})
 outlineShader:send("thicness",1)
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
  --g.clear(0.332, 0.871, 0.496)
  g.clear(1,1,1)
  
  -- insert drawing here
  love.graphics.setShader(outlineShader)
  testCamera:draw()
  love.graphics.setShader()
  
 g.setCanvas()
 
 
 -- draw canvas data to screen
 g.scale(resolution.x,resolution.y)
  g.draw(screen)
 g.origin()
 
end
