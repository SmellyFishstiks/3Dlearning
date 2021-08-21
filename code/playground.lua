

cube.new( "Test Cube1",0, 0, 0,  0, 0 )
cube.new( "Test Cube2",1, -1,4,  0, 0 )
cube.new( "Test Cube3",-1,0, 2,  0, 0 )

testCamera = camera.new( "test",
 ceil(g.getWidth()/resolution),
 ceil(g.getHeight()/resolution), 90 )


function movementTest()
 
 local t=time/40

 for i=1,#world.objects do
  local meshToDraw = world.objects[i]
  for i=1,#meshToDraw.tris do
   local tri = meshToDraw.tris[i]
   for i=1,3 do
    
    local p=tri.points[i]
    -- [[
    for i=1,3 do
     p.x = p.x + cos(t)/100
     p.y = p.y + cos(t/2)/200
     p.v = p.v + 0.01
     p.w = p.w + 0.02
    end
    --]]
   end
  end
 end
 
end