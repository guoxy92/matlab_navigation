clc;
clear all;
close all;
wall_left = -10;
wall_right = 10;
wall_up = 10;
wall_down = -10;
t = 1;
start_x = (2*rand-1)*10;
start_y = (2*rand-1)*10;

scatter(start_x,start_y,'filled');


xlim([-15,15]);
ylim([-15,15]);
hold on;


wall = zeros(300,2);
wall(:,:)= NaN;

theta = -0.5*pi+0.05;

wall_num = 1;


while t < 100
    

    xlim([-15,15]);
    ylim([-15,15]);
    hold on;
    scatter(wall(:,1),wall(:,2));
    syms x y;
    
    [solv, solu] = solve([x == wall_left,y == tan(theta)*x + start_y-tan(theta)*start_x],[x,y]);
    %     x = wall_left;
    %     y = cos(scan1)*x + start_y-cos(scan1)*start_x;
    %     syms x y;
    %    eqns = [x == wall_left,y == cos(scan1)*x + start_y-cos(scan1)*start_x];
    %     [solv, solu]  = solve(eqns,[x,y])
%         x = solv;
%        y = solu;
    if (solu < 10 && solu > -10)
    line([solv,start_x],[solu,start_y]);
    scatter(solv,solu)
    pause(0.01);
    wall(wall_num,1) = solv;
    wall(wall_num,2) = solu;
    wall_num = wall_num +1;
    end
    
    [solv, solu] = solve([x == wall_right,y == tan(theta)*x + start_y-tan(theta)*start_x],[x,y]);
    
    if (solu < 10 && solu > -10)
    line([solv,start_x],[solu,start_y]);
    scatter(solv,solu)
    pause(0.01);
    wall(wall_num,1) = solv;
    wall(wall_num,2) = solu;
    wall_num = wall_num +1;
    end
    
    
    [solv, solu] = solve([y == wall_up,y == tan(theta)*x + start_y-tan(theta)*start_x],[x,y]);
    
    if (solv < 10 && solv > -10)
    line([solv,start_x],[solu,start_y]);
    scatter(solv,solu)
    pause(0.01);
    wall(wall_num,1) = solv;
    wall(wall_num,2) = solu;
    wall_num = wall_num +1;
    end
    
   [solv, solu] = solve([y == wall_down,y == tan(theta)*x + start_y-tan(theta)*start_x],[x,y]);
    
    if (solv < 10 && solv > -10)
    line([solv,start_x],[solu,start_y]);
    scatter(solv,solu)
    pause(0.01);
    wall(wall_num,1) = solv;
    wall(wall_num,2) = solu;
    wall_num = wall_num +1;
    end
    
    hold off
 
   
    theta = theta + 0.1;
    t = t + 1;
 
end

hold on 

line([wall_left,wall_up],[wall_right,wall_up],'Color','red','LineWidth',3);

line([wall_left,wall_up],[wall_left,wall_down],'Color','red','LineWidth',3);

line([wall_right,wall_up],[wall_right,wall_down],'Color','red','LineWidth',3);

line([wall_left,wall_down],[wall_right,wall_down],'Color','red','LineWidth',3);






