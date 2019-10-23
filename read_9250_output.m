function data = read_9250_output(file)
    d = importdata(file, ',');
    [n, c] = size(d);
    if c == 9
        data.acc = d(:, 1:3);
        data.gyr = d(:, 4:6);
        data.mag = d(:, 7:9);
    elseif c == 11
        data.temp = d(:, 1);
        data.delta_t = d(:, 2);
        data.acc = d(:, 3:5);
        data.gyr = d(:, 6:8);
        data.mag = d(:, 9:11);
        %   note: for this option and the below, magnet values are already
        %   being offsetted by the bias values.
    elseif c == 19 % current output from kris code
        data.delta_t = ones(1, n)*50;
        data.temp = d(:, 1);
        data.delta_t = d(:, 2);
        data.acc = d(:, 3:5);
        data.gyr = d(:, 6:8);
        data.mag = d(:, 9:11);
        data.q = d(:, 12:15);
        data.rpy = d(:, 16:18);
        data.rates = d(:, 19);
    else
        data.temp = d(:, 1);
        data.delta_t = d(:, 2);
        data.acc = d(:, 3:5);
        data.gyr = d(:, 6:8);
        data.mag = d(:, 9:11);
        data.rpy = d(:, 12:14); % rpy = roll, pitch, yaw
        data.q = d(:, 15:end);
        %   magnet values are already
        %   being offsetted by the bias values.
    end
    data.bias = [242.33 301.695 -426.095];
    
%     %   if the magnetometer data is not calibrated, show its distribution
%     n = size(data.mag, 1);
%     mag = data.mag - repmat(data.bias, [n, 1]);
%     fh = figure;
%     scatter3(mag(:, 1), mag(:, 2), mag(:, 3));
end