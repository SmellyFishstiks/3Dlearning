-- where I test stuff :I

cube.new( "Test",  0,0,2, 0,0,0)

testCamera = camera.new( "test",
 ceil(g.getWidth()/resolution.x),
 ceil(g.getHeight()/resolution.y), 90, nil
)


function movementTest()
 -- input
 if love.keyboard.isDown("s") then
  testCamera.FOV = min( testCamera.FOV + 1 ,179) 
 end

 if love.keyboard.isDown("w") then
  testCamera.FOV = max( testCamera.FOV - 1 ,1) 
 end
 
 -- manip
 for i=1,#world.objects do
  local meshToDraw = world.objects[i]
  for i=1,#meshToDraw.tris do
   local tri = meshToDraw.tris[i]
   for i=1,3 do
    local p=tri.points[i]
     
     -- [[
     if time%360<120 then
      meshToDraw.position.rx=meshToDraw.position.rx+ (π/60)/36/2
     elseif time%360<240 then
      meshToDraw.position.ry=meshToDraw.position.ry+ (π/60)/36/2
     else
      meshToDraw.position.rz=meshToDraw.position.rz+ (π/60)/36/2
     end
     --]]
     --meshToDraw.position.rz=meshToDraw.position.rz+0.00075
     --meshToDraw.position.y=meshToDraw.position.y+cos(time/40)/2000
    end
    
  end
 end
 
end