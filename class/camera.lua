-- camera, note that the camera object stores the angles and fov etc.
-- but also acts as a screen to draw.
local camera={}
camera.__index = camera


-- new tri
function camera.new( name, width, height, FOV )
    width = width or g.getWidth()/resolution
    height = height or g.getHeight()/resolution
    
    return setmetatable(
     {
      
      -- size of the canvas
      width=width,
      height=height,
      screen=g.newCanvas(width,height),
      
      FOV=FOV or 100,
      
      -- remember to add camera angles like yaw, pitch, etc or whatever the
      -- naming will be
      
      name=name or "untitled camera"
    },camera
   )
end


-- list a vector's values
function camera.list(self)
 
 print("camera; " .. self.name .. "'s vars:")
 for k,v in pairs(self) do
  print(k,v)
 end
 
end


function camera.render(self)
 
 g.setCanvas(self.screen)
  g.clear()
  
  
  
 g.setCanvas()
 
end


function camera.draw(self,x,y)
 
 g.draw(self.screen,x or 0,y or 0)
end



return camera