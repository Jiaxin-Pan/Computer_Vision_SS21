function twoDprojection(n)
%load the model
close all;
[X0,F] = openOFF('model.off', '');

%define the parameters
f = 540;
ox = 320;
oy = 240;
sx = 1;
sy = 1;
sthe = 0;
T = [-0.5;-0.5;1];
R = eye(3);

%compute the intrinsic parameter matrix K
K = [f*sx f*sthe ox;0 f*sy oy;0 0 1];

%homogeneous coordinates for X0
Xt = transpose(X0);
Xt = [Xt;ones(1,length(X0))]; 

%shift the coordinates, cut 4th coordinate
g = [R T];
Xt = g*Xt;    


%compute the coordinates
if n == 2                                %1(b)
    X1 = (K(1:2,:)*Xt)./(K(3,:)*Xt);
elseif n == 3                            %1(c)
    Xt = [Xt(1:2,:);ones(1,length(X0))];   %set z to 1
    X1 = (K(1:2,:)*Xt)./(K(3,:)*Xt);
end


%draw the projection
axis equal, axis([0 640 0 480]-0.5)
patch('Vertices', X1', 'Faces', F);
title('2D projection');
end




