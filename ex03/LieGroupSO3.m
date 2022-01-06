function R = LieGroupSO3(w)

w_hat = [0 -w(3) w(2);w(3) 0 -w(1);-w(2) w(1) 0];

w_norm = norm(w);

R = eye(3) + (w_hat/w_norm)*(sind(w_norm)) + ((w_hat*w_hat)/(w_norm*w_norm))*(1-cosd(w_norm));
end

