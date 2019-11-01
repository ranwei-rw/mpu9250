%   this function is used to convert quaternion to homogeneous rotation
%   matrix
%   
%   Input: quat. Could be a row vector or a matrix of row vectors
function R = quaternion_to_rotation(quat)
    
    [n, ~] = size(quat);
    R = zeros(3, 3, n);
    for i = 1:n
        q = quat(i, :);
        q0 = q(1);
        q1 = q(2);
        q2 = q(3);
        q3 = q(4);
%         %   inhomogeneous expression:
%         R(:, :, i) = [1 - 2*(q2^2+q3^2), 2*(q1*q2-q0*q3), 2*(q0*q2 + q1*q3);
%                       2*(q1*q2+q0*q3), 1 - 2*(q1^2 + q3^2), 2*(q2*q3 - q0*q1);
%                       2*(q1*q3 - q0*q2), 2*(q0*q1 + q2*q3), 1 - 2*(q1^2+q2^2)];

        R(:, :, i) = [q0^2 + q1^2 - q2^2 - q3^2, 2*(q1*q2-q0*q3), 2*(q0*q2 + q1*q3);
                      2*(q1*q2 + q0*q3), q0^2 - q1^2 + q2^2 - q3^2, 2*(q2*q3 - q0*q1);
                      2*(q1*q3 - q0*q2), 2*(q0*q1 + q2*q3), q0^2 - q1^2 - q2^2 + q3^2];
                  
%                   R(:, :, i) = qGetR(q);
    end
end
