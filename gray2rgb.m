function [I]=gray2rgb(Image)
[m n]=size(Image);
rgb=zeros(m,n,3);
rgb(:,:,1)=Image;
rgb(:,:,2)=rgb(:,:,1);
rgb(:,:,3)=rgb(:,:,1);
I=uint8((rgb/255)*255);
end
 