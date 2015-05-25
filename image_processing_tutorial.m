%% Image processing tutorial
% Jeff Stafford

% Let's examine how to manipulate images. In my mind, this is MATLAB's real
% strength. Everything is really easy and makes sense. 

% load an example image as the variable 'birds'
birds = imread('birds_example.jpg');

% lets display it... you'll notice i took the liberty of coloring the birds
imshow(birds);

%% How are images handled in MATLAB?

% images are simply 3 dimensional arrays
size(birds)

% first two dimensions are the dimensions in pixels, and the 3rd contains
% the red, green, and blue channels (in that order)

% look at the red channel
imshow(birds(:, :, 1));

% what class are the element of the image (i.e. how is the data stored)
class(birds)

% Numbers can be stored in a variety of formats in your computer. Images
% most often use uint8 (unsigned 8-bit integer) to save space. This is an
% important consideration, as I'll demonstrate!

% Notice how an array of zeros takes up less space when it is a uint8
% rather than a double (normal numbers).
uint8Var = zeros(100, 'uint8');
doubleVar = zeros(100, 'double');
whos('uint8Var', 'doubleVar')
% the uint8 variable takes up 8 times less space!

% What are the limitations of uint8?
% - It can only contain a numbers between 0 and 255.
% - Integers ONLY
a = uint8(1);
a
a + 1.75 % non-integers get rounded
a + 1000 % numbers are capped at 255
a - 12 % numbers cannot be less than 0

%% Image manipulation

% Keeping the above caveats in mind, notice how we can do math to the
% image:
birdsDarker = birds - 128;
imshowpair(birds, birdsDarker, 'montage');

% subtracting another image from one is really easy
minusBirds = birds - birdsDarker;
imshowpair(birds, minusBirds, 'montage');

%% Object detection

% There are tons of built-in functions to handle images. Let's abuse them.

% Convert birds to greyscale (we are flattening the image to a simple 2D
% matrix)
greyBirds = rgb2gray(birds);
imshow(greyBirds);

% We can threshold the image too. This is very useful for image analysis.
thresholded = im2bw(greyBirds, 0.1);
imshow(thresholded);
% It looks like our threshold was set wrong. How do we do this
% intelligently? 

%... matlab actually has a function for this based on Otsu's method
threshValue = graythresh(greyBirds);
% use the new value for thresholding
thresholded = im2bw(greyBirds, threshValue);
imshow(thresholded); % much better!

% notice how we now have a matrix of booleans, just something to keep in
% mind
class(thresholded)

% Matlab can perform object detection
labeled = bwlabel(thresholded);
% note that how the image looks is really unchanged
imshow(labeled);
% However I wrote a helper function for this (feel free to abuse)
showRegions(labeled);
% Detected regions are colored in and labeled with a number. You'll notice
% that it appears we actually labeled the white areas and not the dark
% birds we were interested in. bwlabel actually labels white values (ie. 1s
% in our matrix)

% Lets invert the thresholded image and relabel. Remember, since the
% thresholded image is boolean, the max value is 1.
thresholded = 1 - thresholded;
labeled = bwlabel(thresholded);
showRegions(labeled);

% There's still a lot of erm, 'bonus' regions that we don't want. (We just
% want the birds!). Let's reduce random pixel noise in our thresholded
% image with a filter.
thresholded = medfilt2(thresholded);
labeled = bwlabel(thresholded);
showRegions(labeled); % much better!

%% Getting our objects

% So we have a set of objects that we've detected, but there are still some
% random smaller regions in there. How do we filter those out?

% To get the properties of your detected regions
regions = regionprops(labeled);
% returns a structure that we can examine
regions
% we want to look at the areas of the regions and filter out small ones. We
% will do this using the 'Area' attribute.
regions.Area

% Let's delete the smaller regions completely... to do this, we need to
% recalculate the regionprops with lists of the pixels in each region.

% Fortunately, regionprops has options for that!
regions = regionprops(labeled, 'Area', 'Centroid', 'PixelList', 'PixelIdxList', 'BoundingBox');

% small regions are filtered out of our data
regionNum = 1;
sizeThresh = 500;
while (regionNum <= length([regions.Area]))
    % look for regions that are smaller than our sizeThresh
    if (regions(regionNum).Area < sizeThresh)
        % unlabel pixels in small regions
        for pixRow = 1:size(regions(regionNum).PixelList,1);
            labeled( ...
                regions(regionNum).PixelList(pixRow,2), ...
                regions(regionNum).PixelList(pixRow,1)) ...
                = 0;
        end
        % now delete the entry
        regions(regionNum) = [];
    else
        regionNum = regionNum + 1;
    end
end

% check to see that we filtered out the small regions
labeled = bwlabel(logical(labeled));
showRegions(labeled);
% so now we only have the birds...

%% Analyzing objects

% We already have the positions available through the regionprops function
% that we executed earlier.
positions = reshape([regions.Centroid], 2, length([regions.Centroid])/2)';

% Let's check our work:
figure('Name', 'Bird positions');
imshow(birds);
hold on;
scatter(positions(:, 1), positions(:, 2), [], 'yellow');
hold off;
% Yep there are the positions!

% What if we wanted the average pixel values from the red channel for each bird?
intensity = zeros(length(regions), 1);
for i = 1:length(regions)
    intensity(i) = mean(mean(birds( ...
        regions(i).PixelList(:, 2), ...
        regions(i).PixelList(:, 1), 1)));
end
intensity

% What if we wanted to seperate all the birds into separate images?
separated = struct();
figure;
hold on;
for i = 1:length(regions)
    separated(i).Image = imcrop(birds, regions(i).BoundingBox);
    subplot(2,4,i), subimage(separated(i).Image);
end
hold off;

% Honestly you can pretty much do anything you want in relation to image
% processing in MATLAB and it will work. Analyzing videos is just image
% analysis looped over the length of the video.
