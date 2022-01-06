function w_l = LieAlgebraSO3(R_l)

w_angle = acosd((trace(R_l)-1)/2);

w_axis = (1/(2*sind(w_angle)))*[R_l(3,2)-R_l(2,3);R_l(1,3)-R_l(3,1);R_l(2,1)-R_l(1,2)];

w_l = w_angle*w_axis;

end