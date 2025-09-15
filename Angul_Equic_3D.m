% Angular Equivocation Analysis and 3D Plot
clc; clear; close all;

% Load image
img = imread('Senatore_MP01.jpg'); % Use any image you like
% img = imread('Senatore_MP01.jpg'); % Use any image you like
grayImg = rgb2gray(img);

% Compute gradients
[Gx, Gy] = imgradientxy(double(grayImg), 'sobel');
[mag, angle] = imgradient(Gx, Gy);

% Normalize angle to 0-180
angle = mod(angle, 180);

% Discretize angles into bins
numBins = 18; % 10 degree bins
binEdges = linspace(0, 180, numBins+1);
[~, angleBins] = histc(angle, binEdges);

% Initialize entropy map
entropyMap = zeros(size(grayImg));

% Define window size
windowSize = 15;
halfWindow = floor(windowSize / 2);

% Pad the angle bins
paddedBins = padarray(angleBins, [halfWindow, halfWindow], 'symmetric');

% Calculate local entropy for each pixel
for i = 1:size(grayImg,1)
    for j = 1:size(grayImg,2)
        window = paddedBins(i:i+windowSize-1, j:j+windowSize-1);
        counts = histcounts(window(:), 1:(numBins+1));
        probs = counts / sum(counts);
        probs(probs == 0) = [];
        entropyMap(i,j) = -sum(probs .* log2(probs));
    end
end

% Create 3D plot
[X, Y] = meshgrid(1:size(entropyMap,2), 1:size(entropyMap,1));
figure;
mesh(X, Y, entropyMap);
title('Angular Equivocation (Entropy) Map');
xlabel('X'); ylabel('Y'); zlabel('Entropy');
colormap jet;
colorbar;
