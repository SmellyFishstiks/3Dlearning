-- mesh object that will hold as many tris as it wants
local mesh={}
mesh.__index = mesh

-- new tri
function mesh.new(name,tris)
    return setmetatable(
     {
      tris=tris or {},
      
      name=name or "untitled mesh"
    },mesh
   )
end


-- list a vector's values
function mesh.list(self)
 
 print("mesh; " .. self.name .. "'s vars:")
 for k,v in pairs(self) do
  print(k,v)
 end
 
end



function mesh.access(self)
 return self.tris
end

return mesh