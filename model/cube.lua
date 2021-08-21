-- cube object that will hold as many tris as it wants
local cube={}
cube.__index = cube

-- new cube, points are predefined 0's and 1's.
-- think of it as a unit cube.
function cube.new(name)
    return setmetatable(
     {
      name=name or "untitled cube",
      mesh=mesh.new(
       (name or "untitled cube") .. "'s cube mesh",
       {
        -- "south"
        tri.new( "SouthA", {0,0,0},{0,1,0},{1,1,0} ),
        tri.new( "SouthB", {0,0,0},{1,1,0},{1,0,0} ),
        
        -- "east"
        tri.new( "EastA", {1,0,0},{1,1,0},{1,1,1} ),
        tri.new( "EastB", {1,0,0},{1,1,1},{1,0,1} ),
        
        -- "north"
        tri.new( "NorthA", {1,0,1},{1,1,1},{0,1,1} ),
        tri.new( "NorthB", {1,0,1},{0,1,1},{0,0,1} ),
        
        -- "west"
        tri.new( "WestA", {0,0,1},{0,1,1},{0,1,0} ),
        tri.new( "WestB", {0,0,1},{0,1,0},{0,0,0} ),
        
        -- "top"
        tri.new( "TopA", {0,1,0},{0,1,1},{1,1,1} ),
        tri.new( "TopB", {0,1,0},{1,1,1},{1,1,0} ),
        
        -- "bottom"
        tri.new( "BottomA", {1,0,1},{0,0,1},{0,0,0} ),
        tri.new( "BottomB", {1,0,1},{0,0,0},{1,0,0} )
        
       }
      )
    },cube
   )
end

-- list out all points if you wanted.
function cube.list(self)
 print(self.name.."'s points:")
 
 local tris=self.mesh:access()
 for i=1,#tris do
  for j=1,3 do
   print(tris[i].points[j]:list() )
  end
 end

end

return cube