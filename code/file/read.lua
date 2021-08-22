


function readModelData(fileName)
 local raw = love.filesystem.read("model/"..fileName..".mdl")
 
 
 local name,color,tris = "","ffffff",{}
 local triBuilding = false
 local vectorBuilding = false
 
 local giveUp=1000000
 
 -- reader
 local state=0
 local stateTable={ ',', '"', '#', '[', ']', ':', ';', '{', '}' }
 local i=0
 for k=1,#raw do
  i=i+1
  local char=string.sub(raw,i,i)
  
  for j=1,#stateTable do
   if char==stateTable[j] then
    state=j-1
    break
   end
  end
  
  
  -- names
  if state==1 then
   i=i+1
   while string.sub(raw,i,i)~='"' and i<giveUp do
    
    name=name..string.sub(raw,i,i)
    i=i+1
   end
  end
  
  -- color
  if state==2 then
   
   color=string.sub(raw,i+1,i+6)
   i=i+6
  end
  
  -- tri intializer
  if state==3 then
   triBuilding={}
  end
  
  -- tri closer
  if state==4 then
   
   assert(triBuilding,"closed a tri intializer when there wasn't one.")
   tris[#tris+1]=tri.new("file "..name.."'s' tri", triBuilding[1],triBuilding[2],triBuilding[3])
   --[[
   for i=1,3 do
    print(
          triBuilding[i][1],
          triBuilding[i][2],
          triBuilding[i][3]
         )
   end
   --]]
   triBuilding=false
  end
  
  -- grab vector and make a tri
  if state==5 then
   assert(triBuilding,"tried to make new vector without tri.")
   local vectorBuilding={}
   
   local j=i+1
   while i<giveUp do
    i=i+1
    if string.sub(raw,i,i)==";" then
     vectorBuilding[#vectorBuilding+1]=tonumber(string.sub(raw,j,i-1))
     
     j=i+1
    elseif string.sub(raw,i,i)==" " then
     vectorBuilding[#vectorBuilding+1]=tonumber(string.sub(raw,j,i-1))
     
     
     
     triBuilding[#triBuilding+1]={ vectorBuilding[1],vectorBuilding[2],vectorBuilding[3] }
     vectorBuilding={}
     break
    end
    
   end
   
  end
  
  if state==7 then
   --print("wip special properties init (EX: UV, etc.)")
  end
  
  if state==8 then
   --print("wip special properties close (EX: UV, etc.)")
   i=i+1
  end
  
  
  if i>#raw then break end
  
 end
 
 for i=1,#tris do
  for k,v in pairs( tris[i].points[3] ) do
   --print(k,v)
  end
 end
 
 return tris
 
end