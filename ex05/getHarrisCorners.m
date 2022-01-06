function [score, points] = getHarrisCorners(I, sigma, kappa, theta)
%input: I = imreadbw('img1.png');

[M11, M12, M22] = getM(I, sigma);

% TODO: compute score using det and trace
detM = M11.*M22 - M12.*M12;
traM = M11+M22;
C = detM - kappa*(traM.^2);

% TODO: display score
%imagesc(C); ²ÊÉ«
%imshow(C); ºÚ°×
imagesc(sign(C).*((abs(C)).^(1/4)));
title('score function');
score = C;

% TODO: find corners (variable points)
%points = islocalmax(C);
C = islocalmax(C,1)&islocalmax(C,2)&(C>theta);
[py,px]= find(C==1); %return [rows,cols]
points = [px py];
end

