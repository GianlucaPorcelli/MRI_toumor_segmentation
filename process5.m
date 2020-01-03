function [saliency,smooth]= process5(Vf,Vt1,Vt2)
%% 
%Vf (red) changing background
%create an empty matrix (256*256) representing the first channel of the
%image. X and y must be lower than 256
Vw= cat(3, zeros(256));
%Square image 256x256
x=length(Vf(:,1));
y=length(Vf(1,:));
%Assign the content of the selected sequence Vf (FLAIR) to the new variable
%Vw expanding its size to (256*256)
for i = 1:x
    for j = 1:y
        Vw(i,j)=Vf(i,j);
        Vw(i,j)=Vf(i,j);
        Vw(i,j)=Vf(i,j);
    end
end
%
%Intensity of background
cont=0;
mediaF=0;
for i = 1:x
    for j = 1:y
        if(Vw(i,j)>0)
            %I don't consider the black pixels because they don't contribute
            %to the mean. 
            mediaF=mediaF+Vw(i,j);
            cont=cont+1;
        end
    end
end
%If there isn't any pixels of the image, my mean value is equal to zero
if(cont==0)
    mediaF=0;
else
    mediaF=mediaF/cont;
end
%
%Change background color if mean value is not zero
%Every pixels previous equal to zero now assume the mean value of the image
for i = 1:256
    for j = 1:256
        if(Vw(i,j)==0)
            Vw(i,j)=mediaF;
        end
    end
end
VbgF=Vw;

%% 
%Vt1 (green) changing background

for i = 1:256
    for j = 1:256
        if((i<x)&&(j<y))
            Vw(i,j)=Vt1(i,j);
            Vw(i,j)=Vt1(i,j);
            Vw(i,j)=Vt1(i,j);
        else
            Vw(i,j)=0;
            Vw(i,j)=0;
            Vw(i,j)=0;
        end
    end
end
%
%Intensity of background
cont=0;
mediaT1=0;
for i = 1:x
    for j = 1:y
        if(Vw(i,j)>0)
            mediaT1=mediaT1+Vw(i,j);
            cont=cont+1;
        end
    end
end

if(cont==0)
    mediaT1=0;    
else
    mediaT1=mediaT1/cont;
end
%
%Change background color
for i = 1:256
    for j = 1:256
        if(Vw(i,j)==0)
            Vw(i,j)=mediaT1;
        end
    end
end
VbgT1=Vw;

%% 
%Vt2 (blue) changing background

for i = 1:256
    for j = 1:256
        if((i<x)&&(j<y))
            Vw(i,j)=Vt2(i,j);
            Vw(i,j)=Vt2(i,j);
            Vw(i,j)=Vt2(i,j);
        else
            Vw(i,j)=0;
            Vw(i,j)=0;
            Vw(i,j)=0;
        end
    end
end
%
%Intensity of background
cont=0;
mediaT2=0;
for i = 1:x
    for j = 1:y
        if(Vw(i,j)>0)
            mediaT2=mediaT2+Vw(i,j);
            cont=cont+1;
        end
    end
end
if(cont==0)
    mediaT2=0;    
else
    mediaT2=mediaT2/cont;
end
%
%Change background color
for i = 1:256
    for j = 1:256
        if(Vw(i,j)==0)
            Vw(i,j)=mediaT2;
        end
    end
end
VbgT2=Vw;

%%
VRed = cat(3, VbgF, zeros(256), zeros(256) );
VGreen = cat(3, zeros(256), VbgT2, zeros(256) );
VBlue = cat(3, zeros(256), zeros(256), VbgT1 );

Vbg=VRed+VGreen+VBlue;
Vbg=rgb2lab(Vbg);
%%
%pass to the next function the updated sequences
[saliency,smooth] = process6(Vbg,x,y);
end