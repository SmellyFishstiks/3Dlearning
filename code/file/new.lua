-- create a whole new model/meshtype to call and use
function createNewMeshType(fileName)
 
 
 local newMesh={}
 newMesh.__index = newMesh

 
 function newMesh.new(name, x, y, z, rx, ry, rz)
  return setmetatable(
   {
    name=newMesh or "untitled "..fileName,
    mesh=mesh.new(
     (name or "untitled "..fileName) .. "'s "..fileName.." mesh",
     readModelData(fileName),
     -- position
     {
      x=x or 0,
      y=y or 0,
      z=z or 0,
      -- rotational values
      rx=rx or 0,
      ry=ry or 0,
      rz=rz or 0
     },
     
     true)
   },newMesh
  )
 end
 
 -- list out all points if you wanted.
 function newMesh.list(self)
  print(self.name.."'s points:")
  
  local tris=self.mesh:access()
  for i=1,#tris do
   for j=1,3 do
    print(tris[i].points[j]:list() )
   end
  end
 
 end
 
 return newMesh
 
end