-- config file

version = "0.2.4"

-- window dimension stuff
local r, xr,yr = 1, 1.5, 1
resolution={
 master=r,
 x=r*xr^2,
 y=r*yr
}

local baseSize=740
size={
 x=(baseSize*xr)/resolution.x,
 y=(baseSize*yr)/resolution.y
}

function love.conf(t)
 
 local w= require("love.window")
 local wx,wy = w.getDesktopDimensions()
 
 t.window.title="3D learning v"..version
 t.window.width=size.x*resolution.x
 t.window.height=size.y*resolution.y
 
 t.window.x = wx/2 - (size.x*resolution.x)/2
 t.window.y = 40
 
 t.version = "11.4"
 t.window.highdpi = true
end