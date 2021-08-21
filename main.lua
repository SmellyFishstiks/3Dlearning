
-- 3D learning with love
-- by Smelly




function love.load()
 
 
 -- set defualt things here, like screen and shortcuts etc.
 g=love.graphics
 g.setDefaultFilter("nearest","nearest")
 screen = g.newCanvas( g.getDimensions() )
 
 
 
 -- reqiure files here.
 -- (make this cleaner maybe later.)
 
 vector = require("class/vector")
 tri = require("class/tri")
 mesh = require("class/mesh")
 camera = require("class/camera")
 require("class/shape")
 
 -- initalize testing
 require("code/playground")
 
 
end

function love.update()
 
end



function love.draw()
 
 -- draw data to the screen canvas here
 g.setCanvas(screen)
  g.clear()
  
  -- insert drawing here
  
 g.setCanvas()
 
 
 -- draw canvas data to screen
 g.scale(resolution)
 g.draw(screen)
 
end
