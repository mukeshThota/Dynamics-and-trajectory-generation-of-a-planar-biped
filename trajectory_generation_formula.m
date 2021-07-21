function [A1 , A2]  = trajectory_generation_formula(theta1_o,theta1_od,theta1_odd,theta1_f,theta1_fd,theta1_fdd,theta2_o,theta2_od,theta2_odd,theta2_f,theta2_fd,theta2_fdd, tf )
A1(1) = theta1_o;
A1(2) = theta1_od;
A1(3) = theta1_odd/2;
A1(4) = (20*((theta1_f)-(theta1_o)) - (8*(theta1_fd) + 12*(theta1_od))*tf -(3*(theta1_odd) - (theta1_fdd))*tf^2)/(2*tf^3);
A1(5) = (30*((theta1_o)-(theta1_f)) + (14*(theta1_fd) + 16*(theta1_od))*tf + (3*(theta1_odd)- 2*(theta1_fdd))*tf^2)/(2*tf^4);
A1(6) = (12*((theta1_f)-(theta1_o)) - 6*((theta1_fd)+(theta1_od))*tf - ((theta1_odd) - (theta1_fdd))*tf^2)/(2*tf^5);
   
A2(1) = theta2_o;
A2(2) = theta2_od;
A2(3) = theta2_odd/2;
A2(4) = (20*((theta2_f)-(theta2_o)) - (8*(theta2_fd) + 12*(theta2_od))*tf -(3*(theta2_odd) - (theta2_fdd))*tf^2)/(2*tf^3);
A2(5) = (30*((theta2_o)-(theta2_f)) + (14*(theta2_fd) + 16*(theta2_od))*tf + (3*(theta2_odd)- 2*(theta2_fdd))*tf^2)/(2*tf^4);
A2(6) = (12*((theta2_f)-(theta2_o)) - 6*((theta2_fd)+(theta2_od))*tf - ((theta2_odd) - (theta2_fdd))*tf^2)/(2*tf^5);
 
end




