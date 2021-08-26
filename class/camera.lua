-- camera, note that the camera object stores the angles and fov etc.
-- but also acts as a screen to draw.
local camera={}
camera.__index = camera


-- new tri
function camera.new( name, width, height, FOV, position )
    -- get width/height or defualt width/height
    width = width   or ceil( g.getWidth())
    height = height or ceil( g.getHeight())
    
    
    FOV = FOV or 90
    local far = 1000
    local near= 0.1
    
    return setmetatable(
     {
      
      -- size of the canvas
      width=width,
      height=height,
      screen=g.newCanvas(width,height),
      
      near=near,
      far=far,
      FOV=FOV,
      
      ratio=(width/(resolution.master*resolution.ogx^2) )/(height/resolution.master),
      
      position  = vector.new("camera "..name.."'s position vector",  0,0,0),
      yaw = 0,
      direction = vector.new("camera "..name.."'s direction vector", 0,0,1),
      
      triMesh = love.graphics.newMesh({ {0,0}, {0,0}, {0,0} },"fan"),
      
      name=name or "untitled camera"
    },camera
   )
end


-- list a camera's values
function camera.list(self)
 
 print("camera; " .. self.name .. "'s vars:")
 for k,v in pairs(self) do
  print(k,v)
 end
 
end


-- draw the camera's screen to somewhere
function camera.draw(self,x,y)
 g.draw(self.screen,x or 0,y or 0)
end




return camera