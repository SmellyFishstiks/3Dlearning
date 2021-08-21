-- config file

version = "0.1.1"
resolution=10

function love.conf(t)
 
 
 
 t.window.title="3D learning v"..version
 t.window.width=64*resolution
 t.window.height=64*resolution
 
 t.version = "11.4"
 t.window.highdpi = false
end