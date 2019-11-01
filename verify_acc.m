%   This function is used to verify the values of accelerometer during the
%   IMU is still
function ac = verify_acc(data)
    
    n = size(data.acc, 1);
    
    R = quaternion_to_rotation(data.q);
    
    converted_gravity = zeros(n, 3);
    
    for i = 1:n
        a = R(:, :, i)*[0,0,1]';
        converted_gravity(i, :) = a';
    end
    
    ac = data.acc - converted_gravity;
end