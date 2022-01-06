function distortionB(Id,Kd,Kn)
%input: Id = imread('img1.jpg');
Id = transpose(Id);   %752*480
w = 0.92646;
g_ATAN_1 = @(r) (1./(w*r) .* atan(2*tan(w/2)*r));  %definet the function

%project the new coordinate to the distorted one
px = zeros(1024,1);
py = zeros(768,1);
ps = zeros(1024,768);
for u = 1:1:1024
    for v =1:1:768
        piX = inv(Kn)*[u;v;1];
        piX(3,:) = [];
        np = norm(piX);           
        p = Kd*[g_ATAN_1(np)*piX;1];
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

