x=length(Vflair(:,1,1));
y=length(Vflair(1,:,1));
z=length(Vflair(1,1,:));
%create a single empty slice 256*256 
VsalBG = cat(3,zeros(256));
VsmoothBG = cat(3,zeros(256));
%%
%create reursively all slices containing an empty image 256*256
%First element will contain the saliency volume and the second one the
%smoothed version
for i = 1:z
    VsalBG = cat(3,VsalBG,zeros(256));
    VsmoothBG = cat(3,VsmoothBG,zeros(256));    
end
VsalBG=VsalBG(1:x,1:y,1:z);
VsmoothBG=VsmoothBG(1:x,1:y,1:z);
%%
for i = 1:z
    %select the "i" slice of the three sequences
    Vf=Vflair(:,:,i); 
    Vt1=VT1(:,:,i);
    Vt2=VT2(:,:,i);
    [VsalBG(:,:,i),VsmoothBG(:,:,i)]=process5(Vf,Vt1,Vt2);
    %process5 needs as input not the Lab image but the initial sequences
    %because in that function are computed the modified images (background changes)
    imshow(VsmoothBG(:,:,i),[]);
end 
close all;