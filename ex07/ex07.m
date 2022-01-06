%% Extract the images and get a point p
I1 = imread('batinria0.pgm');
I2 = imread('batinria1.pgm');
[w,h] = size(I2);
%% compute the fundamental matrix
K1 = [844.310547 0 243.413315;0 1202.508301 281.529236;0 0 1];
K2 = [852.721008 0 252.021805;0 1215.657349 288.587189;0 0 1];

%compute R and T
R1 = [0.655133 0.031153 0.754871;0.003613 0.999009 -0.044364;-0.755505 0.031792 0.654371];
T1 = [-793.848328; 269.264465; -744.572876];
Tr1 = [R1 T1;0 0 0 1];

R2 = [0.739514 0.034059 0.672279;-0.006453 0.999032 -0.043515;-0.673111 0.027841 0.739017];
T2 = [-631.052917; 270.192749; -935.050842];
Tr2 = [R2 T2;0 0 0 1];

Tr12 = inv(Tr1)*Tr2; % 1->0, 0->2 => 1->2
R12 = Tr12(1:3,1:3);
T12 = Tr12(1:3,4);
T12_h = hat(T12);

%compute F
F = inv(K2)'*T12_h*R12*inv(K1);

%% pick the point,compute the epipolar line and draw in image2
%pick the point
subplot(121);
imshow(I1);
hold on;
[x,y] = ginput(1);
plot(x,y,'r+');
title('piture 1');

%compute epipolar line
l2 = F*[x;y;1]; 
% l2 is the coimage: l2.T*[x;y;1] = 0  => l2(1)x+l2(2)y+l2(3)=0

%draw in image2
subplot(122);
hold on;
imshow(I2);
m = -l2(1)/l2(2);
b = -l2(3)/l2(2);
y1 = m * 1 + b;
y2 = m * w + b;
line([1 w],[y1 y2]);
title('picture 2');
%% functions
function A = hat(v)
    A = [0 -v(3) v(2) ; v(3) 0 -v(1) ; -v(2) v(1) 0];
end
