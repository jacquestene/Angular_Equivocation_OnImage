%% Lord and Preprocessing image

I = imread('Senatore_MP01.jpg');
I = im2double(rgb2gray(I));  % Convert to grayscale

%% Compute image Gradients
[Gx, Gy] = imgradientxy(I);           % Gradient components
[~, orientation] = imgradient(Gx, Gy); % Orientation in degrees

%% Quantize Orientation into Histogram
numBins = 36;  % e.g., 10-degree bins
edges = linspace(-180, 180, numBins+1);
orientationHist = histcounts(orientation(:), edges, 'Normalization', 'probability');

figure;
subplot(1, 2, 1);
histogram(orientation(:), edges, 'Normalization', 'probability');
title('Orientation Histogram');
xlabel('Orientation (degrees)');
ylabel('Probability');

%%  Compute Angular Entropy (Equivocation)

% Use Shannon entropy as a measure of equivocation:

% Remove zeros to avoid log(0)
p = orientationHist(orientationHist > 0);
entropyVal = -sum(p .* log2(p));

fprintf('Angular Equivocation (Entropy): %.4f bits\n', entropyVal);

%%  Local Equivocation Map
% blockSize = 16;
blockSize = 4;
entropyMap = zeros(size(I));

for i = 1:blockSize:size(I,1)-blockSize+1
    for j = 1:blockSize:size(I,2)-blockSize+1
        patch = orientation(i:i+blockSize-1, j:j+blockSize-1);
        h = histcounts(patch(:), edges, 'Normalization', 'probability');
        p = h(h > 0);
        entropyMap(i:i+blockSize-1, j:j+blockSize-1) = -sum(p .* log2(p));
    end
end

imagesc(entropyMap); axis image; colorbar;
title('Local Angular Equivocation Map');

