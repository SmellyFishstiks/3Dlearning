-- mesh object that will hold as many tris as it wants
local mesh={}
mesh.__index = mesh

-- new tri
function mesh.new(name, tris, position, addToWorld)
 local t=
  {
   tris=tris or {},
   name=name or "untitled mesh",
   
   position=position or { x=0, y=0, z=0, rx=0, rz=0 }
 }
 if addToWorld then
  world.objects[#world.objects+1]=t
  return setmetatable(t,mesh)
 else 
  return t
 end
 
end


-- list a mesh's values
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