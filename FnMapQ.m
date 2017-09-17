function [MapQ,VsBaru] = FnMapQ(IG,Vs,baris,kolom,w,T)

% Count value of VL
[VL,VLmax,VLmaxIndex] = FnVL(IG,Vs,baris,kolom,w);

% Find VLmax and index it
% [VLmax,VLmaxIndex]=max(VL');

% penambah_teta_x dan penambah_teta_y
% column 1 = 0 degree, column 2 = 180 degree
% column 3 = 90 degree, column 4 = 270 degree
% column 5 = 45 degree, column 6 = 225 degree
% column 7 = 315 degree, column 8 = 135 degree
penambah_teta_x=[1 -1 0 0 1 -1 1 -1];
penambah_teta_y=[0 0 1 -1 1 -1 -1 1];

% Find VL > T
maxVLIndex=find(VLmax>T);

% convert Index to XY
[Vsx,Vsy] = Index2XY(Vs,baris);

%================================================================
% VcxTerpilih1 & VcyTerpilih1 ( selected candidates, cause > T )
%================================================================
VcxTerpilih1=Vsx(maxVLIndex)';
VcyTerpilih1=Vsy(maxVLIndex)';

% Find element VcxTerpilih1 & VcyTerpilih1 that Out of Index
VcxTerpilih1OutIndex=find(VcxTerpilih1<1 | VcxTerpilih1>baris);
VcyTerpilih1OutIndex=find(VcyTerpilih1<1 | VcyTerpilih1>kolom);

VcxyTerpilih1OutIndex=union(VcxTerpilih1OutIndex,VcyTerpilih1OutIndex);

% Remove element VcxTerpilih1 & VcyTerpilih1 that Out Of Index
VcxTerpilih1(VcxyTerpilih1OutIndex)=[];
VcyTerpilih1(VcxyTerpilih1OutIndex)=[];

% convert XY to Index
MapQ = XY2Index(VcxTerpilih1,VcyTerpilih1,baris);

% update value of confidence matrix
% for Map Quatization
% Cw(MapQ)=Cw(MapQ)+1;
% Cw(MapQ00)=Cw(MapQ00)+1;

%================================================================
% VcxTerpilih2 & VcyTerpilih2 ( selected candidates by tracking )
%================================================================
VcxTerpilih2=Vsx(maxVLIndex)'+penambah_teta_x(VLmaxIndex(maxVLIndex))';
VcyTerpilih2=Vsy(maxVLIndex)'+penambah_teta_y(VLmaxIndex(maxVLIndex))';

% Find element VcxTerpilih2 & VcyTerpilih2 that Out of Index
VcxTerpilih2OutIndex=find(VcxTerpilih2<1 | VcxTerpilih2>baris);
VcyTerpilih2OutIndex=find(VcyTerpilih2<1 | VcyTerpilih2>kolom);

VcxyTerpilih2OutIndex=union(VcxTerpilih2OutIndex,VcyTerpilih2OutIndex);

% length(VcxyTerpilih2OutIndex)
% 
% length(VcxTerpilih2)-length(VcxyTerpilih2OutIndex)

% Remove element VcxTerpilih2 & VcyTerpilih2 that Out Of Index
VcxTerpilih2(VcxyTerpilih2OutIndex)=[];
VcyTerpilih2(VcxyTerpilih2OutIndex)=[];

% convert XY to Index
VsBaru = XY2Index(VcxTerpilih2,VcyTerpilih2,baris);