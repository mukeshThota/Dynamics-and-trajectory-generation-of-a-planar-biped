alpha = sym('alpha','real');
beta = sym('beta','real');
%gamma = sym('gamma','real');

R_B1 = @(alpha,beta)[...
   cos(alpha), -sin(alpha),          0;
    sin(alpha), cos(alpha), 0;
    0,          0, 1];

R_12 = @(alpha,beta)[...
   cos(beta), -sin(beta),          0;
    sin(beta), cos(beta), 0;
    0,          0, 1];

%R_23 =  @(alpha,beta,gamma)[...
%  cos(gamma), -sin(gamma),          0;
%  sin(gamma), cos(gamma), 0;
% 0,          0, 1];


r_B1_inB =[0;0;0];
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
% find the foot point position vector
r_BF_inB =@(alpha,beta,gamma) [40*cos(alpha) - 40*sin(alpha)*sin(beta) - 40*cos(gamma)*(sin(alpha)*sin(beta) - cos(alpha)*cos(beta)) - 40*sin(gamma)*(cos(alpha)*sin(beta) + cos(beta)*sin(alpha)) + 40*cos(alpha)*cos(beta);40*sin(alpha) + 40*cos(gamma)*(cos(alpha)*sin(beta) + cos(beta)*sin(alpha)) - 40*sin(gamma)*(sin(alpha)*sin(beta) - cos(alpha)*cos(beta)) + 40*cos(alpha)*sin(beta) + 40*cos(beta)*sin(alpha);0;1];
r_BF_inB =@(alpha,beta,gamma)(r_BF_inB(alpha,beta,gamma));

J_BF_inB = @(alpha,beta,gamma)([ 40*sin(gamma)*(sin(alpha)*sin(beta) - cos(alpha)*cos(beta)) - 40*cos(gamma)*(cos(alpha)*sin(beta) + cos(beta)*sin(alpha)) - 40*sin(alpha) - 40*cos(alpha)*sin(beta) - 40*cos(beta)*sin(alpha), 40*sin(gamma)*(sin(alpha)*sin(beta) - cos(alpha)*cos(beta)) - 40*cos(gamma)*(cos(alpha)*sin(beta) + cos(beta)*sin(alpha)) - 40*cos(alpha)*sin(beta) - 40*cos(beta)*sin(alpha),   40*sin(gamma)*(sin(alpha)*sin(beta) - cos(alpha)*cos(beta)) - 40*cos(gamma)*(cos(alpha)*sin(beta) + cos(beta)*sin(alpha));
 40*cos(alpha) - 40*sin(alpha)*sin(beta) - 40*cos(gamma)*(sin(alpha)*sin(beta) - cos(alpha)*cos(beta)) - 40*sin(gamma)*(cos(alpha)*sin(beta) + cos(beta)*sin(alpha)) + 40*cos(alpha)*cos(beta), 40*cos(alpha)*cos(beta) - 40*cos(gamma)*(sin(alpha)*sin(beta) - cos(alpha)*cos(beta)) - 40*sin(gamma)*(cos(alpha)*sin(beta) + cos(beta)*sin(alpha)) - 40*sin(alpha)*sin(beta), - 40*cos(gamma)*(sin(alpha)*sin(beta) - cos(alpha)*cos(beta)) - 40*sin(gamma)*(cos(alpha)*sin(beta) + cos(beta)*sin(alpha));
                                                                                                                                                                                             0                                                                                                                                                                            0,                                                                                                                           0]);
Rgoal=@(t)[10*cos(t);10*sin(t);0];
q0=pi/180*[90;0;0];
dq0=[0;0;0];
q = q0;
dq = dq0;
deltaT = 0.01;
timeArr = 0:deltaT:10;
qArr = zeros(3,length(timeArr));
rArr = zeros(3,length(timeArr));
rGoalArr = zeros(3,length(timeArr));
for i=1:length(timeArr)
    t = timeArr(i);
    
    rGoalArr(:,i) = Rgoal(t);
    q = q+deltaT*dq
    qArr(:,i) = q;
    l=r_BF_inB(q(1),q(2),q(3));
    l=l(1:3);
    rArr(:,i) = l;
    k=50;
    v   = k*(Rgoal(t)-l);
    dq = pinv(J_BF_inB(q(1),q(2),q(3)))*v;    
    


end
%z=rGoalArr(1,:);
z1=[timeArr ; qArr(1,:)].';
z2=[timeArr ; qArr(2,:)].';
z3=[timeArr ; qArr(3,:)].';
%plot(rGoalArr, rArr);
plot(timeArr,rArr(1,:),timeArr,rGoalArr(1,:));


