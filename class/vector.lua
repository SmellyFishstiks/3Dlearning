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



-- vector math functions
-- probably could cut this down further but I don't really mind.


-- add
function vector.add(self,vec)
 return {x=self.x+vec.x, y=self.y+vec.y, z=self.z+vec.z, w=0}
end


-- subtract
function vector.subtract(self,vec)
 return {x=self.x-vec.x, y=self.y-vec.y, z=self.z-vec.z, w=0}
end


-- multiply
function vector.multiply(self,v)
 return {x=self.x*v, y=self.y*v, z=self.z*v, w=0}
end


-- multiply
function vector.divide(self,v)
 return {x=self.x/v, y=self.y/v, z=self.z/v, w=0}
end


-- find dot product
function vector.dotProduct(self,vec)
 return self.x*vec.x + self.y*vec.y + self.z*vec.z
end


-- get length
function vector.length(self,vec)
 return (vector.dotProduct(self,vec))^0.5
end


-- normalize vector
function vector.noramlize(self)
 local length=self.length(self,self)
 if length~=0 then
  return self:divide(length)
 else
  return self
 end
end


-- find cross product
function vector.crossProduct(self,vec) 
 return vector.new(
  "crossProduct vector",
  self.y*vec.z - self.z*vec.y,
  self.z*vec.x - self.x*vec.z,
  self.x*vec.y - self.y*vec.x,
  1)
end


-- return multipling a matrix
function vector.multiplyMatrix(self,matrix)
 local output= {
  x=self.x*matrix[1].x + self.y*matrix[2].x + self.z*matrix[3].x + self.w*matrix[4].x,
  y=self.x*matrix[1].y + self.y*matrix[2].y + self.z*matrix[3].y + self.w*matrix[4].y,
  z=self.x*matrix[1].z + self.y*matrix[2].z + self.z*matrix[3].z + self.w*matrix[4].z,
  w=self.x*matrix[1].w + self.y*matrix[2].w + self.z*matrix[3].w + matrix[4].w,
 }
 
 if output.w~=0 then
  output.x=output.x/output.w
  output.y=output.y/output.w
  output.z=output.z/output.w
 end
 
 for k,v in pairs(output) do
  self[k]=v
 end
 
 return self
end


function vector.quickInverse(matrix)
 return {
  vector.new( matrix[1].x, matrix[2].x, matrix[3].x, 0 ),
  vector.new( matrix[1].y, matrix[2].y, matrix[3].y, 0 ),
  vector.new( matrix[1].z, matrix[2].z, matrix[3].z, 0 ),
  vector.new(
   -( matrix[4].x*matrix[1].x + matrix[4].y*matrix[2].x + matrix[4].z*matrix[3].x ),
   -( matrix[4].x*matrix[1].y + matrix[4].y*matrix[2].y + matrix[4].z*matrix[2].y ),
   -( matrix[4].x*matrix[1].z + matrix[4].y*matrix[3].z + matrix[4].z*matrix[3].z ),
   1
  ),
 }
end




return vector