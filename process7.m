%initial size
x=length(Vflair(:,1,1));
y=length(Vflair(1,:,1));
z=length(Vflair(1,1,:));
%create a single empty slice 256*256 
Vsal = cat(3,zeros(256));
Vsmooth = cat(3,zeros(256));
%%
%create reursively all slices containing an empty image 256*256
%Vsal will contain the saliency volume and Vsmooth the
%smoothed version
for i = 1:z
    Vsal = cat(3,Vsal,zeros(256));
    Vsmooth = cat(3,Vsmooth,zeros(256));    
end
%resize the image to the original values for convenience
Vsal=Vsal(1:x,1:y,1:z);
Vsmooth=Vsmooth(1:x,1:y,1:z);
%%
for i = 1:z
    %select the "i" slice of the three sequences
    Vf=Vflair(:,:,i);
    Vt1=VT1(:,:,i);
    Vt2=VT2(:,:,i);
    %Assign the required RGB channel to all sequences
    VfRed = cat(3, Vf, zeros(size(Vf)), zeros(size(Vf)) );
    Vt2Green  = cat(3, zeros(size(Vt2)), Vt2, zeros(size(Vt2)) );
    Vt1Blue = cat(3, zeros(size(Vt1)), zeros(size(Vt1)), Vt1 );
    %compute the RGB image
    Vabc=VfRed+Vt2Green+Vt1Blue;
    %convert the image to Lab
    Vabc1=rgb2lab(Vabc);
    %call for all slice the function "process3" that compute the salience process
    %Vsal(:,:,i),Vsmooth(:,:,i) are initially empty and for every slice are
    %updated with the "i" saliency map
    [Vsal(:,:,i),Vsmooth(:,:,i)]=process3(Vabc1);
    %process3 needs as input the Lab image
    imshow(Vsmooth (:,:,i),[]);
end 

close all;