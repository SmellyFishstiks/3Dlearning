


transformationTable={}

function updateTransformations(rotx,rotz)
 rotx, rotz = rotx or 0, rotz or 0
 
 transformationTable={
  
  
  -- rotate a object
  rotatations={
   -- x
   x={
    vector.new("rotation",1,0,         0,        0 ),
    vector.new("rotation",0,cos(rotx), sin(rotx),0 ),
    vector.new("rotation",0,-sin(rotx),cos(rotx),0 ),
    vector.new("rotation",0,0,         0,        1 )
   },
   -- z
   z={
    vector.new("rotation",cos(rotz), sin(rotz),0,0 ),
    vector.new("rotation",-sin(rotz),cos(rotz),0,0 ),
    vector.new("rotation",0,         0,        1,0 ),
    vector.new("rotation",0,         0,        0,1 )
   }
  }
  
 }
 
end