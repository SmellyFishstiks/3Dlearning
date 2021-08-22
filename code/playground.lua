
-- [[
for i=-1,1 do
 cube.new( "Rotate Test",i*1.8, 0, 0,  i*2.0944, 0 )
end
--]]

testCamera = camera.new( "test",
 ceil(g.getWidth()/resolution.x),
 ceil(g.getHeight()/resolution.y), 90,
 nil
 
)


function movementTest()
 
 local t=time/80

 for i=1,#world.objects do
  local meshToDraw = world.objects[i]
  for i=1,#meshToDraw.tris do
   local tri = meshToDraw.tris[i]
   for i=1,3 do
    local p=tri.points[i]
    -- [[
    if meshToDraw.name=="Rotate Test's cube mesh" then
     meshToDraw.position.x = meshToDraw.position.x + cos(t)/1500
     p.v = p.v + 0.01
     p.w = p.w + 0.01
    end
    --]]
   end
  end
 end
 
end
