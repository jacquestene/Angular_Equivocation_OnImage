% Angular Equivocation Analysis with Enhanced 3D Plot
clc; clear; close all;

%% Load and preprocess image
img = imread("Senatore_MP02.jpg");
if size(img,3) == 3
    grayImg = rgb2gray(img);
else
    grayImg = img;
end
grayImg = im2double(grayImg); % Normalize intensity

%% Compute image gradients
[Gx, Gy] = imgradientxy(grayImg, 'sobel');
[~, angle] = imgradient(Gx, Gy);

% Normalize angles to range [0, 180)
angle = mod(angle, 180);

%% Bin orientation angles
numBins = 18; % 10° per bin
binEdges = linspace(0, 180, numBins+1);
angleBins = discretize(angle, binEdges); % Replaces deprecated histc

%% Initialize entropy map
[rows, cols] = size(grayImg);
entropyMap = zeros(rows, cols);

% Parameters
windowSize = 15;
halfWindow = floor(windowSize / 2);

% Pad angleBins for windowed processing
paddedBins = padarray(angleBins, [halfWindow, halfWindow], 'symmetric');

%% Compute local orientation entropy (angular equivocation)
for i = 1:rows
    for j = 1:cols
        window = paddedBins(i:i+windowSize-1, j:j+windowSize-1);
        counts = histcounts(window(:), 1:(numBins+1));
        probs = counts / sum(counts);
        probs(probs == 0) = [];
        entropyMap(i, j) = -sum(probs .* log2(probs)); % Shannon entropy
    end
end

%% Smooth the entropy map for better visualization
entropyMapSmoothed = imgaussfilt(entropyMap, 1); % Optional

%% 3D Plot
[X, Y] = meshgrid(1:cols, 1:rows);
figure;
mesh(X, Y, entropyMapSmoothed);

title('Angular Equivocation (Orientation of frontal face)');
% title('Angular Equivocation (Orientation of Sagittal face)');
xlabel('X-axis (Pixels)');
ylabel('Y-axis (Pixels)');
zlabel('Entropy');
colormap turbo;
shading interp;
colorbar;
view(45, 45);
