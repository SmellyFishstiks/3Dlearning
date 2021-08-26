-- config file

version = "0.2.6"

-- window dimension stuff
local r = 1
resolution={
 master=r,
 ogx=1.5,
 ogy=1,
}

local baseSize=740
size={
 x=(baseSize*1.5)/resolution.ogx,
 y=(baseSize*1)/resolution.ogy
}

function love.conf(t)
 
 t.window.title="3D learning v"..version
 t.window.width=size.x*resolution.ogx
 t.window.height=size.y*resolution.ogy
 
 t.version = "11.4"
 t.window.highdpi = true -- false

end
