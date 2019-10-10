function [data, fh] = read_9250_output(file)
    d = importdata(file, ',');
    data.acc = d(:, 1:3);
    data.gyr = d(:, 4:6);
    data.mag = d(:, 7:end);
    data.bias = [242.33 301.695 -426.095];
    n = size(data.mag, 1);
    mag = data.mag - repmat(data.bias, [n, 1]);
    fh = figure;
    scatter3(mag(:, 1), mag(:, 2), mag(:, 3));
end