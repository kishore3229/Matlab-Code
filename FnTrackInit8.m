function [GreenChannel,AreaTrackingWhite,AreaTrackingGray,Vs,AreaTrackingWhite2,VsModif,dilateEdge] = FnTrackInit8(LS,Property) 

if(Property==1) % if the input is rgb image
  I=imresize(LS, 1);
  IG=I(:,:,2);  
elseif(Property==2) % if the input is  grayscale image
  IG=LS;
elseif(Property==3) % if the input is rgb at interval [0..1]
  IG=uint8(LS*255);
end

% preprosesing 
edgeRetina = edge(IG,'sobel',0.15);
% figure, imshow(edgeRetina);
se = strel('disk',5);
dilateEdge = imdilate(edgeRetina, se);

GreenChannel=IG;

% GreenChannel=adapthisteq(GreenChannel);

% IG=rgbImage;
[baris,kolom]=size(IG);
[counts,x] = imhist(IG,256);
bykPixel = baris*kolom;

% Initialization Tlow and Thigh base counting total pixel
TlowProsen = 0;
ThighProsen = 100;
jmlPixTlow = floor((TlowProsen/100)*bykPixel); % round don
jmlPixThigh = bykPixel - ceil((ThighProsen/100)*bykPixel); % round up

% count from front
jmlPix=0;
index1=1;
while(jmlPix<jmlPixTlow)
    jmlPix=jmlPix+counts(index1);
    index1=index1+1;
end
TlowI = x(index1);

% count from back
jmlPix=0;
index2=256;
while(jmlPix<jmlPixThigh)
    jmlPix=jmlPix+counts(index2);
    index2=index2-1;
end
ThighI = x(index2);

% Initialization matrix
IG_1=zeros(baris,kolom);
IG_2=IG;
IG_3=zeros(baris,kolom);

% subplot(2,4,4); imshow(IG_1); title('Chanel Vs (White)');

% Determine length of Vs
Vs=find(IG<=ThighI & IG>=TlowI); % Save index IG that satisfy find logic
elseVs1=find(IG<TlowI); % Save index IG that satisfy find logic
elseVs2=find(IG>ThighI); % Save index IG that satisfy find logic
IG_1(Vs)=IG_1(Vs)+1;

IG_2(elseVs1)=IG_2(elseVs1)*0; 
IG_2(elseVs2)=IG_2(elseVs2)*0;

AreaTrackingWhite=IG_1;
AreaTrackingGray=IG_2;

VsModif=Vs;

IG_3(VsModif)=IG_3(VsModif)+1;
AreaTrackingWhite2=IG_3;