%use activecontour function with 10 iteration applyng on the image
%VsmoothBG using the tumor 3D map as contour
bw = activecontour(VsmoothBG,tumor,10);
%bw contains the segmented tumor binary volume
Vfin=zeros(size(meanA));
for i=1:imSize(3)
    Vfin(:,:,i)=Vflair(:,:,i)+bw(:,:,i);
end
%like in the previous step you can esay check tumor area adding the 
%segmented tumor to any sequence (in this case FLAIR sequence)
volumeViewer(Vfin);