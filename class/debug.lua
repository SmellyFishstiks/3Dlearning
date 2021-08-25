

local debug = {}
debug.__index = debug

-- draw out debug on the screen
function debug.new()
 return setmetatable({text={}},debug)
end

function debug.update(self,text)
 self.text=text
end

-- render stuff to a screen
function debug.renderTo(self, screen)
 
 g.setCanvas(screen)
 g.scale( 1/resolution.x, 1/resolution.y )
  
  for i=1,#self.text do
   g.print( self.text[i],1,(i-1)*80 )
  end
  
 g.origin()
 g.setCanvas()
end


return debug