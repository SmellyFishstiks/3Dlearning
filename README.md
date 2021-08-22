# 3Dlearning

Making a learning file to learn complex conecepts about how to draw things to the screen and
"fake" perspective.

Version Log:

# v0.1
Base main.lua file and repo

# v0.1.1
Screen canavs, conf.lua, vector class,

And a test of printing out a test vector's properties.

# v0.1.2
Tri, Mesh, and Model cube added to start playing with them,

Playground.lua for testing and running our code in there,

Camera class for making a screen to draw all of the perspective stuff to.

# v0.1.3
Camera projection, Meshes being added to world, Drawing to screen Vector maths

And shortcuts for making my life easier. lots of progress!

# v0.1.4
Screen resolution fixes, Cleaned rendering and now vectors are 5D, fixed rotating(?),

Editing meshses is now moved to outside of rendering to make life way nicer.

# v0.1.5
Fixed rotation bug with editing x,y tri poses instead of the mesh position, and also fixed RZ projection matrix issue.

# v0.2
Lots of stuff.. where to start..

Grabs Normals of the faces, culls stuff not needed to be drawn using that, uses normals for the lighting (though I want to add lights as their own object thing..)

Saves tris to draw, sorts by z, then draws them with polygon to fill and threw in the outline shader because I love it.

Currently in the process of reorganizing some stuff and model files..

#v0.2.1
Reorganized the stuff and now I made a reader for my mdl format to read models!