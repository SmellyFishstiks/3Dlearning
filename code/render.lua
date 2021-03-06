-- the big meat of the program.
-- maybe collapse this into it's own file/files/folder I'm not sure.. but probably
return function(self)
 
 local FinalTris={}
 
 
 local c=g.getCanvas()
 g.setCanvas(self.screen)
  g.clear()
  
  
  
  -- for all things in world do
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
    
    
    
    
    -- insert the matrix draw stuff here
    --local worldMatrix = {vector.new(),vector.new(),vector.new(),vector.new()}
    --worldMatrix = 
    --error("inesert the stuff here with the translated and rotations.. you could do it really with just the current data! but ya this is rediculous we need to rewatch ep3 more and focus on that. just hammer through and don't worry about following too close and we'll get it! we got this.")
    
    
    -- [[ camera stuff
    local upVec = vector.new("up", 0,1,0)
    local vTarget = vector.new("target",0,0,1)--vector.add( self.position, self.direction )
    local cameraMatrixRotation = vector.projection.rotateY(self.yaw)
    error("!\nwork on the camera stuff more, was ~ little less than 3min into video 3.\nreally tired and it sometimes feels like it's no proogress but we're getting there.. slowly.")
    self.direction = vector.multiplyMatrix(cameraMatrixRotation,vTarget)
   
    local cameraMatrix = vector.projection.PointAt(self.position, vTarget, upVec)
    local viewMatrix = vector.projection.QuickInverse(cameraMatrix)
    
    --]]
    
    

    -- [[ rotation for each mesh
    for i=1,3 do
      p[i]:multiplyMatrix( vector.projection.rotateX(meshToDraw.position.rx) )
      p[i]:multiplyMatrix( vector.projection.rotateY(meshToDraw.position.ry) )
      p[i]:multiplyMatrix( vector.projection.rotateZ(meshToDraw.position.rz) )
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
    
    
     for i=1,3 do
      p[i] = p[i]:multiplyMatrix( viewMatrix )
     end
    
    -- if it's not obscured draw it and such
    if normal.x * p[1].x +
       normal.y * p[1].y +
       normal.z * p[1].z <0 or tri.flags.doubleSided then
     
     
     --[[ convert world space to screen space
     for i=1,3 do
      p[i] = p[i]:multiplyMatrix( viewMatrix )
     end
     --]]
     
     -- get perspective
     -- [[
     local cords={
      p[1]:multiplyMatrix( vector.projection.CameraProjection(self) ),
      p[2]:multiplyMatrix( vector.projection.CameraProjection(self) ),
      p[3]:multiplyMatrix( vector.projection.CameraProjection(self) ),
     }
     --]]
     
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
   
   -- wip sorting stuff, once we have more complex shapes to test look at this further and make it work better.
   for i=1,#FinalTris-1 do
    local triCords1, triCords2 = FinalTris[i][1], FinalTris[i+1][1]
    local z1=(triCords1[1].z+--*FinalTris[i][2].position.z +
              triCords1[2].z+--*FinalTris[i][2].position.z +
              triCords1[3].z)--*FinalTris[i][2].position.z)/3
    local z2=(triCords2[1].z+--*FinalTris[i+1][2].position.z +
              triCords2[2].z+--*FinalTris[i+1][2].position.z +
              triCords2[3].z)--*FinalTris[i+1][2].position.z)/3
    
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
   local ogMesh=FinalTris[i][2]
   local normal=FinalTris[i][3]
   local flags=FinalTris[i][4]
   
   -- get lighting for faces
   -- maybe replace lightDirc later.
   local lightDirc = vector.new("light", -1,-3,-1)
   
   
   local l = (lightDirc.x^2+lightDirc.y^2+lightDirc.z^2)^0.5
   lightDirc = lightDirc:divide(l)
   
   local lightDotProduct = vector.dotProduct(lightDirc,normal)
   if flags.doubleSided then lightDotProduct=abs(lightDotProduct) end
   
   local lightDetail= 12-- 3
   
   -- grab color and light info
   local red,green,blue = flags.color[1], flags.color[2], flags.color[3]
   local l=floor(lightDotProduct*lightDetail + 0.5)/lightDetail-1
   
   
   
   
   
   
   --[[ drawlines
   local y=1 if -l<=0.5 then y=0 end
   g.setColor(y,y,y)
   for i=1,3 do
    g.line( cords[i].x,cords[i].y, cords[i%3+1].x,cords[i%3+1].y )
   end
   --]]
   
   --[[ drawpoints
   g.setColor( red+l, green+l, blue+l  )
   for i=1,3 do
    g.circle("fill", cords[i].x,cords[i].y,3)
   end
   --]]
   
   --[[ polygon fills
   g.setColor( red+l, green+l, blue+l  )
   g.polygon("fill", cords[1].x,cords[1].y, cords[2].x,cords[2].y, cords[3].x,cords[3].y)
   --]]
   
   -- [[ mesh
    
    -- get z value
    --[[
    local mz = (cords[1].z+cords[2].z+cords[3].z)/3 + ogMesh.position.z
    local d=mz/2-6 - self.position.z
    ]]
    local d=0
    
    if floor(d)<=#fillPatterns then
     fillPatternShader:send("pattern", fillPatterns[min(max(floor(d),1),#fillPatterns)] )
     g.setColor( red+l, green+l, blue+l  )
     self.triMesh:setVertices({
      {cords[1].x,cords[1].y},
      {cords[2].x,cords[2].y},
      {cords[3].x,cords[3].y}
     })
     
     
     g.setShader(fillPatternShader)
     g.draw(self.triMesh)
     g.setShader()
    end
   --]]
   
   
   
  end
  g.setColor(1,1,1)
 g.setCanvas(c)
 
end

