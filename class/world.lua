-- world, basically a way to organize all of the meshes in play.
local world={objects={}}

-- list a world's values
function world.list(self)
 
 print("world; " .. self.name .. "'s vars:")
 for i,v in ipairs(self) do
  print(i,v.name)
 end
 
end

return world