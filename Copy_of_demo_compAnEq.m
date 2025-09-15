I = imread("Senatore_MP01.jpg");
J = imread("Senatore_MP02.jpg");
[globalEntropy, localMap] = Copy_of_computeAngularEquivocation(I,J, 16, 36, true);

