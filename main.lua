
-- 3D learning with love
-- by Smelly







function love.load()
 
 -- reqiure files here.
 -- (make this cleaner maybe later.)
 
 vector = require("class/vector")
 
 
 
 -- initalize testing
 require("code/playground")
 
 
end

function love.update()
 
end


g=love.graphics
g.setDefaultFilter("nearest","nearest")
screen = g.newCanvas( g.getDimensions() )
function love.draw()
 
 g.setCanvas(screen)
  g.clear()
  
  
  
 g.setCanvas()
 
 g.scale(resolution)
 g.draw(screen)
 
end
