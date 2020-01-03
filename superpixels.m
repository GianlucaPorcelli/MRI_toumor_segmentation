%%
A=mat2gray(VsmoothBG);
%computes 3-D superpixels of the 3-D image A. N specifies the number of superpixels you want to create.
%The function returns L, a 3-D label matrix, and NumLabels, the actual number of superpixels returned.
[L,N] = superpixels3(A,34);
%Show all xy-planes progressively with superpixel boundaries.
imSize = size(A);
%Create a stack of RGB images to display the boundaries in color.
imPlusBoundaries = zeros(imSize(1),imSize(2),3,imSize(3),'uint8');
for plane = 1:imSize(3)
    BW = boundarymask(L(:, :, plane));
    % Create an RGB representation of this plane with boundary shown
    % in cyan.
    imPlusBoundaries(:, :, :, plane) = imoverlay(A(:, :, plane), BW, 'cyan');
end

%Set the color of each pixel in output image to the mean intensity of the superpixel region. 
%Show the mean image next to the original. If you run this code, you can use implay to view each slice of the MRI data.
pixelIdxList = label2idx(L);
meanA = zeros(size(A),'like',A);
%%
for superpixel = 1:N
     memberPixelIdx = pixelIdxList{superpixel};
     meanA(memberPixelIdx) = mean(A(memberPixelIdx));
end
%make a comparison between the original saliency map and the segmented one
%and skip every time 5 slice for speeding the process
implay([A meanA],5);
%also in the saliency process you can substitute the imshow command with
%an implay command but the image must be converted into grayscale

%meanA contains the volume segmented by intensity value
meanA=mat2gray(meanA);
%maxValue take the maximum intensity of the volume
maxValue = max(meanA(:));
%tumor isolate only the volume region having max intensity value
tumor=meanA==maxValue;
figure;
volshow(tumor);
title('only toumor');
%%
%In an easy way you can sum the matrix containing the tumor region with a
%sequence to underline where is located the tumor
%This sum makes all tumor pixels white in the image
Vfin=zeros(size(meanA));
for i=1:imSize(3)
    Vfin(:,:,i)=Vflair(:,:,i)+tumor(:,:,i);
end
volumeViewer(Vfin)
%%
pause()
close all;