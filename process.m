%%
%acquire sequences
[Vflair,infoF] = ReadData3D();
[VT1,infoT1] = ReadData3D();
[VT2,infoT2] = ReadData3D();
%rotate images for an esier comparing with true file
Vflair=rot90(Vflair);
VT1=rot90(VT1);
VT2=rot90(VT2);

%%
%select a slice of brain (for example 75th slice)
Vflair = mat2gray(Vflair);
Vf = Vflair(:,:,75);

VT1 = mat2gray(VT1);
Vt1 = VT1(:,:,75);

VT2 = mat2gray(VT2);
Vt2 = VT2(:,:,75);
%%

figure;
montage({Vf,Vt2,Vt1},'Size',[1 3]);
pause();
close all;
