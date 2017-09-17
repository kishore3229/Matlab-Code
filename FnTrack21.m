function LineTracking = FnTrack21(IG,Vs,dilateEdge)

tic

[baris,kolom]=size(IG);
[m,n]=size(IG);
Cw=zeros(baris,kolom);

Ts=length(Vs);

% set value of T,k dan r
T=15;
r=1;

% Set with dynamic of W
InitScale=3;
Wstep=2;
FinScale=11;

% Set for waitbar
Counter=ceil(FinScale/InitScale)+1;
CounterLoop=0;
    
hWB = waitbar(0,'Please wait...');

for W=InitScale:Wstep:FinScale
sprintf('W = %d%.3f%%',W)
w=(W-1)/2;

[MapQPikselAwal,VsBaru] = FnMapQ(IG,Vs,baris,kolom,w,T);

% Update value of confidence matrix from MapQPikselAwal
Cw(MapQPikselAwal)=Cw(MapQPikselAwal)+1;

% MapQPikselBaru called as new pixel tracking
% and VsBaru not used again, Cause already represented by process
% MapQPikselAwal
[MapQPikselBaru,VsBaru] = FnMapQ(IG,VsBaru,baris,kolom,w,T);

% Update value of confidence matrix from MapQPikselBaru
Cw(MapQPikselBaru)=Cw(MapQPikselBaru)+1;

CounterLoop=CounterLoop+1;
waitbar(CounterLoop/Counter);

end

close(hWB);
% delete(hWB);
t = toc/60

% map quantization
MapQ1=find(Cw>=fix(FinScale/InitScale));
MapQ2=find(Cw<fix(FinScale/InitScale));

% MapQ1=find(Cw==1);
% MapQ2=find(Cw==0);
Cw(MapQ1)=Cw(MapQ1)*0+1;
Cw(MapQ2)=Cw(MapQ2)*0;

% Save Result of line tracking
LineTracking=Cw;

Bw=Cw;

% postprosesing
%%%%%%%%%%%%%%(remove edge)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BwTanpaEdge=zeros(m,n);
edgeRetinaPth = find(dilateEdge>0);
edgeRetinaHtm = find(dilateEdge<1);
BwTanpaEdge(edgeRetinaPth) = Bw(edgeRetinaPth)*0;
BwTanpaEdge(edgeRetinaHtm) = Bw(edgeRetinaHtm)*0+Bw(edgeRetinaHtm);

% -----------------(median filtering)-------------------
Bw2 = medfilt2(BwTanpaEdge);
% figure, imshow(Bw2);
% -----------------(morphological directional filtering)--
%%%%%%%%%%%angle 0 degree%%%%%%%%%%%%%%%%%%
se = strel('line',3, 0);
hslOp1 = imopen(Bw2, se);

%%%%%%%%%%%angle 30 degree%%%%%%%%%%%%%%%%%%
se = strel('line',3, 30);
hslOp2 = imopen(Bw2, se);

%%%%%%%%%%%angle 60 degree%%%%%%%%%%%%%%%%%%
se = strel('line',3, 60);
hslOp3 = imopen(Bw2, se);

%%%%%%%%%%%angle 120 degree%%%%%%%%%%%%%%%%%%
se = strel('line',3, 120);
hslOp4 = imopen(Bw2, se);

%%%%%%%%%%%angle 150 degree%%%%%%%%%%%%%%%%%%
se = strel('line',3, 150);
hslOp5 = imopen(Bw2, se);

%%%%%%%%%%%%%OR%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[brsHslOp,KolHslOp] = size(hslOp1);
hslOp = hslOp1+hslOp2+hslOp3+hslOp4+hslOp5;
% figure, imshow(hslOp);
se2 = strel('disk',2);
marker = imerode(hslOp, se2);
mask = hslOp;
Bw3 = imreconstruct(marker, mask);
figure, imshow(Bw3);  title('Best Result Map Quantization Without Masking');