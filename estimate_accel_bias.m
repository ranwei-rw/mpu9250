function [bias, gz] = estimate_accel_bias(data_0, data_180)

    measured_theta = mean(data_0.bias);
    measured_theta_pi = mean(data_180.bias);
    biasx = (measured_theta(1) + measured_theta_pi(1))/2;
    biasy = (measured_theta(2) + measured_theta_pi(2))/2;
    
    costheta = (measured_theta(1) - measured_theta_pi(1))/2;
    sintheta = (measured_theta(2) - measured_theta_pi(2))/2;
    
    gz = sqrt(1 - costheta^2 - sintheta^2);
    biasz = (measured_theta(3) + measured_theta_pi(3))/2 + (1-gz);
    bias = [biasx, biasy, biasz];
    
end