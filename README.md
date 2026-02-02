# Overview

Processing is an open-source Java-based coding language that lets you draw shapes to a canvas with very little limitation. This software can be used to make games, draw visualizations, and much more.

This repository contains some of my Processing sketches (projects) I've made for various personal uses. This README file will explain what each sketch does, what its purpose is, and what I learned from it.

# Sketches

## AudioVisual
### What is it?
This sketch takes in an audio file and generates a visualizer for it.
This visualizer is completely customizable, from the number of bars (bands) to the color based on amplitude. It also accounts for the window size as well so you don't have to adjust it. I have some examples below of what is possible with this.

#### Example 1
As bands get higher, they get brighter and the color becomes more purple.

![](README%20Media/AudioVisual1.gif)

#### Example 2
The position determines the color, and the height determines the saturation and brightness. The bands are also smaller.

![](README%20Media/AudioVisual2.gif)

### Why did I made it?
I made this to use as a visual for an upcoming music project. The project is a mashup between two songs, "Birthday Party" by AJR, and "I Won't" by AJR. They played this mashup live during The Maybe Man Tour (their theatrical world tour of 2024), and I decided to create a studio version of it. This visualizer serves as the visual for the audio, while I am going to edit in lyrics using Davinci Resolve. When the project is finished I will include a link to it here.

### What I learned
The biggest take away I got from this was that I learned how to use a Fourier Transformation to disect the audio from music. I also now have a better grasp on mathematically adjusting values to make them more disirable.

## ChargeDiagram
### What is it?
This sketch lets you see the behavior of the electric field and electric potential of an array of charges. This is a relative model and doesn't depict real numbers. With some adjusting of the global variable `distanceScalar` in `ChargeDiagram.pde`, a scalar applied to the pixel distances, you can adjust the scaling of the program.

#### Example 1
This showcases how the field and voltage lines update in real time while moving charges around.

![](README%20Media/ChargeDiagram1.gif)

#### Example 2
This is another example, but with larger charges.

![](README%20Media/ChargeDiagram2.gif)

### Why did I made it?
I made this for when I took Physics 2. We were learning about electrical potential and I wanted a visualization of how the voltage changes as differently charged particles move around each other. I made this before I even studied computer science.

### What I learned
I learned how to ray trace the electric field lines from each charge, and how to apply physics concepts into programming.