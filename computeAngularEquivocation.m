function [globalEntropy, localEntropyMap] = computeAngularEquivocation(I, blockSize, numBins, showPlots)
% computeAngularEquivocation - Computes global and local angular entropy of an image
%
% Inputs:
%   I           - Grayscale image (2D array)
%   blockSize   - Block size for local entropy map (set [] to skip)
%   numBins     - Number of bins for orientation histogram (default: 36)
%   showPlots   - Boolean flag to show result plots
%
% Outputs:
%   globalEntropy   - Global angular entropy (single value)
%   localEntropyMap - 2D map of local angular entropy (same size as I)

    if nargin < 3 || isempty(numBins), numBins = 36; end
    if nargin < 4, showPlots = false; end

    % Ensure grayscale and double
    if size(I, 3) == 3
        I = rgb2gray(I);
    end
    I = im2double(I);

    % Compute gradients and orientation
    [Gx, Gy] = imgradientxy(I);
    [~, orientation] = imgradient(Gx, Gy);  % orientation in degrees (-180 to 180)
    
    % Global orientation histogram
    edges = linspace(-180, 180, numBins+1);
    orientationHist = histcounts(orientation(:), edges, 'Normalization', 'probability');
    
    % Global angular entropy
    p = orientationHist(orientationHist > 0);
    globalEntropy = -sum(p .* log2(p));

    % Optional: Compute local angular entropy map
    if ~isempty(blockSize)
        [rows, cols] = size(I);
        localEntropyMap = zeros(rows, cols);

        for i = 1:blockSize:rows-blockSize+1
            for j = 1:blockSize:cols-blockSize+1
                patch = orientation(i:i+blockSize-1, j:j+blockSize-1);
                h = histcounts(patch(:), edges, 'Normalization', 'probability');
                p_local = h(h > 0);
                entropyVal = -sum(p_local .* log2(p_local));
                localEntropyMap(i:i+blockSize-1, j:j+blockSize-1) = entropyVal;
            end
        end
    else
        localEntropyMap = [];
    end

    % Display results
    if showPlots
        fprintf('Angular Equivocation (Entropy): %.4f bits\n', globalEntropy);

        figure;
        subplot(1, 1, 1);
        histogram(orientation(:), edges, 'Normalization', 'probability');
        % title('Orientation Histogram');
        title('Angular Equivocation (Entropy): ', globalEntropy);
        xlabel('Orientation (degrees)');
        ylabel('Probability');

        % if ~isempty(localEntropyMap)
        %     subplot(1, 2, 2);
        %     imagesc(localEntropyMap);
        %     axis image; colorbar;
        %     title('Local Angular Entropy Map');
        % end
    end
end
