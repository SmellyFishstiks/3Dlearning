


function readModelData(fileName)
 local raw = love.filesystem.read("model/"..fileName..".mdl")
 
 
 local name,tris = "",{}
 local flags = {color={1,1,1}}
 local triBuilding = false
 local vectorBuilding = false
 
 local giveUp=1000000
 
 -- reader
 local state=0
 local stateTable={ ',', '"', '#', '[', ']', ':', ';', '{' }
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
   local data=string.sub(raw,i+1,i+6)
   
   local c = { tonumber("0x"..string.sub(data,1,2))/255, tonumber("0x"..string.sub(data,3,4))/255, tonumber("0x"..string.sub(data,5,6))/255 }
   flags.color = c
   
   
   i=i+6
  end
  
  -- tri intializer
  if state==3 then
   triBuilding={}
  end
  
  -- tri closer
  if state==4 then
   
   assert(triBuilding,"closed a tri intializer when there wasn't one.")
   
   
   local t={}
   for k,v in pairs(flags) do t[k]=v end
   
   tris[#tris+1]=tri.new("file "..name.."'s' tri", triBuilding[1], triBuilding[2], triBuilding[3], t  )
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
   if string.sub(raw,i,i+1)=="{}" then
    state=0
   else
    
    local items={}
    local k,v=false,false
    
    local j=i+1
    while i<giveUp and string.sub(raw,i,i)~="}" do
     
     while not k do
      if string.sub(raw,i,i)=="=" then
       k = string.sub(raw,j,i-1)
       break
      end
      i=i+1
     end
     
     j=i+1
     while not v do
      if string.sub(raw,i,i)==";" then
       v = string.sub(raw,j,i-1)
       if v=="true" then items[k]=true end
       break
      end
      i=i+1
     end
     
     i=i+1
    end
    
    
    for k,v in pairs(items) do
     flags[k]=v
    end
    
    state=0
   end
  end
  
  
  if string.sub(raw,i,i+2)=="End" then return tris end
  
  
  if i>#raw then break end
  
 end
 
 for i=1,#tris do
  for k,v in pairs( tris[i].points[3] ) do
   --print(k,v)
  end
 end
 
 return tris
 
end