-- config file

version = "0.2.5"

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
 
 t.window.title="3D learning v"..version
 t.window.width=size.x*resolution.x
 t.window.height=size.y*resolution.y
 
 t.version = "11.4"
 t.window.highdpi = true -- false

end