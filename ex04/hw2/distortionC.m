function distortionC(Kd,Kn)
%img2 as input image
Id = im2double(imread('img2.jpg')); %480*752*3
Id = rgb2gray(Id);          %480*752
Id = transpose(Id); 
g_pol = @(r) 1 - 0.3407*r + 0.057*r.^2 - 0.0046*r.^3 + 0.00014*r.^4;  %define the function

%project the new coordinate to the distorted one
px = zeros(1024,1);
py = zeros(768,1);
ps = zeros(1024,768);
for u = 1:1:1024
    for v =1:1:768
        piX = inv(Kn)*[u;v;1];
        piX(3,:) = [];
        np = norm(piX);           
        p = Kd*[g_pol(np)*piX;1];
        px(u) = round(p(1));
        py(v) = round(p(2));
        %if out of the distorted coordinates, then black
        if px(u)>=1 &&  px(u)<= 752 && py(v)>=1 && py(v)<=480
            ps(u,v) = Id(px(u),py(v));
        else
            ps(u,v) = 0;
        end
    end
end

ps = transpose(ps);
%interpolation
In = imresize(ps,1,'bicubic');

%display the images
subplot(121);
Id = transpose(Id);
imshow(Id);
axis on;
title('original image');
subplot(122)
imshow(In);
axis on;
title('distorted image');
end