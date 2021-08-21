-- 1..3D vector you could add to tables
local vector={}
vector.__index = vector

-- new vector
function vector.new(name, x,y,z)
    return setmetatable(
     {
      x = x or 0,
      y = y or 0,
      z = z or 0,
      name=name or "untitled vector"
    },vector
   )
end

-- list a vector's values
function vector.list(self)
 print("vector " .. self.name .. "'s vars:")
 for k,v in pairs(self) do
  print(k,v)
 end
end

return vector