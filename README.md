Angular Equivocation (Also know as Angular Entropy) is a type of differential entropy, but it applies to random variables defined on a circle. The Angular equivocation is built using von Mises distributions. Angulart equivocation like local shanon Shanon entropy, calculates the uncertainty in the distribution of edge or gradient orientations in an images. Thus, it measures the probability uncertainty of pixel orientations in degrees and is commonly used to detect visual distortions that weaken directional structure.
In our project to determine the reliability of permanent pacemakers(PPMs) structures that have been implanted in patients who are suffering from one of the cardiovascular disease over time, we applied Angular equivocation to quantify uncertainty or directional disoder frequency, or uncertainty in the distribution of edge or gradient orientations in PPMs images.

Angular Equivocation Analysis with Enhanced 3D Plol
- 
This MATLAB script computes and visualizes the angular equivocation(local orientation entropy) of grayscale image using Sobel gradients. It is particularly useful for analyzing orientation diversity in textures or facial features.

Features
- 
- Converts an input image to grayscale and normalizes intensity.
- Computes local gradient orientations using Sobel filters.
- Discretizes orientation angles into bins.
- Calculates Shannon entropy in a sliding window over the image to quantify angular diversity.
- Smooths the resulting entropy map
- Renders a 3D mesh plot of the angular equivocation for enhanced visual analysis

Requirements
-
- Matlab (2016b or later recommended)
- image Processing Toolbox

Parameters
-
- numBins: Numbers of angular bin (default: 18 for 10° increments)
- windowSize: Size of the sliding window for entropy calculation (default: 15x 15)
- Gaussian smoothing applied to enhance visualization(imgaussfilt)

Output
-
- A 3D mesh showing local angular equivocation, where higher values indicate greater orientation diversity.
