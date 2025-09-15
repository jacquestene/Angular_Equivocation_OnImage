I = imread("Senatore_MP01.jpg");
[globalEntropy, localMap] = computeAngularEquivocation(I, 16, 36, true);
