%Select a slice of the three sequences
Vflair = mat2gray(Vflair);
Vf = Vflair(:,:,70);
%%
VT1 = mat2gray(VT1);
Vt1 = VT1(:,:,70);
%%
VT2 = mat2gray(VT2);
Vt2 = VT2(:,:,70);

%%
%Assign the RED layer to every sequences
VfRed = cat(3, Vf, zeros(size(Vf)), zeros(size(Vf)) );
Vt1Red = cat(3, Vt1, zeros(size(Vt1)), zeros(size(Vt1)) );
Vt2Red = cat(3, Vt2, zeros(size(Vt2)), zeros(size(Vt2)) );
%%
%Assign the GREEN layer to every sequences
VfGreen = cat(3, zeros(size(Vf)), Vf, zeros(size(Vf)) );
Vt1Green = cat(3, zeros(size(Vt1)), Vt1, zeros(size(Vt1)) );
Vt2Green = cat(3, zeros(size(Vt2)), Vt2, zeros(size(Vt2)) );
%%
%Assign the BLUE layer to every sequences
VfBlue = cat(3, zeros(size(Vf)), zeros(size(Vf)), Vf );
Vt1Blue = cat(3, zeros(size(Vt1)), zeros(size(Vt1)), Vt1 );
Vt2Blue = cat(3, zeros(size(Vt2)), zeros(size(Vt2)), Vt2 );
%%
%Create all possible RGB combination with sequences 
Vabc=VfRed+Vt2Green+Vt1Blue;
Vacb=VfRed+Vt1Green+Vt2Blue;
Vbac=Vt2Red+VfGreen+Vt1Blue;
Vbca=Vt2Red+Vt1Green+VfBlue;
Vcab=Vt1Red+VfGreen+Vt2Blue;
Vcba=Vt1Red+Vt2Green+VfBlue;
%%
%convert the RGB images into Lab
Vabc1=rgb2lab(Vabc);
Vacb1=rgb2lab(Vacb);
Vbac1=rgb2lab(Vbac);
Vbca1=rgb2lab(Vbca);
Vcab1=rgb2lab(Vcab);
Vcba1=rgb2lab(Vcba);
Vslice=cat(3,Vabc1(:,:,1),Vacb1(:,:,1),Vbac1(:,:,1),Vbca1(:,:,1),Vcab1(:,:,1),Vcba1(:,:,1));

%%
str = sprintf('Vabc Vacb Vbac Vbca Vcab Vcba');
montage({Vabc,Vacb,Vbac,Vbca,Vcab,Vcba},'Size',[1 6]);
title(str);

Vb=Vabc1;
pause();
close all;

