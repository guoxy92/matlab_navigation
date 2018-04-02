clc
clear all
close all


map = zeros(100,100);
map(1:5, :) = 1;
map(96:100,:) = 1;
map(:,1:5) = 1;
map(:,96:100) = 1;
map(1:25,1:25) = 1;
map(1:24,1:24) = NaN;
map(76:100,76:100) = 1;
map(77:100,77:100) = NaN;
map(60:75,40:55) = 1;
map(25:35,65:75) = 1;
map(40:45,40:45) = 1;
map(60:65,70:75) = 1;
map(61:64,71:74) = NaN;
map(41:44,41:44) = NaN;
map(26:34,66:74) = NaN;
map(61:74,41:54) = NaN;
x = 1;
%%
% 
% <<FILENAME.PNG>>
% 
% <<FILENAME.PNG>>
% 
% 
y = 1;
start_x = round(rand*85+5);
start_y = round(rand*85+5);
detected = zeros(300,2);
detected(:,:) = NaN;
det_num = 1;
theta = -0.5*pi+0.05;
while 1
    if map(start_x,start_y) == 0
        break;
    else
        start_x = round(rand*85+5);
        satrt_y = round(rand*85+5);
    end
end

% scatter(start_x,start_y,'filled');

x =  start_x;
y =  start_y;

n = 0;
%
% xlim([-20,120]);
% ylim([-20,120]);
% hold on

mx = 0;
my = 0;
alpha = pi / 4;

axis([-20 120 -20 120]);
hold on

while n < 1000
    
    while 1
        
        x_temp= round(x + 3*cos(alpha)*(-1)^mx);
        y_temp = round(y + 3*sin(alpha)*(-1)^my);
        if map(x_temp,y_temp) == 0
            %             scatter(x,y);
            break
        else
            %             mx = mx+round(3*rand);
            %             my = my+round(3*rand);
            mx = mx-1;
            my = my+1;
            
            %             mx = mx+1;
            %             my = my+1;
            alpha = alpha + 0.1*pi;
        end
    end
    
    x = x_temp;
    y = y_temp;
    
    robot = scatter(x,y,'s','r','LineWidth',8,'tag','robot');
    
    
    
    theta = theta + 0.1;
    scan_x_right = x + 1;
    scan_x_left = x - 1;
    
    while scan_x_right <100 && scan_x_right > 1
        
        scan_y_right =  round(tan(theta)*(scan_x_right) + y - tan(theta)*x);
        
        if scan_y_right > 95
            scan_y_right = 96;
        elseif scan_y_right < 5
            scan_y_right = 6;
        end
        
        
        
        if map(scan_x_right, scan_y_right) == 1
            
            scatter(scan_x_right,scan_y_right,'filled');
            
            
            %         hold on
            line1 =  line([x,scan_x_right],[y,scan_y_right],'tag','line1');
            
            detected(det_num, 1) = scan_x_right;
            detected(det_num, 2) = scan_y_right;
            det_num = det_num + 1;
            break
        else
            scan_x_right = scan_x_right + 1;
        end
        
        
        
    end
    
    while scan_x_left <100 && scan_x_left > 1
        
        scan_y_left =  round(tan(theta)*(scan_x_left) + y - tan(theta)*x);
        
        if scan_y_left > 95
            scan_y_left = 96;
        elseif scan_y_left < 5
            scan_y_left = 6;
        end
        
        
        if map(scan_x_left, scan_y_left) == 1
            
            
            scatter(scan_x_left,scan_y_left,'filled')
            %         hold on
            line2 = line([x,scan_x_left],[y,scan_y_left],'tag','line2');
            pause(0);
            
            
            %             cla([line1 line2]);
            %             line([x,scan_x_left],[y,scan_y_left],'Color','white');
            %             line([x,scan_x_right],[y,scan_y_right],'Color','white');
            
            detected(det_num, 1) = scan_x_left;
            detected(det_num, 2) = scan_y_left;
            det_num = det_num + 1;
            break
        else
            scan_x_left = scan_x_left - 1;
        end
        
        
        
    end
    
    n = n + 1;
    h1 = findobj('type','line','tag','line1');
    h2 = findobj('type','line','tag','line2');
    h3 = findobj('type','scatter','tag','robot');
    delete(h1);
    delete(h2);
    delete(h3);
end



