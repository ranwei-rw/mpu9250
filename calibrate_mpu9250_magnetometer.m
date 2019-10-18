function data = calibrate_mpu9250_magnetometer(filename)
    data = read_9250_output(filename);
    n = size(data, 1);
%     f = figure;
%     axis equal
%     scatter3(data.mag(:,1), data.mag(:, 2), data.mag(:, 3));
    mag_max = max(data.mag);
    mag_min = min(data.mag);
    data.bias = (mag_max + mag_min)/2;
    data.scale = (mag_max - mag_min)/2;
    
    b = repmat(data.bias, [n, 1]);
%     f = figure;
%     hold on
%     axis equal
% %    scatter3(data.mag(:,1), data.mag(:, 2), data.mag(:, 3));
% %    plot3(data.mag(:,1), data.mag(:, 2), data.mag(:, 3));
%     plot(data.mag(:,1), data.mag(:, 2), 'o');
%     plot(data.mag(:,1), data.mag(:, 3), 'o');
%     plot(data.mag(:,2), data.mag(:, 3), 'o');
%     save_figure_as_png(f, 'uncalibrated_AK8963.png');
    
    
%    m = data.mag - b;
%     f = figure;
%     hold on
%     axis equal
% %     scatter3(m(:,1), m(:, 2), m(:, 3));
% %     plot3(m(:,1), m(:, 2), m(:, 3));
%     plot(m(:,1), m(:, 2), 'o');
%     plot(m(:,1), m(:, 3), 'o');
%     plot(m(:,2), m(:, 3), 'o');
%     save_figure_as_png(f, 'calibrated_AK8963.png');
end