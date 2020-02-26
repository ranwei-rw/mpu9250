function bias = estimate_accel_bias(data_0, data_180)

    measured_theta = mean(data_0.acc);
    measured_theta_pi = mean(data_180.acc);
    m0_x = measured_theta(1);
    m0_y = measured_theta(2);
    m0_z = measured_theta(3);
    mpi_x = measured_theta_pi(1);
    mpi_y = measured_theta_pi(2);
    mpi_z = measured_theta_pi(3);
    
    biasx = (m0_x + mpi_x)/2;
    biasy = (m0_y + mpi_y)/2;
    
    r31 = (m0_x - mpi_x)/2;
    r32 = (m0_y - mpi_y)/2;
    
    r33 = sqrt(1 - r31^2 - r32^2);
    biasz = (m0_z + mpi_z)/2 - r33;
    %gz = (m0_z + mpi_z)/2 - biasz;
    bias = [biasx, biasy, biasz];
    
end