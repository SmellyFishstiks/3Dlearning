-- where I test stuff :I

-- [[
cube.new(   "Test",  0,0,3)
pyramid.new("Test",  1.5,1,3)
plane.new  ("Test", -1.5,2,3)
--]]

--[[ axis test?
plane.new  ("Test", -1,0,2,0,0,1.5708)
plane.new  ("Test", 0,1,2)
--]]

testCamera = camera.new( "test",
 ceil(g.getWidth()/resolution.x),
 ceil(g.getHeight()/resolution.y), 90, nil
)
testDebug = debugScreen.new()


rotTime=0
function movementTest()
 
 
 -- [[ input
 if love.keyboard.isDown("w") then
  testCamera.position.y = testCamera.position.y-2/60
 end
 
 if love.keyboard.isDown("s") then
  testCamera.position.y = testCamera.position.y+2/60
 end
 
 if love.keyboard.isDown("a") then
  testCamera.position.x = testCamera.position.x-2/60
 end
 
 if love.keyboard.isDown("d") then
  testCamera.position.x = testCamera.position.x+2/60
 end
 
 
 if love.keyboard.isDown("x") then
  testCamera.FOV = min( testCamera.FOV + 1 ,179) 
 end
 
 if love.keyboard.isDown("z") then
  testCamera.FOV = max( testCamera.FOV - 1 ,1) 
 end
 --]]
 
 -- rotating
 for i=1,#world.objects do
  local meshToDraw = world.objects[i]
  -- [[
  if love.keyboard.isDown("r") or true then
   rotTime=rotTime+ 1/#world.objects
   
   if rotTime%360<120 then
    meshToDraw.position.rx=meshToDraw.position.rx+ π/60
   elseif rotTime%360<240 then
    meshToDraw.position.ry=meshToDraw.position.ry+ π/60
   else
    meshToDraw.position.rz=meshToDraw.position.rz+ π/60
   end
  end
  --]]
 end
 
end


function love.keypressed(key)
 if key == "escape" then
  love.event.quit()
 end
end


