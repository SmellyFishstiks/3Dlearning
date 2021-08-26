-- seperate file for the more spesfic vector math to the rendering,
-- felt vector.lua was getting too clunky

local projection = {}



-- rotate in the X direction
function projection.rotateX(angle)
 return {
    vector.new("rotation",cos(angle),  0, sin(angle), 0, 0 ),
    vector.new("rotation",0,           1, 0,          0, 0 ),
    vector.new("rotation",-sin(angle), 0, cos(angle), 0, 0 ),
    vector.new("rotation",0,           0,             1, 0 )
 }
end


-- rotate in the Y direction
function projection.rotateY(angle)
 return {
    vector.new("rotation",1, 0,           0,         0, 0 ),
    vector.new("rotation",0, cos(angle),  sin(angle),0, 0 ),
    vector.new("rotation",0, -sin(angle), cos(angle),0, 0 ),
    vector.new("rotation",0, 0,           0,         1, 0 ),
 }
end


-- rotate in the Z direction
function projection.rotateZ(angle)
 return {
    vector.new("rotation",cos(angle),  sin(angle),0, 0 ),
    vector.new("rotation",-sin(angle), cos(angle),0, 0 ),
    vector.new("rotation",0,           0,         1, 0 ),
    vector.new("rotation",0,           0,         0, 1 ),
 }
end


-- translation matrix
function projection.translate(x,y,z)
 return {
   vector.new(1,0,0,0),
   vector.new(0,1,0,0),
   vector.new(0,0,1,0),
   vector.new(x,y,z,1)
 }
end


-- maybe the most important function in the whole program.
-- takes the camera's properties and projects 3D objects on to a 2D plane.
function projection.CameraProjection(camera)
 return {
   vector.new("CameraProjection", camera.ratio*1/tan(camera.FOV*0.5 / 180 * π),                 nil,                             nil,                                                nil),
   vector.new("CameraProjection", nil,                                                          1/tan(camera.FOV*0.5 / 180 * π), nil,                                                nil),
   vector.new("CameraProjection", nil,                                                          nil,                             camera.far/(camera.far-camera.near),                1  ),
   vector.new("CameraProjection", nil,                                                          nil,                             (-camera.far*camera.near)/(camera.far-camera.near), 0  )
 }
end


-- find offset of a postion from the camera
function projection.PointAt(pos, target, up)
 
 -- get forward direction vector
 local newForward = vector.new()
 local result = vector.subtract(target, pos)
 newForward.x, newForward.y, newForward.z = result.x, result.y, result.z
 newForward = newForward:noramlize()
 
 
 newForward.multiply=vector.multiply
 -- get up direction vector
 local a = newForward:multiply( vector.dotProduct(up, newForward) )
 local newUp = vector.subtract(up, a)
 
 -- wip
 newUp.noramlize = vector.noramlize
 newUp.length = vector.length
 newUp.divide = vector.divide
 
 newUp:noramlize()
 
 -- get new right direction vector
 local newRight = vector.crossProduct(newUp,newForward)
 
 -- return matrix
 return {
  vector.new("pointAt", newRight.x,   newRight.y,   newRight.z,   0 ),
  vector.new("pointAt", newUp.x,      newUp.y,      newUp.z,      0 ),
  vector.new("pointAt", newForward.x, newForward.y, newForward.z, 0 ),
  vector.new("pointAt", pos.x, pos.y, pos.z, 1 )
 }
 
end


function projection.QuickInverse(matrix)
 return {
  vector.new( "inversed"..matrix[1].name, matrix[1].x, matrix[2].x, matrix[3].x, 0 ),
  vector.new( "inversed"..matrix[2].name, matrix[1].y, matrix[2].y, matrix[3].y, 0 ),
  vector.new( "inversed"..matrix[3].name, matrix[1].z, matrix[2].z, matrix[3].z, 0 ),
  vector.new( "inversed"..matrix[4].name,
  -(matrix[4].x * matrix[1].x + matrix[4].y * matrix[2].x + matrix[4].z * matrix[3].x ),
  -(matrix[4].x * matrix[1].y + matrix[4].y * matrix[2].y + matrix[4].z * matrix[3].y ),
  -(matrix[4].x * matrix[1].z + matrix[4].y * matrix[2].z + matrix[4].z * matrix[3].z ),
  1)
 }
end



return projection