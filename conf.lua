-- config file

version = "0.1.3"
resolution=1
size=640

function love.conf(t)
 
 
 
 t.window.title="3D learning v"..version
 t.window.width=size*resolution
 t.window.height=size*resolution
 
 t.version = "11.4"
 t.window.highdpi = false
end