-- vectors to do linar algebra or whatever, very IMPORTANT.
local vector={}
vector.__index = vector

-- new vector
function vector.new(name, x,y,z,w)
    return setmetatable(
     {
      x = x or 0,
      y = y or 0,
      z = z or 0,
      w = w or 0,
      name=name or "untitled vector"
    },vector
   )
end


-- list a vector's values
function vector.list(self)
 
 print("vector; " .. self.name .. "'s vars:")
 for k,v in pairs(self) do
  print(k,v)
 end
end


-- add
function vector.add(self,vec)
 self.x=self.x+vec.x or 0
 self.y=self.y+vec.y or 0
 self.z=self.z+vec.z or 0
 self.w=self.w+vec.w or 0
 
 return self
end

-- multiply
function vector.multiply(self,vec)
 self.x=self.x*vec.x or 0
 self.y=self.y*vec.y or 0
 self.z=self.z*vec.z or 0
 self.w=self.w*vec.w or 0
 
 return self
end

-- return multipling a matrix
function vector.multiplyMatrix(self,matrix)
 
 local output= {
  x=self.x*matrix[1].x + self.y*matrix[2].x + self.z*matrix[3].x + self.w*matrix[4].x,
  y=self.x*matrix[1].y + self.y*matrix[2].y + self.z*matrix[3].y + self.w*matrix[4].y,
  z=self.x*matrix[1].z + self.y*matrix[2].z + self.z*matrix[3].z + self.w*matrix[4].z,
 }
 local w=self.x*matrix[1].w + self.y*matrix[2].w + self.z*matrix[3].w + matrix[4].w
 
 
 
 if w~=0 then
  output.x=output.x/w
  output.y=output.y/w
  output.z=output.z/w
 end
 
 return output
end


return vector