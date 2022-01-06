function g = LieGroupSE3(twist)

v = [twist(1);twist(2);twist(3)];
w = [twist(4);twist(5);twist(6)];

w_hat = [0 -w(3) w(2);w(3) 0 -w(1);-w(2) w(1) 0];
w_norm = norm(w);
exp_w_hat = eye(3) + (w_hat/w_norm)*(sind(w_norm)) + ((w_hat*w_hat)/(w_norm*w_norm))*(1-cosd(w_norm));

g12 = ((eye(3)-exp_w_hat)*w_hat*v+w*(w')*v)/(w_norm*w_norm);

g = [exp_w_hat g12;0 0 0 1];

end