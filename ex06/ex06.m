%% Get the 2D coordinates of corresponding point pairs
clear all;
%read the images
I1 = imread('batinria0.tif');
I2 = imread('batinria1.tif');
%get the 8 points in the first image
num_p = 12;
x1 = [
   10.0000
   92.0000
    8.0000
   92.0000
  289.0000
  354.0000
  289.0000
  353.0000
   69.0000
  294.0000
   44.0000
  336.0000
  ];

y1 = [ 
  232.0000
  230.0000
  334.0000
  333.0000
  230.0000
  278.0000
  340.0000
  332.0000
   90.0000
  149.0000
  475.0000
  433.0000
    ];
 
x2 = [
  123.0000
  203.0000
  123.0000
  202.0000
  397.0000
  472.0000
  398.0000
  472.0000
  182.0000
  401.0000
  148.0000
  447.0000
    ];

y2 = [ 
  239.0000
  237.0000
  338.0000
  338.0000
  236.0000
  286.0000
  348.0000
  341.0000
   99.0000
  153.0000
  471.0000
  445.0000
    ];

subplot(121);
imshow(I1);
hold on;
%[x1,y1] = ginput(8); %size(x1) = (8,1)
plot(x1,y1,'r+');
title('piture 1');
%get the 8 points in the second image
subplot(122);
hold on;
imshow(I2);
%[x2,y2] = ginput(8);
plot(x2,y2,'r+');
title('picture 2');
%% Implement the 8-point algorithm
%define K1 and K2
K1 = [844.310547 0 243.413315; 0 1202.508301 281.529236; 0 0 1];
K2 = [852.721008 0 252.021805; 0 1215.657349 288.587189; 0 0 1];

%calibrate the coordinates with intrinsic matrix (Capeter 5 slide 25)
%using hormogeneous coordinates (slide 7)
CaliCo1 = K1 \ [x1';y1';ones(1,num_p)];  %calibrated cordinates, A\b = inv(A)*b
x1_ca = CaliCo1(1,:);
y1_ca = CaliCo1(2,:);
z1_ca = CaliCo1(3,:);
CaliCo2 = K2 \ [x2';y2';ones(1,num_p)];  %calibrated cordinates, A\b = inv(A)*b
x2_ca = CaliCo2(1,:);
y2_ca = CaliCo2(2,:);
z2_ca = CaliCo2(3,:);

%calculate chi = kron(x1i,x2i)
for i = 1:num_p
    chi(i,:) =kron([x1_ca(i);y1_ca(i);z1_ca(i)],[x2_ca(i);y2_ca(i);z2_ca(i)]); 
end

%compute the SVD of chi, multiply U,V by -1 if determinant negative
[U,S,V] = svd(chi);  %V是V本身，没有转置

%get Es
Es = V(:,9);
E = reshape(Es,[3,3]); %reshape Es to a 3x3 matrix

%project onto essential space
[UE,SE,VE] = svd(E);
if det(UE) <0
    UE = (-1)*UE;
end
if det(VE) <0
    VE = (-1)*VE;
end

SE = diag([1,1,0]);
E = UE * SE * VE';

%compute R and T_hat
Rz_p = [0 1 0;-1 0 0;0 0 1];
Rz_m = [0 -1 0;1 0 0;0 0 1];
R1 = UE * Rz_p' * VE';
R2 = UE * Rz_m' * VE';
T_hat1 = UE * Rz_p * SE * UE';
T_hat2 = UE * Rz_m * SE * UE';
T1 = [T_hat1(3,2);T_hat1(1,3);T_hat1(2,1)];
T2 = [T_hat2(3,2);T_hat2(1,3);T_hat2(2,1)];

%% Reconstruct the depths of the points
%get 4 different combinations
compute_nam(R1,T1,num_p,x1_ca,y1_ca,z1_ca,x2_ca,y2_ca,z2_ca);
compute_nam(R1,T2,num_p,x1_ca,y1_ca,z1_ca,x2_ca,y2_ca,z2_ca);
compute_nam(R2,T1,num_p,x1_ca,y1_ca,z1_ca,x2_ca,y2_ca,z2_ca);
compute_nam(R2,T2,num_p,x1_ca,y1_ca,z1_ca,x2_ca,y2_ca,z2_ca);



%% functions
%compute the four different combinations of R and T
function [lambda,gamma] = compute_nam(R,T,num_p,x1_ca,y1_ca,z1_ca,x2_ca,y2_ca,z2_ca)
    M = zeros(3*num_p, num_p + 1);
    for i = 1:num_p
        x2_hat = hat([x2_ca(i);y2_ca(i);z2_ca(i)]);
        M(3*i-2 : 3*i, i) = x2_hat*R*[x1_ca(i); y1_ca(i);z1_ca(i)];
        M(3*i-2 : 3*i, num_p+1) = x2_hat*T;
    end
    [V,D] = eig(M'*M);
    D_v = diag(D);
    po = find(D_v == min(D_v));
    lambda = V(1:num_p,po);
    gamma = V(num_p+1,po);

    % Gamma has to be positive. If it is negative, use (-lambda1, -gamma), as
    % it also is a solution for the system solved by (lambda1, gamma)
    if gamma < 0
        gamma = -gamma;
        lambda = -lambda;
    end    
    % make lambda1 have the same scale as T
    lambda = lambda / gamma;
    %compute 3D coordinates
    X1 = [x1_ca;y1_ca;z1_ca] .*repmat(lambda',3,1); %size(3,12), repmat:Repeat copies of array
    X2 = R * X1 + repmat(T,1,num_p);  
    %choose the one with all depths positive
    flag = 0;
    if all(X1(3,:)>=0) && all(X2(3,:)>=0)
        flag = 1;
    end
    if flag == 1
        disp('R =');
        disp(R);
        disp('T =');
        disp(T);
        %plot the 3D points
        figure
        plot3(X1(1,:),X1(2,:),X1(3,:),'b+');
        hold on;
        plotCamera('Location',[0 0 0],'Orientation',eye(3),'Opacity',0, 'Size', 0.2, 'Color', [1 0 0]) % red, the second camera
        plotCamera('Location', -R'*T,'Orientation',R,'Opacity',0, 'Size', 0.2, 'Color', [0 1 0]) % green, the first camera
    end
end

function A = hat(v)
    A = [0 -v(3) v(2) ; v(3) 0 -v(1) ; -v(2) v(1) 0];
end


