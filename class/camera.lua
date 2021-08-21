-- camera, note that the camera object stores the angles and fov etc.
-- but also acts as a screen to draw.
local camera={}
camera.__index = camera


-- new tri
function camera.new( name, width, height, FOV )
    -- get width/height or defualt width/height
    width = width   or floor( g.getWidth()/resolution )
    height = height or floor( g.getHeight()/resolution)
    
    FOV = FOV or 90
    local r = 1/tan(FOV*0.5 / 180 * π)
    local far = 1000
    local near= 0.1
    
    return setmetatable(
     {
      
      -- size of the canvas
      width=width,
      height=height,
      screen=g.newCanvas(width,height),
      
      FieldNear=near,
      FieldFar=far,
      FOV=FOV,
      FOVRad=r,
      
      ratio=width/height,
      projectionMath={
       vector.new("CameraProjection", (width/height)*r, nil, nil,                    nil),
       vector.new("CameraProjection", nil,              r,   nil,                    nil),
       vector.new("CameraProjection", nil,              nil, far/(far-near),         1  ),
       vector.new("CameraProjection", nil,              nil, (-far*near)/(far-near), 0  )
      },
      -- remember to add camera angles like yaw, pitch, etc or whatever the
      -- naming will be
      
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


-- draw the camera to the screen somewhere
function camera.draw(self,x,y)
 
 g.draw(self.screen,x or 0,y or 0)
end


-- the big meat of the program.
-- maybe collapse this into it's own file/files/folder I'm not sure.. but probably
function camera.render(self)
 
 local c=g.getCanvas()
 g.setCanvas(self.screen)
  g.clear(1,1,1)
  
  
  g.setColor(0,0,0)
  
  for i=1,#world.objects do
   
   
   local meshToDraw = world.objects[i]
   
   
   for i=1,#meshToDraw.tris do
    local tri = meshToDraw.tris[i]
    local p=tri.points
    
    -- deep copy the points so you don't edit them
    local t={}
    for i,v in ipairs(p) do
     t[i]={
      multiplyMatrix=vector.multiplyMatrix
     }
     for k,v in pairs(v) do
      t[i][k]=v
     end
    end
    p=t
    
    
    -- temporary movement test
    local t=time/30
    for i=1,3 do
     
     
     -- move these somewhere else!
     local rotatations={
      -- x
      {
       vector.new("rotation",1),
       vector.new("rotation",0,cos(t/2),sin(t/2)),
       vector.new("rotation",0,-sin(t/2)),
       vector.new("rotation",0,0,0,1)
      },
      -- z
      {
       vector.new("rotation",cos(t), sin(t),0,0 ),
       vector.new("rotation",-sin(t),cos(t),0,0 ),
       vector.new("rotation",0,      0,     1,0 ),
       vector.new("rotation",0,      0,     0,1 )
      }
     }
     --[[
     p[i].x= p[i]:multiplyMatrix(rotatations[1]).x
     p[i].y= p[i]:multiplyMatrix(rotatations[1]).y
     p[i].z= p[i]:multiplyMatrix(rotatations[1]).z
     
     p[i].x= p[i]:multiplyMatrix(rotatations[2]).x
     p[i].y= p[i]:multiplyMatrix(rotatations[2]).y
     p[i].z= p[i]:multiplyMatrix(rotatations[2]).z
     --]]
    end
    
    for i=1,3 do
     p[i].x = p[i].x + sin(t)
     p[i].y = p[i].y + cos(t)
     p[i].z = p[i].z + 3 + sin(t)
    end
    
    -- get perspective
    local cords={
     p[1]:multiplyMatrix(self.projectionMath),
     p[2]:multiplyMatrix(self.projectionMath),
     p[3]:multiplyMatrix(self.projectionMath)
    }
    
    for i=1,3 do
     cords[i].x = (cords[i].x+ 1) * 0.5 * self.width  
     cords[i].y = (cords[i].y+ 1) * 0.5 * self.height
    end
    
    
    g.line( cords[1].x,cords[1].y, cords[2].x,cords[2].y )
    g.line( cords[2].x,cords[2].y, cords[3].x,cords[3].y )
    g.line( cords[3].x,cords[3].y, cords[1].x,cords[1].y )
    
   end
   
   
  end
  
  g.setColor(1,1,1)
  
 g.setCanvas(c)
 
end



return camera