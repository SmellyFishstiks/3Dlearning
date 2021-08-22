

for i=-1,1 do
 cube.new( "Test Cube "..i,i*1.75, 0, 0,  i*2.0944, 0 )
end
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
    
    if love.keyboard.isDown("space") then
    -- [[
    meshToDraw.position.x = meshToDraw.position.x + cos(t)/1500
     p.v = p.v + 0.0075
     p.w = p.w + 0.0075
    --]]
    end
   end
  end
 end
 
end
