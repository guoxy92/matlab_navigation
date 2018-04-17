%Algolrithm motion_model_velocity with triangular Distribution Noise

clc
close all

%Initial setting of mobile robot
x = 0;
y = 0;
theta = pi/4;
velocity = 1;
omega = 0.5;

%Settings of Noise parameters 
a1 = 0.01;
a2 = 0.01;
a3 = 0.01;
a4 = 0.01;
a5 = 0.01;
a6 = 0.01;



trajectory_data = zeros(7,10000);
trajectory_data(:,:) = NaN;

n = 1;
t = 0;
delta_t = 0.001;

xlim([-8 8]);
ylim([-8 8]);
hold on 

while (t < 10 )
    
velocity_noise = velocity + sqrt(6)/2*((sqrt(a1*velocity^2 + a2*omega^2)*(2*(rand-0.5))+(sqrt(a1*velocity^2 + a2*omega^2)*(2*(rand-0.5)))));

omega_noise = omega + sqrt(6)/2*((sqrt(a3*velocity^2 + a4*omega^2)*(2*(rand-0.5))+(sqrt(a3*velocity^2 + a4*omega^2)*(2*(rand-0.5)))));

gamma_noise =  sqrt(6)/2*((sqrt(a5*velocity^2 + a6*omega^2)*(2*(rand-0.5))+(sqrt(a5*velocity^2 + a6*omega^2)*(2*(rand-0.5)))));


x_prime = x - (velocity_noise/omega_noise)*sin(rad2deg(theta)) + (velocity_noise/omega_noise)*sin(rad2deg(theta + omega_noise*delta_t));

y_prime = y + (velocity_noise/omega_noise)*cos(rad2deg(theta)) - (velocity_noise/omega_noise)*cos(rad2deg(theta + omega_noise*delta_t));

theta_prime = theta + omega_noise*delta_t + gamma_noise*delta_t;

trajectory_data(1,n) = x_prime;

trajectory_data(2,n) = y_prime;

trajectory_data(3,n) = theta_prime;

trajectory_data(4,n) = velocity_noise;

trajectory_data(5,n) = omega_noise;

trajectory_data(6,n) = gamma_noise;

trajectory_data(7,n) = t;

x = x_prime;

y = y_prime;

theta = theta_prime;

scatter(trajectory_data(1,n),trajectory_data(2,n));

pause(0);

hold on

t = t + delta_t;

n = n + 1;



end

