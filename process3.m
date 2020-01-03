function [saliency,smooth] = process3 (Vabc1)
%create an empty 3D matrix (256*256)
Vb = cat(3, zeros(256), zeros(256), zeros(256) );
%%
%Save the initial image size
x=length(Vabc1(:,1,1));
y=length(Vabc1(1,:,1));
%Assign the content of the Lab image (Vabc1 with size(x*y)) to the new variable
%Vb (remembering that its size is 256*256).X and y must be lower than 256! 
for i = 1:x
    for j = 1:y
        Vb(i,j,1)=Vabc1(i,j,1);
        Vb(i,j,2)=Vabc1(i,j,2);
        Vb(i,j,3)=Vabc1(i,j,3);
    end
end
%%
%k=4 Create a matrix of little square
k=4;
num=256/k;
fprintf('%d..\n',num*num);
quad=num*num;
%cut the work variable Vb into "quad" (in this case 4096) squares 
%create an element (Vpatch4) containing "k" squares scrollable by the third parameter.
%Every square has 3 channels scrollable by the second parameter.
%First parameter select a single square (:,:) or a single pixel (i,j)

%This process is applied for all k values
%{
%first dimension of the first channel
Vpatch4(:,:,1,1)=
0     0     0     0
0     0     0     0
0     0     0     0
0     0     0     0
%second dimension of the first channel
Vpatch4(:,:,1,2)=
0     0     0     0
0     0     0     0
0     0     0     0
0     0     0     0
%third dimension of the first channel
Vpatch4(:,:,1,3)=
0     0     0     0
0     0     0     0
0     0     0     0
0     0     0     0
%}
pos=0;
for z = 1:num
    for w = 1:num
        pos=pos+1;
        for i = 1:k
            for j = 1:k
                %Every pixels is assigned to the appropriate square for all
                %channels
                Vpatch4(i,j,1,pos)=Vb(i+((w-1)*k),j+((z-1)*k),1);
                Vpatch4(i,j,2,pos)=Vb(i+((w-1)*k),j+((z-1)*k),2);
                Vpatch4(i,j,3,pos)=Vb(i+((w-1)*k),j+((z-1)*k),3);
            end
        end
        %To verify the correct cut you can show here for example the L channel of the "pos" square
        %imsshow(Vpatch4(:,:,1,pos))
    end
end
%%
%k=8
k=8;
num=256/k;
fprintf('%d..\n',num*num);
quad=num*num;
pos=0;
for z = 1:num
    for w = 1:num
        pos=pos+1;
        for i = 1:k
            for j = 1:k
                Vpatch8(i,j,1,pos)=Vb(i+((w-1)*k),j+((z-1)*k),1);
                Vpatch8(i,j,2,pos)=Vb(i+((w-1)*k),j+((z-1)*k),2);
                Vpatch8(i,j,3,pos)=Vb(i+((w-1)*k),j+((z-1)*k),3);
            end
        end
    end
end
%%
%k=16
k=16;
num=256/k;
fprintf('%d..\n',num*num);
quad=num*num;
pos=0;
for z = 1:num
    for w = 1:num
        pos=pos+1;
        for i = 1:k
            for j = 1:k
                Vpatch16(i,j,1,pos)=Vb(i+((w-1)*k),j+((z-1)*k),1);
                Vpatch16(i,j,2,pos)=Vb(i+((w-1)*k),j+((z-1)*k),2);
                Vpatch16(i,j,3,pos)=Vb(i+((w-1)*k),j+((z-1)*k),3);
            end
        end
    end
end
%%
%k=32
k=32;
num=256/k;
fprintf('%d..\n',num*num);
quad=num*num;
pos=0;
for z = 1:num
    for w = 1:num
        pos=pos+1;
        for i = 1:k
            for j = 1:k
                Vpatch32(i,j,1,pos)=Vb(i+((z-1)*k),j+((w-1)*k),1);
                Vpatch32(i,j,2,pos)=Vb(i+((z-1)*k),j+((w-1)*k),2);
                Vpatch32(i,j,3,pos)=Vb(i+((z-1)*k),j+((w-1)*k),3);
            end
        end
    end
end

[saliency,smooth]=process4(Vabc1,Vpatch4,Vpatch8,Vpatch16,Vpatch32);
end