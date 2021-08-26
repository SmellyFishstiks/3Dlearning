-- where I test stuff :I

cube.new(   "Test",  0,0,3)

--[[
for i=2,8 do
 for j=-1,1 do
  cube.new(   "Test",  j*2,0,i*1.1)
 end
end
--]]


--[[
 pyramid.new("Test",  1.5,2,i)
 plane.new  ("Test", -1.5,2,i)
--]]

--[[ axis test?
plane.new  ("Test", -1,0,2,0,0,1.5708)
plane.new  ("Test", 0,1,2)
--]]
testCamera = camera.new( "test")
testDebug = debugScreen.new()


rotTime=0
function movementTest()
 
 
 -- input
 local r=4
 local target="position"
 --[[
 if love.keyboard.isDown("lshift") then
  target="direction"
 end
 --]]
 
 -- [[
 if love.keyboard.isDown("up") then
  testCamera[target].y = testCamera[target].y-r/60
 end
 
 if love.keyboard.isDown("down") then
  testCamera[target].y = testCamera[target].y+r/60
 end
 
 if love.keyboard.isDown("left") then
  testCamera[target].x = testCamera[target].x-r/60
 end
 
 if love.keyboard.isDown("right") then
  testCamera[target].x = testCamera[target].x+r/60
 end
 
 
 
 local forward  = vector.multiply(testCamera.direction, .1)
 
 if love.keyboard.isDown("a") then
  testCamera.yaw = testCamera.yaw -2
 end
 
 if love.keyboard.isDown("d") then
  testCamera.yaw = testCamera.yaw + 2
 end
 
 if love.keyboard.isDown("w") then
 testCamera[target] = vector.add(testCamera[target], forward)
 end
 
 if love.keyboard.isDown("s") then
 testCamera[target] = vector.subtract(testCamera[target], forward)
 end
 
 
 --[[
 if love.keyboard.isDown("x") then
  testCamera[target].z = testCamera[target].z+r/60
  --testCamera.FOV = min( testCamera.FOV + 1 ,179) 
 end
 
 if love.keyboard.isDown("z") then
  testCamera[target].z = testCamera[target].z-r/60
  ---testCamera.FOV = max( testCamera.FOV - 1 ,1) 
 end
 --]]
 
 -- rotating
 for i=1,#world.objects do
  local meshToDraw = world.objects[i]
  
  --[[
  if love.keyboard.isDown("r") then
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
  meshToDraw.position.rz = meshToDraw.position.rz+ π/240
 end
 
end


function love.keypressed(key)
 if key == "escape" then
  love.event.quit()
 end
end


