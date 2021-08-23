-- config file

version = "0.2.2"

-- window dimension stuff
local r, xr,yr = 1, 1, 1
resolution={
 x=r*xr,
 y=r*yr
}

size={
 x=(640*xr)/resolution.x,
 y=(640*yr)/resolution.y
}

function love.conf(t)
 
 t.window.title="3D learning v"..version
 t.window.width=size.x*resolution.x
 t.window.height=size.y*resolution.y
 
 
 t.version = "11.4"
 t.window.highdpi = true
end