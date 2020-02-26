function [data, fh] = read_cm12880_output(file, show_figure, new_handle)

    if ~exist('new_handle', 'var')
        new_handle = 1;
    end
    
    if ~exist('show_figure', 'var')
        show_figure = 1;
    end

    d = importdata(file, ' ');
    if isstruct(d)
        d = d.data;
    end
    
    %   c == 299
    data.order_number = d(:, 1);
    data.hour = d(:, 2);
    data.minute = d(:, 3);
    data.second = d(:, 4);
    data.day = d(:, 5);
    data.month = d(:, 6);
    data.year = d(:, 7);
    data.pressure = d(:, 8);
    data.temp = d(:, 9);
    data.depth = d(:, 10);
    data.altitude = d(:, 11);
    data.spectrometer = d(:, 12:end);
    
    %   handle outliers
    [~, ind1] = removeoutliers(data.temp);
    [~, ind2] = removeoutliers(data.depth);
    [~, ind3] = removeoutliers(data.altitude);
    [~, ind4] = removeoutliers(data.pressure);
        
    ind = ind1 + ind2 + ind3 + ind4;
    
    data.order_number = data.order_number(ind == 0);
    data.hour = data.hour(ind == 0);
    data.minute = data.minute(ind == 0);
    data.second = data.second(ind == 0);
    data.day = data.day(ind == 0);
    data.month = data.month(ind == 0);
    data.year = data.year(ind == 0);
    data.pressure = data.pressure(ind == 0);
    data.temp = data.temp(ind == 0);
    data.depth = data.depth(ind == 0);
    data.altitude = data.altitude(ind == 0);
    data.spectrometer = data.spectrometer(ind == 0, 12:end);
    
    if new_handle && show_figure
        fh = figure;
    else 
        fh = gcf;
    end
    
    if show_figure
       plot(data.spectrometer');
    end
end