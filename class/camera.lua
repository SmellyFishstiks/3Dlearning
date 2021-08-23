-- camera, note that the camera object stores the angles and fov etc.
-- but also acts as a screen to draw.
local camera={}
camera.__index = camera


-- new tri
function camera.new( name, width, height, FOV, position )
    -- get width/height or defualt width/height
    width = width   or ceil( g.getWidth()/resolution )
    height = height or ceil( g.getHeight()/resolution)
    
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
      
      ratio=width/height,
      
      position= {
       x=0,
       y=0,
       z=0,
       rx=0,
       ry=0,
       rz=0
      },
      
      
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
 
 local FinalTris={}
 
 
 local c=g.getCanvas()
 g.setCanvas(self.screen)
  g.clear()
  
  
  --[[ matWorld? maybe remove? or wait watch the vid, WIP!!!!!!!!!
  local matRotateX = vector.projection.rotateX(time/1000)
  local matRotateZ = vector.projection.rotateZ(time/2000)
  local matTranslate = vector.projection.translate(0, 0, 6 )
  
  local matWorld = vector.new("'world' matrix vector",1,1,1,1)
  matWorld:multiplyMatrix(matRotateX)
  matWorld:multiplyMatrix(matRotateZ)
  matWorld:multiplyMatrix(matTranslate)
  --]]
  
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
    end
    local p=copy
    
    -- centering
    for i=1,3 do
     p[i].x = p[i].x - 0.5
     p[i].y = p[i].y - 0.5
    end
    
    
    --[[ world offset? maybe remove? or wait watch the vid, WIP!!!!!!!!!
     for i=1,3 do
      
     end
    --]]
    
    
    -- [[ rotation
    for i=1,3 do
     
     if meshToDraw.position.rx~=0 then
      local triRotatedX = p[i]:multiplyMatrix( vector.projection.rotateX(meshToDraw.position.rx) )
      p[i].x = triRotatedX.x
      p[i].y = triRotatedX.y
      p[i].z = triRotatedX.z
     end
     
     
     if meshToDraw.position.ry~=0 then
      local triRotatedY = p[i]:multiplyMatrix( vector.projection.rotateY(meshToDraw.position.ry) )
      
      p[i].x = triRotatedY.x
      p[i].y = triRotatedY.y
      p[i].z = triRotatedY.z
     end
     
     
     if meshToDraw.position.rz~=0 then
      local triRotatedZ = p[i]:multiplyMatrix( vector.projection.rotateZ(meshToDraw.position.rz) )
      
      p[i].x = triRotatedZ.x
      p[i].y = triRotatedZ.y
      p[i].z = triRotatedZ.z
     end
    end
    --]]
    
    -- apply object offset
    for i,v in ipairs(tri.points) do
     for k,v in pairs(v) do
      
      if k~="name" and k~="w" then
       p[i][k]=p[i][k]+meshToDraw.position[k]
      end
      
     end
    end
    
    
    -- decide if this tri should be drawn or not
    
    -- get normals
    local line1,line2 = vector.new("line1", p[2].x-p[1].x, p[2].y-p[1].y, p[2].z-p[1].z ),
                        vector.new("line2", p[3].x-p[1].x, p[3].y-p[1].y, p[3].z-p[1].z )
    local normal=vector.new("normal",
                            line1.y * line2.z - line1.z * line2.y,
                            line1.z * line2.x - line1.x * line2.z,
                            line1.x * line2.y - line1.y * line2.x)
    local l = (normal.x^2 + normal.y^2 + normal.z^2)^0.5
    for k,v in pairs(normal) do
     if k~="name" then
      normal[k]=v/l
     end
    end
    
    
    -- if it's not obscured draw it and such
    --if normal.z<=0 then
    if normal.x * p[1].x - self.position.x +
       normal.y * p[1].y - self.position.y +
       normal.z * p[1].z - self.position.z <0 or tri.flags.doubleSided then
     
     
     -- get perspective
     local cords={
      p[1]:multiplyMatrix( vector.projection.CameraProjection(self) ),
      p[2]:multiplyMatrix( vector.projection.CameraProjection(self) ),
      p[3]:multiplyMatrix( vector.projection.CameraProjection(self) ),
     }
     
     -- more centering
     for i=1,3 do
      cords[i].x = (cords[i].x+ 1) * 0.5 * self.width  
      cords[i].y = (cords[i].y+ 1) * 0.5 * self.height
     end
     
     
     -- take these coordinates to draw at and just dump them for the final part.
     FinalTris[#FinalTris+1]={cords,meshToDraw,normal,tri.flags}
     
     
    end
    
   end
   
   
  end
  
  
  
  
  
  
  -- sort it out
  while true do
   
   flag=true
   
   for i=1,#FinalTris-1 do
    local z1=FinalTris[i][1][1].z   + FinalTris[i][2].position.z
    local z2=FinalTris[i+1][1][1].z + FinalTris[i+1][2].position.z
    
    if z1 < z2 then
     local dummy=FinalTris[i]
     FinalTris[i]=FinalTris[i+1]
     FinalTris[i+1]=dummy
     flag=false
    end
    
    
    if i==#FinalTris-1 and flag then break end 
   end
   if flag then break end
  end
  
  
  
  
  
  
  -- draw it out
  for i=1,#FinalTris do
   local cords=FinalTris[i][1]
   local normal=FinalTris[i][3]
   local flags=FinalTris[i][4]
   
   -- get lighting for faces
   -- maybe replace lightDirc later.
   local lightDirc = vector.new("light", 0,-3,-1)
   
   
   local l = (lightDirc.x^2+lightDirc.y^2+lightDirc.z^2)^0.5
   lightDirc:divide(l)
   
   local lightDotProduct = vector.dotProduct(lightDirc,normal)
   local lightDetail=12 --3
   
   
   -- grab color and light info
   local red,green,blue = flags.color[1], flags.color[2], flags.color[3]
   local l=floor(lightDotProduct*lightDetail + 0.5)/lightDetail-1
   
   
   --[[ drawpoints
   g.setColor( red+l, green+l, blue+l  )
   for i=1,3 do
    g.circle("fill", cords[i].x,cords[i].y,3)
   end
   --]]
   
   
   --[[ drawlines
   local y=1 if -l<=0.5 then y=0 end
   g.setColor(y,y,y)
   for i=1,3 do
    g.line( cords[i].x,cords[i].y, cords[i%3+1].x,cords[i%3+1].y )
   end
   --]]
   
   -- [[ polygon fills
   g.setColor( red+l, green+l, blue+l  )
   
   g.polygon("fill", cords[1].x,cords[1].y, cords[2].x,cords[2].y, cords[3].x,cords[3].y)
   --]]
   
   
   
  end
  g.setColor(1,1,1)
 g.setCanvas(c)
 
end



return camera