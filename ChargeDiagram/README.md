## ChargeDiagram
### What is it?
This sketch lets you see the behavior of the electric field and electric potential of an array of charges. This is a relative model and doesn't depict real numbers. With some adjusting of the global variable `distanceScalar` in `ChargeDiagram.pde`, a scalar applied to the pixel distances, you can adjust the scaling of the program.

#### Example 1
This showcases how the field and voltage lines update in real time while moving charges around.

![](../README%20Media/ChargeDiagram1.gif)

#### Example 2
This is another example, but with larger charges.

![](../README%20Media/ChargeDiagram2.gif)

### Why did I made it?
I made this for when I took Physics 2. We were learning about electrical potential and I wanted a visualization of how the voltage changes as differently charged particles move around each other. I made this before I even studied computer science.

### What I learned
I learned how to ray trace the electric field lines from each charge, and how to apply physics concepts into programming.