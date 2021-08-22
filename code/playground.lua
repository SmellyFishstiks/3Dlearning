

cube.new( "Test",0, 0, 0,  0, 2 )

testCamera = camera.new( "test",
 ceil(g.getWidth()/resolution.x),
 ceil(g.getHeight()/resolution.y), 90,
 nil
 
)


function movementTest()
 
 local t=time/100

 for i=1,#world.objects do
  local meshToDraw = world.objects[i]
  for i=1,#meshToDraw.tris do
   local tri = meshToDraw.tris[i]
   for i=1,3 do
    local p=tri.points[i]
    p.w=p.w+0.05
   end
  end
 end
 
end
