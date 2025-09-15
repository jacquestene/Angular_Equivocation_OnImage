function angularEquivarianceDemo(imagePath, rotationAngle, numBins)
% Demonstrates angular equivariance using orientation histograms.
% INPUTS:
%   imagePath      - Path to grayscale image
%   rotationAngle  - Angle (in degrees) to rotate the image
%   numBins        - Number of bins for orientation histogram (default: 36)

if nargin < 3
    numBins = 36;
end

% Load image
I = imread(imagePath);
if size(I, 3) == 3
    I = rgb2gray(I);
end
I = im2double(I);

% Rotate image
I_rotated = imrotate(I, rotationAngle, 'bilinear', 'crop');

% Compute gradient orientation for original image
[Gx, Gy] = imgradientxy(I);
[~, orientation] = imgradient(Gx, Gy); % [-180, 180]

% Compute gradient orientation for rotated image
[Gx_r, Gy_r] = imgradientxy(I_rotated);
[~, orientation_rotated] = imgradient(Gx_r, Gy_r);

% Histogram edges
edges = linspace(-180, 180, numBins + 1);

% Orientation histograms
hist_original = histcounts(orientation(:), edges, 'Normalization', 'probability');
hist_rotated = histcounts(orientation_rotated(:), edges, 'Normalization', 'probability');

% Plot results
figure;
subplot(2,2,1); imshow(I); title('Original Image');
subplot(2,2,2); imshow(I_rotated); title(['Rotated Image (', num2str(rotationAngle), '°)']);
subplot(2,2,[3,4]);
binCenters = (edges(1:end-1) + edges(2:end)) / 2;
plot(binCenters, hist_original, 'b', 'LineWidth', 2); hold on;
plot(binCenters, hist_rotated, 'r--', 'LineWidth', 2);
xlabel('Orientation (degrees)');
ylabel('Probability');
legend('Original', 'Rotated');
title('Orientation Histogram Comparison');
grid on;

end
