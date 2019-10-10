%   this function is used to plot the distribution of norm of points from
%   magnetometer when it's kept stable

function f = plot_distribution(data)
    n = size(data.mag, 1);
    mag = data.mag - repmat(data.bias, [n, 1]);
    %  get row-wise vector norm for a matrix
    a = vecnorm(mag, 2, 2);

    % [n, x] = hist(a, 100);
    %   plot the distribution
    f = figure;
    %bar(x, n, 'hist');
    h = histfit(a, 100, 'normal');
    title('{\color{magenta}gaussian model fit for norms of magnetometer outputs when stable}', 'FontSize', 20);
end