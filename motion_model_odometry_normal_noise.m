%Algolrithm motion_model_odometry with Normal Distribution Noise

clc
close all

%Initial setting of mobile robot
x = 100;
y =100;
theta = pi/4;
% velocity = 1;
% omega = 0.5;
x_odo = 100;
y_odo = 100;
theta_odo = pi/4;

x_odo_prime = 101;
y_odo_prime = 101;
theta_odo_prime = pi/4;


%Settings of Noise parameters 
a1 = 0;
a2 = 0;
a3 = 0;
a4 = 0;
% a5 = 0.01;
% a6 = 0.01;




trajectory_data = zeros(7,10000);
trajectory_data(:,:) = NaN;

n = 1;
t = 0;
delta_t = 0.0001;

xlim([0 200]);
ylim([0 200]);
hold on 

while (t < 10 )
    
% velocity_noise = velocity + sqrt(6)/2*((sqrt(a1*velocity^2 + a2*omega^2)*(2*(rand-0.5))+(sqrt(a1*velocity^2 + a2*omega^2)*(2*(rand-0.5)))));
% 
% omega_noise = omega + sqrt(6)/2*((sqrt(a3*velocity^2 + a4*omega^2)*(2*(rand-0.5))+(sqrt(a3*velocity^2 + a4*omega^2)*(2*(rand-0.5)))));
% 
% gamma_noise =  sqrt(6)/2*((sqrt(a5*velocity^2 + a6*omega^2)*(2*(rand-0.5))+(sqrt(a5*velocity^2 + a6*omega^2)*(2*(rand-0.5)))));
% 
%    
% x_prime = x - (velocity_noise/omega_noise)*sin(rad2deg(theta)) + (velocity_noise/omega_noise)*sin(rad2deg(theta + omega_noise*delta_t));
% 
% y_prime = y + (velocity_noise/omega_noise)*cos(rad2deg(theta)) - (velocity_noise/omega_noise)*cos(rad2deg(theta + omega_noise*delta_t));
% 
% theta_prime = theta + omega_noise*delta_t + gamma_noise*delta_t;
delta_rot1 = atan2(y_odo_prime - y_odo, x_odo_prime - x_odo) - theta_odo;

delta_trans = sqrt((x_odo - x_odo_prime)^2 + (y_odo - y_odo_prime)^2);

delta_rot2 = theta_odo_prime - theta_odo - delta_rot1;


delta_rot1_noise = delta_rot1 - normrnd(0,(a1*delta_rot1^2 + a2*delta_trans^2));

delta_trans_noise = delta_trans - normrnd(0,(a3*delta_trans^2 + a4*delta_rot1^2 + a4*delta_rot2^2));

delta_rot2_noise = delta_rot2 - normrnd(0,(a1*delta_rot2^2 + a2*delta_trans^2));


x_prime = x + delta_trans_noise * cos(rad2deg(theta + delta_rot1_noise));

y_prime = y + delta_trans_noise * sin(rad2deg(theta + delta_rot1_noise));

theta_prime = theta + delta_rot1_noise + delta_rot2_noise;


x_odo = x_odo_prime;

y_odo = y_odo_prime;

theta_odo = theta_odo_prime;


x_odo_prime = x_odo_prime + delta_trans * cos(rad2deg(theta + delta_rot1));

y_odo_prime = y_odo_prime + delta_trans * sin(rad2deg(theta + delta_rot1));

theta_odo_prime = theta_odo_prime + delta_rot1 + delta_rot2;


trajectory_data(1,n) = x_prime;

trajectory_data(2,n) = y_prime;

trajectory_data(3,n) = theta_prime;


trajectory_data(4,n) = x_odo_prime;

trajectory_data(5,n) = y_odo_prime;

trajectory_data(6,n) = theta_odo_prime;


trajectory_data(7,n) = t;



x = x_prime;

y = y_prime;

theta = theta_prime;



 scatter(trajectory_data(4,n),trajectory_data(5,n));
 
 pause(1);

hold on

t = t + delta_t;

n = n + 1;



end

