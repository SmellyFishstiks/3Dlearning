-- camera, note that the camera object stores the angles and fov etc.
-- but also acts as a screen to draw.
local camera={}
camera.__index = camera


-- new tri
function camera.new( name, width, height, FOV )
    -- get width/height or defualt width/height
    width = width   or ceil( g.getWidth()/resolution )
    height = height or ceil( g.getHeight()/resolution)
    
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
      
      -- unlike other transformations this is dependent on the camera.
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


-- draw the camera's screen to somewhere
function camera.draw(self,x,y)
 g.draw(self.screen,x or 0,y or 0)
end


-- the big meat of the program.
-- maybe collapse this into it's own file/files/folder I'm not sure.. but probably
function camera.render(self)
 
 local c=g.getCanvas()
 g.setCanvas(self.screen)
  g.clear()
  
  
  g.setColor(0,0,0)
  
  for i=1,#world.objects do
   
   
   local meshToDraw = world.objects[i]
   
   
   for i=1,#meshToDraw.tris do
    local tri = meshToDraw.tris[i]
    
    -- deep copy the points so you don't edit them
    local copy={}
    for i,v in ipairs(tri.points) do
     copy[i]={
      multiplyMatrix=vector.multiplyMatrix
     }
     for k,v in pairs(v) do
      copy[i][k]=v
     end
     
     -- pass the points the general rotation of the mesh
     copy[i].w = copy[i].w + meshToDraw.position.rx
     copy[i].v = copy[i].v + meshToDraw.position.rz
    end
    local p=copy
    
    -- centering
    for i=1,3 do
     p[i].x = p[i].x - 0.5
     p[i].y = p[i].y - 0.5
    end
    
    --[ [ rotation
    for i=1,3 do
     updateTransformations( p[i].w,p[i].v )
     
     
     local triRotatedX = p[i]:multiplyMatrix( transformationTable.rotatations.x )
     
     if p[i].w~=0 then
      p[i].x = triRotatedX.x
      p[i].y = triRotatedX.y
      p[i].z = triRotatedX.z
     end
     
     
     if p[i].v~=0 then
      local Pdummy={
       x=p[i].x, y=p[i].y, z=p[i].z,
       w=p[i].w, v=p[i].v,
       multiplyMatrix=p[i].multiplyMatrix
      }
      
      local triRotatedZ = Pdummy:multiplyMatrix( transformationTable.rotatations.z )
      
      p[i].x = triRotatedZ.x
      p[i].y = triRotatedZ.y
      p[i].z = triRotatedZ.z
     end
    end
    --]]
    
    -- apply object offset
    for i,v in ipairs(tri.points) do
     for k,v in pairs(v) do
      
      if k~="name" and k~="w" and k~="v" then
       p[i][k]=p[i][k]+meshToDraw.position[k]
      end
      
     end
    end
    
    -- push stuff away from the camera a bit (wip?)
    for i=1,3 do
     p[i].z=p[i].z + 3--1.5
    end
    
   
    -- get perspective
    local cords={
     p[1]:multiplyMatrix(self.projectionMath),
     p[2]:multiplyMatrix(self.projectionMath),
     p[3]:multiplyMatrix(self.projectionMath),
    }
    
    -- more centering
    for i=1,3 do
     cords[i].x = (cords[i].x+ 1) * 0.5 * self.width  
     cords[i].y = (cords[i].y+ 1) * 0.5 * self.height
    end
    
    
    --[[ drawpoints
    for i=1,3 do
     g.circle("fill", cords[i].x,cords[i].y,4)
    end
    --]]
    
    -- [[ drawlines
    for i=1,3 do
     g.line( cords[i].x,cords[i].y, cords[i%3+1].x,cords[i%3+1].y )
    end
    --]]
    
   end
   
   
  end
  
  g.setColor(1,1,1)
  
 g.setCanvas(c)
 
end



return camera