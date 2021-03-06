# AnimatedOutputSliderControl
A sample project demonstrating a custom slider control that responds to discreet touches by producing streams of animated output values.

A related post, describing how to build the control - along with some discussion of its potential use in audio applications - can be read at http://www.mojolama.com/audio-animation-in-ios.

UIControls typically update their values (and foward actions to their targets) once per discreet touch - even if that touch indicates a jump in values and the visuals themselves animate between those values:

<p align="center"><img src="http://www.mojolama.com/wp-content/uploads/2015/08/MOJOSlider-PrintValues-BEFORE.gif" alt="MOJOSlider-Explicit-Animation" width="385" height="625" /></p>

But Core Animation has the ability to animate *non-visual*, as well as visual, properties - making it possible for custom controls to interpolate between outgoing values:

<p align="center"><img src="http://www.mojolama.com/wp-content/uploads/2015/08/MOJOSlider-PrintValues-AFTER.gif" alt="MOJOSlider-PrintValues-AFTER" width="420" height="660" /></p>

This can be useful in cases where there is a need to more tightly bind the output of a target object to the UI element controlling it. Audio applications, for example, could benefit from this technique.
