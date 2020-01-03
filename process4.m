function [saliency,smooth]=process4(Vabc1,Vpatch4,Vpatch8,Vpatch16,Vpatch32)
%calculate the mean value of all square k=4
k=4;
num=256/k;
fprintf('%d..\n',num*num);
quad=num*num;
%define 3 matrix num*num containing the mean value of each channel
meanL4=cat(3,zeros(num));
meanA4=cat(3,zeros(num));
meanB4=cat(3,zeros(num));
for pos = 1 : quad
    for i = 1:k
        for j = 1:k
            %sum each pixel of square "pos"
            %"pos" is the index used to scrool all patches
            meanL4(pos)=meanL4(pos)+Vpatch4(i,j,1,pos);
            meanA4(pos)=meanL4(pos)+Vpatch4(i,j,2,pos);
            meanB4(pos)=meanL4(pos)+Vpatch4(i,j,3,pos);
        end
    end
    %calculate the mean value of each square and assign this value to the
    %"pos" element of all matrix
    meanL4(pos)=meanL4(pos)/(k*k);
    meanA4(pos)=meanA4(pos)/(k*k);
    meanB4(pos)=meanB4(pos)/(k*k);
end

SAL4=cat(3,zeros(num));
%The two cycles guided by w and z are used to hold the patch that you
%want to compute the salience
%Other two cycles scroll all patches every time
for w = 1 :num
    for z = 1:num
        for i = 1 :num
            for j = 1:num
                %Distance is computed every time between the
                %patch that you want to compute salience and the patch you are comparing
                %EXAMPLE
                %|patch1||patch2||patch3|
                %I chose the distance between "patch1" and "patch3" to be 2. 
                %So I used a distance NOT in terms of pixels. 
                %If you need the pixels distance, you have to simply multiply this term by k
                d=sqrt((w-i)^2+(z-j)^2);
                %Salience depends also on the chromatic distance of the
                %compared patches
                sal4=sqrt((meanL4(w,z)-meanL4(i,j))^2+(meanA4(w,z)-meanA4(i,j))^2+(meanB4(w,z)-meanB4(i,j))^2);
                sal4=sal4/(1+d);
                %Finally I add to the summation this term of salience relative to the (w,z) patch
                SAL4(w,z)=SAL4(w,z)+sal4;
            end
        end
    end
end

%keep in memory the initial size of image using to come back to the
%previous size
x=length(Vabc1(:,1,:));
y=length(Vabc1(1,:,:));
%%
%calculate the mean value of all square k=8
k=8;
num=256/k;
fprintf('%d..\n',num*num);
quad=num*num;
meanL8=cat(3,zeros(num));
meanA8=cat(3,zeros(num));
meanB8=cat(3,zeros(num));
for pos = 1 : quad
    for i = 1:k
        for j = 1:k
            meanL8(pos)=meanL8(pos)+Vpatch8(i,j,1,pos);
            meanA8(pos)=meanL8(pos)+Vpatch8(i,j,2,pos);
            meanB8(pos)=meanL8(pos)+Vpatch8(i,j,3,pos);
        end
    end
    meanL8(pos)=meanL8(pos)/(k*k);
    meanA8(pos)=meanA8(pos)/(k*k);
    meanB8(pos)=meanB8(pos)/(k*k);
end

SAL8=cat(3,zeros(num));
for w = 1 :num
    for z = 1:num
        for i = 1 :num
            for j = 1:num
                d=sqrt((w-i)^2+(z-j)^2);
                sal8=sqrt((meanL8(w,z)-meanL8(i,j))^2+(meanA8(w,z)-meanA8(i,j))^2+(meanB8(w,z)-meanB8(i,j))^2);
                sal8=sal8/(1+d);
                SAL8(w,z)=SAL8(w,z)+sal8;
            end
        end
    end
end
%%
%calculate the mean value of all square k=16
k=16;
num=256/k;
fprintf('%d..\n',num*num);
quad=num*num;
meanL16=cat(3,zeros(num));
meanA16=cat(3,zeros(num));
meanB16=cat(3,zeros(num));
for pos = 1 : quad
    for i = 1:k
        for j = 1:k
            meanL16(pos)=meanL16(pos)+Vpatch16(i,j,1,pos);
            meanA16(pos)=meanL16(pos)+Vpatch16(i,j,2,pos);
            meanB16(pos)=meanL16(pos)+Vpatch16(i,j,3,pos);
        end
    end
    meanL16(pos)=meanL16(pos)/(k*k);
    meanA16(pos)=meanA16(pos)/(k*k);
    meanB16(pos)=meanB16(pos)/(k*k);
end

SAL16=cat(3,zeros(num));
for w = 1 :num
    for z = 1:num
        for i = 1 :num
            for j = 1:num
                d=sqrt((w-i)^2+(z-j)^2);
                sal16=sqrt((meanL16(w,z)-meanL16(i,j))^2+(meanA16(w,z)-meanA16(i,j))^2+(meanB16(w,z)-meanB16(i,j))^2);
                sal16=sal16/(1+d);
                SAL16(w,z)=SAL16(w,z)+sal16;
            end
        end
    end
end
%%
%calculate the mean value of all square k=32
k=32;
num=256/k;
fprintf('%d..\n',num*num);
quad=num*num;
meanL32=cat(3,zeros(num));
meanA32=cat(3,zeros(num));
meanB32=cat(3,zeros(num));
for pos = 1 : quad
    for i = 1:k
        for j = 1:k
            meanL32(pos)=meanL32(pos)+Vpatch32(i,j,1,pos);
            meanA32(pos)=meanL32(pos)+Vpatch32(i,j,2,pos);
            meanB32(pos)=meanL32(pos)+Vpatch32(i,j,3,pos);
        end
    end
    meanL32(pos)=meanL32(pos)/(k*k);
    meanA32(pos)=meanA32(pos)/(k*k);
    meanB32(pos)=meanB32(pos)/(k*k);
end

SAL32=cat(3,zeros(num));
for w = 1 :num
    for z = 1:num
        for i = 1 :num
            for j = 1:num
                d=sqrt((w-i)^2+(z-j)^2);
                sal32=sqrt((meanL32(w,z)-meanL32(i,j))^2+(meanA32(w,z)-meanA32(i,j))^2+(meanB32(w,z)-meanB32(i,j))^2);
                sal32=sal32/(1+d);
                SAL32(w,z)=SAL32(w,z)+sal32;
            end
        end
    end
end
%%
%resize all saliency maps to the original size using bilinear interpolation
sal4 = bilinearInterpolation(SAL4, [256 256]);
sal8 = bilinearInterpolation(SAL8, [256 256]);
sal16 = bilinearInterpolation(SAL16, [256 256]);
sal32 = bilinearInterpolation(SAL32, [256 256]);
saliency=cat(3,zeros(256));
smooth=cat(3,zeros(256));
%%
%cut the added pixels
sal4 = sal4(1:x,1:y);
sal8 = sal8(1:x,1:y);
sal16 = sal16(1:x,1:y);
sal32 = sal32(1:x,1:y);
saliency=saliency(1:x,1:y);
smooth=smooth(1:x,1:y);
%%
%make the weighted sum of the different saliency maps
saliency=saliency+sal4/4;
saliency=saliency+sal8/4;
saliency=saliency+sal16/4;
saliency=saliency+sal32/4;
%create the smoothed version of the saliency map
smooth=medfilt2(saliency, [25 25]);
return;
end