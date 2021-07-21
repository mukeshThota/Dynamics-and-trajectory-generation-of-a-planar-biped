r_12_in1 =[20;0;0] ;
r_23_in2 =[20;0;0] ;
%r_3F_in3 =[20;0;0] ;


H_B1 = @(alpha,beta)[ R_B1(alpha,beta),       r_B1_inB;
         0, 0, 0,    1];
H_12 =@(alpha,beta) [ R_12(alpha,beta),       r_12_in1;
         0, 0, 0,    1];
%H_23 = @(alpha,beta)[ R_23(alpha,beta),       r_23_in2;
 %        0, 0, 0,    1];

% create the cumulative transformation matrix
H_B3 =@(alpha,beta)(H_B1(alpha,beta)*H_12(alpha,beta));
r_BF_inB= 