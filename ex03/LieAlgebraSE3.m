function twist_l = LieAlgebraSE3(g_l)

g_l(4,:) = []; %delete the last row of g_l

R_l = g_l(:,1:3);
T_l = g_l(:,4);

%reconstuct w
w_angle = acosd((trace(R_l)-1)/2);
w_axis = (1/(2*sind(w_angle)))*[R_l(3,2)-R_l(2,3);R_l(1,3)-R_l(3,1);R_l(2,1)-R_l(1,2)];
w_l = w_angle*w_axis;
w_hat = [0 -w_l(3) w_l(2);w_l(3) 0 -w_l(1);-w_l(2) w_l(1) 0];


%reconstruct v
v_l = (w_angle*w_angle)*inv((eye(3)-R_l)*w_hat+w_l*w_l')*(T_l);

%get twist
twist_l = [v_l;w_l];

end