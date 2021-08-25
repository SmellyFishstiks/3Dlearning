
-- 3D learning with love
-- by Smelly


local wx,wy = love.window.getDesktopDimensions()
local w,h = love.graphics.getDimensions()
love.window.setMode(w, h, {x = wx/2 - (size.x*resolution.x)/2, y= 40} )


function love.load()
 
 -- set defualt things here, like screen and shortcuts etc.
 g=love.graphics
 m=math
 
 floor = m.floor
 ceil = m.ceil
 abs = m.abs
 min = m.min
 max = m.max
 tan = m.tan
 sin = m.sin
 cos = m.cos
 π = m.pi
 
 
 g.setDefaultFilter("nearest","nearest")
 g.setLineStyle("rough")
 g.setLineWidth(2)
 
 --g.setFontSize(2)
 g.setFont(love.graphics.newFont("arial.ttf",80,"mono"))
 
 screen = g.newCanvas( ceil(g.getWidth()/resolution.x), ceil(g.getHeight()/resolution.y) )
 
 -- time
 time=0
 
 
 -- reqiure files here.
 -- (make this cleaner maybe later.)
 
 vector = require("class/vector")
 vector.projection = require("class/vectorprojection")
 
 tri = require("class/tri")
 mesh = require("class/mesh")
 world = require("class/world")
 
 camera = require("class/camera")
 camera.render = require("code/render")
 
 debugScreen = require("class/debug")
 
 require("code/file/new")
 require("code/file/read")
 require("code/file/shape")
 
 
 -- initalize testing
 require("code/playground")
 
 
 outlineShader = love.graphics.newShader( love.filesystem.newFileData("outline.glsl") )
 
 outlineShader:send("col",{0,0,0,1})
 outlineShader:send("scale",{ 1/(testCamera.width*resolution.x), 1/(testCamera.height*resolution.y) })
 outlineShader:send("thicness",2)
end

function love.update(dt)
 time=time+1
 
 -- wip, but to show implimentation
 movementTest()
 
 
 -- render screens
 testCamera:render()
 
 
 
 local debugInfos={ "FPS: "..floor(dt*100) .."/".. love.timer.getFPS() }
 testDebug:update(debugInfos)
 testDebug:renderTo(testCamera.screen)
 
end



function love.draw()
 -- draw data to the screen canvas here
 g.setCanvas(screen)
  g.clear(1,1,1)
  
  -- insert drawing here
  g.setShader(outlineShader)
  testCamera:draw()
  
  
  
  g.setShader()
  
 g.setCanvas()
 
 
 -- draw canvas data to screen
 g.scale(resolution.x,resolution.y)
  g.draw(screen)
 g.origin()
 
end
