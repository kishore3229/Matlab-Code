function [VL,VLmax,VLmaxIndex] = FnVL(IG,Vs,baris,kolom,w)

% Initialization VL
% column 1 = 0 degree, column 2 = 180 degree
% column 3 = 90 degree, column 4 = 270 degree
% column 5 = 45 degree, column 6 = 225 degree
% column 7 = 315 degree, column 8 = 135 degree
VL=ones(length(Vs),8);

% for angle 0 degree
bac1 = Fnbac122cand(IG,Vs,baris,kolom,1,w);
bac2 = Fnbac122cand(IG,Vs,baris,kolom,1,-w);
cand = 2*Fnbac122cand(IG,Vs,baris,kolom,1,0);
VL(:,1)=bac1+bac2-cand;

% for angle 180 degree
bac1 = Fnbac122cand(IG,Vs,baris,kolom,-1,w);
bac2 = Fnbac122cand(IG,Vs,baris,kolom,-1,-w);
cand = 2*Fnbac122cand(IG,Vs,baris,kolom,-1,0);
VL(:,2)=bac1+bac2-cand;

% for angle 90 degree
bac1 = Fnbac122cand(IG,Vs,baris,kolom,w,1);
bac2 = Fnbac122cand(IG,Vs,baris,kolom,-w,1);
cand = 2*Fnbac122cand(IG,Vs,baris,kolom,0,1);
VL(:,3)=bac1+bac2-cand;

% for angle 270 degree
bac1 = Fnbac122cand(IG,Vs,baris,kolom,w,-1);
bac2 = Fnbac122cand(IG,Vs,baris,kolom,-w,-1);
cand = 2*Fnbac122cand(IG,Vs,baris,kolom,0,-1);
VL(:,4)=bac1+bac2-cand;

% for angle 45 degree
bac1 = Fnbac122cand(IG,Vs,baris,kolom,(1+w),(1-w));
bac2 = Fnbac122cand(IG,Vs,baris,kolom,(1-w),(1+w));
cand = 2*Fnbac122cand(IG,Vs,baris,kolom,1,1);
VL(:,5)=bac1+bac2-cand;

% for angle 225 degree
bac1 = Fnbac122cand(IG,Vs,baris,kolom,(w-1),-(1+w));
bac2 = Fnbac122cand(IG,Vs,baris,kolom,-(1+w),(w-1));
cand = 2*Fnbac122cand(IG,Vs,baris,kolom,-1,-1);
VL(:,6)=bac1+bac2-cand;

% for angle 315 degree
bac1 = Fnbac122cand(IG,Vs,baris,kolom,(1+w),(w-1));
bac2 = Fnbac122cand(IG,Vs,baris,kolom,(1-w),-(1+w));
cand = 2*Fnbac122cand(IG,Vs,baris,kolom,1,-1);
VL(:,7)=bac1+bac2-cand;

% for angle 135 degree
bac1 = Fnbac122cand(IG,Vs,baris,kolom,(w-1),(w+1));
bac2 = Fnbac122cand(IG,Vs,baris,kolom,-(1+w),(1-w));
cand = 2*Fnbac122cand(IG,Vs,baris,kolom,-1,1);
VL(:,8)=bac1+bac2-cand;

% Looking VLmax and index
[VLmax,VLmaxIndex]=max(VL');
