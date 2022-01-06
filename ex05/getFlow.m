function [vx, vy] = getFlow(I1, I2, sigma)

[M11, M12, M22, q1, q2] = getMq(I1, I2, sigma);

% TODO calc flow (w/o loop).
vx = (M12.*q2-M22.*q1)./(M11.*M22-M12.*M12);
vy = (M11.*q2-M12.*q1)./(M12.*M12-M11.*M22);

%display the velocities
subplot(221);
imagesc(vx);
axis image;
title('vx');

subplot(222);
imagesc(vy);
axis image;
title('vy');

subplot(223);
quiver(vx,vy,0);  % 0: true scale;
%quiver: plots arrows with directional components specified by vx and vy;
axis image;
title('directions');

end

