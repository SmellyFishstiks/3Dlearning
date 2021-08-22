


transformationTable={}

function updateTransformations(one,two)
 one, two = one or 0, two or 0
 
 transformationTable={
  
  
  -- rotate a object
  rotatations={
   -- x
   x={
    vector.new("rotation",1,0,         0,        0 ),
    vector.new("rotation",0,cos(one), sin(one),0 ),
    vector.new("rotation",0,-sin(one),cos(one),0 ),
    vector.new("rotation",0,0,         0,        1 )
   },
   -- z
   z={
    vector.new("rotation",cos(two), sin(two),0,0 ),
    vector.new("rotation",-sin(two),cos(two),0,0 ),
    vector.new("rotation",0,         0,        1,0 ),
    vector.new("rotation",0,         0,        0,1 )
   }
  }
  
 }
 
end