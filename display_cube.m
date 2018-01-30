function x = display_cube()
%
% This function displays a 3-D cube.
%
%
%

time_remaining = 100
current_time = 1
%
% The shape to be transformed
a = [-1.0, -1.0  -1.0;]
b = [-1.0, -1.0  1.0;]
c = [-1.0, 1.0  -1.0;]
d = [-1.0, 1.0  1.0;]
e = [1.0, -1.0  -1.0;]
f = [1.0, -1.0  1.0;]
g = [1.0, 1.0  -1.0;]
h = [1.0, 1.0  1.0;]

pts = [ a;    % 1
    b;    % 2
    c;    % 3
    d;    % 4
    e;    % 5
    f;    % 6
    g;    % 7
    h ]'  % 8

% Create a new figure dialog and set the background color to white.
figure;
set(gcf, 'color','w');
set(gcf, 'Position', [0, 0, 600, 425])

% Convert points to homogeneous coordinates
pts_tilde = [ pts; ones(1,size(pts,2)) ];

% Rotate onto Point (similar to GIF from assignment)[NOT WORKING]
rotate_90_y = [cos(45) 0 sin(45) 0;
            0   1   0   0;
            -sin(45)    0   cos(45) 0;
            0   0   0   1];
rotate_90_x = [1 0 0 0;
                0 cos(45) -sin(45) 0;
                0 sin(45) cos(45) 0;
                0 0 0 1];

%pts_tilde = rotate_90_y*pts_tilde;
%pts_tilde = rotate_90_x*pts_tilde;

% Values to control what the inner cube shrinks and expands by
shrink = -1
shrink_speed = 2
max_scale = .75
min_scale = .25
adjuster = ((max_scale-min_scale)*shrink_speed)/time_remaining
scale_anchor = 0.75

while current_time<time_remaining
    
    %For determining shrink or expand
    checker = mod(current_time,(time_remaining/shrink_speed))
    
    if checker == 0
        shrink = shrink*-1
    end
    
        
    % Transformation matrix (scaling)
    S_tilde = [ scale_anchor 0.0 0.0 0.0;
        0.0 scale_anchor 0.0 0.0;
        0.0 0.0 scale_anchor 0.0;
        0.0 0.0 0.0 1.0 ];
    scale_anchor = scale_anchor +((shrink)*(adjuster))
    
    % rotation matrix
    z_matrix = [cos(360/100) -sin(360/100) 0 0;
        sin(360/100) cos(360/100)  0 0;
        0           0            1 0;
        0           0            0 1];
    
    % Rotate Big Cube
    pts_tilde = z_matrix*pts_tilde;
    
    % Show big cube in r
    showCube(pts_tilde,'r');
    view(62,11)
    
    % Apply transformation
    pts_prime = S_tilde * pts_tilde;
    
    % Show lines in red
    hold on;
    
    v1=[pts_tilde(1:3, 1),pts_prime(1:3, 1)];
    plot3(v1(1,:),v1(2,:),v1(3,:),'r');
    
    v2=[pts_tilde(1:3, 2),pts_prime(1:3, 2)];
    plot3(v2(1,:),v2(2,:),v2(3,:),'r');
    
    v3=[pts_tilde(1:3, 3),pts_prime(1:3, 3)];
    plot3(v3(1,:),v3(2,:),v3(3,:),'r');
    
    v4=[pts_tilde(1:3, 4),pts_prime(1:3, 4)];
    plot3(v4(1,:),v4(2,:),v4(3,:),'r');
    
    v5=[pts_tilde(1:3, 5),pts_prime(1:3, 5)];
    plot3(v5(1,:),v5(2,:),v5(3,:),'r');
    
    v6=[pts_tilde(1:3, 6),pts_prime(1:3, 6)];
    plot3(v6(1,:),v6(2,:),v6(3,:),'r');
    
    v7=[pts_tilde(1:3, 7),pts_prime(1:3, 7)];
    plot3(v7(1,:),v7(2,:),v7(3,:),'r');
    
    v8=[pts_tilde(1:3, 8),pts_prime(1:3, 8)];
    plot3(v8(1,:),v8(2,:),v8(3,:),'r');
    
    % Show transformed shape in red
    showCube(pts_prime,'r');
    view(62,11)
    
    % Write things to gif
    drawnow
    frame = getframe(1);
    im{current_time} = frame2im(frame);
    
    filename = 'testAnimated.gif';
    [A,map] = rgb2ind(im{current_time},256);
    delay_time = 1/10;
    if current_time == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',delay_time);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',delay_time);
    end
    
    % clear frame for next cube
    clf
    current_time = current_time +1;
end

return

end