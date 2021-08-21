-- simple tri holding 3 vectors
local tri={}
tri.__index = tri

-- new tri
function tri.new(name, one,two,three)
    one = one or {0,0,0}
    two = two or {0,0,0}
    three = three or {0,0,0}
    
    return setmetatable(
     {
      points={
       vector.new( "tri point1", one[1],   one[2],   one[3]   ),
       vector.new( "tri point2", two[1],   two[2],   two[3]   ),
       vector.new( "tri point3", three[1], three[2], three[3] )
      },
      
      name=name or "untitled tri"
    },tri
   )
end


-- list a tri's values
function tri.list(self)
 
 print("tri; " .. self.name .. "'s vars:")
 for k,v in pairs(self) do
  print(k,v)
 end
 
end

return tri