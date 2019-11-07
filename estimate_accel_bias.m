function [bias, gz] = estimate_accel_bias(data_0, data_180)

    measured_theta = mean(data_0.bias);
    measured_theta_pi = mean(data_180.bias);
    m0_x = measured_theta(1);
    m0_y = measured_theta(2);
    m0_z = measured_theta(3);
    mpi_x = measured_theta_pi(1);
    mpi_y = measured_theta_pi(2);
    mpi_z = measured_theta_pi(3);
    
    biasx = (m0_x + measured_theta_pi(1))/2;
    biasy = (measured_theta(2) + measured_theta_pi(2))/2;
    
    gxycostheta = (m0_x - mpi_x)/2;
    gxysintheta = (m0_y - mpi_y)/2;
    
    gz = sqrt(1 - gxycostheta^2 - gxysintheta^2);
    biasz = (m0_z + mpi_z)/2 + (1-gz);
    bias = [biasx, biasy, biasz];
    
end