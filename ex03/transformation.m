function Vr = transformation(x,y,z,T,V)
%call with 
%TT = [0.5;0.2;1];
%V: the model
%Vr = rotation(0,0,0,TT,V);

%transfer the points to homogenious coordinates
l = length(V);
Vt = transpose(V); %Vt(3,19105)


%define the transfomation matrix
Rx = [1 0 0;0 cosd(x) -sind(x);0 sind(x) cosd(x)];
Ry = [cosd(y) 0 sind(y);0 1 0;-sind(y) 0  cosd(y)];
Rz = [cosd(z) -sind(z) 0;sind(z) cosd(z) 0;0 0 1];
R = Rx*Ry*Rz;
%R = [R zeros(3,1)]; %no translation
Tr = [R T];
Tr = [Tr; 0,0,0,1];    %transformation matrix with T=0

%define the translation matrix
mean_V = mean(Vt,2); %get the mean point
Tc = -mean_V;

%translate the center to origin
Vt = Vt + Tc;
Vt = [Vt;ones(1,l)];

%perform the transformation
Vr = Tr*Vt;

%translate back
Vr(4,:) = [];       %Vr(19105,3)
Vr = Vr - Tc;

%transpose and delete the last row
Vr = transpose(Vr); %Vr(19105,4)


%display


end
