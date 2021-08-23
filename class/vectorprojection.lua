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
   vector.new("CameraProjection", (camera.width/camera.height)*1/tan(camera.FOV*0.5 / 180 * π), nil,                             nil,                                                nil),
   vector.new("CameraProjection", nil,                                                          1/tan(camera.FOV*0.5 / 180 * π), nil,                                                nil),
   vector.new("CameraProjection", nil,                                                          nil,                             camera.far/(camera.far-camera.near),                1  ),
   vector.new("CameraProjection", nil,                                                          nil,                             (-camera.far*camera.near)/(camera.far-camera.near), 0  )
 }
end



return projection