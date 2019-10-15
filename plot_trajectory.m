function p = plot_trajectory(q, acc, dt)

    %   define  rotation matrix from magnet north to true north
    magnet_offset = 12.35/180*pi;
    
    R_nt = [cos(magnet_offset), sin(magnet_offset);
            -sin(magnet_offset), cos(magnet_offset)];

    %   get the size of input data q
    n = size(q, 1);
    
    %   define recovered path points
    p = zeros(n+1, 3);
    
    R = quaternion_to_rotation(q);
    v = [0, 0, 0];
    for i = 1:n
        %   get inverse rotation matrix
        r = inv(R(:, :, i));
        %   get estimated magnet acc (North, East, Down)
        am = r*acc(i, :)';
        %   apply magnet north to true north rotation
        true_n = R_nt*am(1:2);
        %   construct true acc vector
        true_acc = [true_n(1), true_n(2), am(3)];
        %   offset it by gravity
        true_acc = true_acc - [0, 0, 1];
        %   get position update for given time (millisecond)
        t = dt(i)/1000;
        p(i + 1, :) = p(i, :) + v*t + 0.5*true_acc*t^2;
        v = v + true_acc*t;
    end
    figure;
    scatter3(p(:, 1), p(:, 2), p(:, 3));
    
end