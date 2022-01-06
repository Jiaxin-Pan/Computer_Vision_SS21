 function  [M11,M12,M22] = getM(I,sigma)
%input: I = imreadbw('img1.png');
%[Ix1,Iy1] = imgradientxy(I,'central');  %returns the directional gradients using cental differences

% Compute the image gradients Ix and Iy using central differences.
    % Ix = (I(y, x + 1) - I(y, x - 1)) / 2
    % Iy = (I(y + 1, x) - I(y - 1, x)) / 2
Ix = (I(:, [2:end end]) - I(:,[1 1:end-1])) ./ 2;
Iy = (I([2:end end], :) - I([1 1:end-1], :)) ./ 2;
%[2:end end]表示先取第二到最后一列 右边再加上最后一列，相当于2 3。。。639 640 640

%weighting function
G = fspecial('gaussian',ceil(4 * sigma)+1,sigma);
%ceil(t) rounds each element of X to the nearest integer greater than or equal to that element.

%compute M11, M12, M22 with conv2
M11 = conv2((Ix.*Ix),G,'same');   %output will be the same size as (Ix.*Ix)
M12 = conv2((Ix.*Iy),G,'same');
M22 = conv2((Iy.*Iy),G,'same');
%M21 is the same as M12

end