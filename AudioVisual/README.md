## AudioVisual
### What is it?
This sketch takes in an audio file and generates a visualizer for it.
This visualizer is completely customizable, from the number of bars (bands) to the color based on amplitude. It also accounts for the window size as well so you don't have to adjust it. I have some examples below of what is possible with this.

#### Example 1
As bands get higher, they get brighter and the color becomes more purple.

![](../README%20Media/AudioVisual1.gif)

#### Example 2
The position determines the color, and the height determines the saturation and brightness. The bands are also smaller.

![](../README%20Media/AudioVisual2.gif)

### Why did I made it?
I made this to use as a visual for an upcoming music project. The project is a mashup between two songs, "Birthday Party" by AJR, and "I Won't" by AJR. They played this mashup live during The Maybe Man Tour (their theatrical world tour of 2024), and I decided to create a studio version of it. This visualizer serves as the visual for the audio, while I am going to edit in lyrics using Davinci Resolve. When the project is finished I will include a link to it here.

### What I learned
The biggest take away I got from this was that I learned how to use a Fourier Transformation to disect the audio from music. I also now have a better grasp on mathematically adjusting values to make them more disirable.