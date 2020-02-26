function [data, fh] = read_9250_output(file, show_figure, new_handle)

    if ~exist('new_handle', 'var')
        new_handle = 1;
    end
    
    if ~exist('show_figure', 'var')
        show_figure = 1;
    end

    d = importdata(file, ',');
    if isstruct(d)
        d = d.data;
    end
    
    [n, c] = size(d);
    if c == 1
        d = importdata(file, ' ');
        [n, c] = size(d);
        if c == 1
            data = [];
            return;
        end
    end
    
    if c == 3
        data.bias = d;
    elseif c == 9
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
    elseif c == 18
        %   data from current corycaeus master MPU9250 output
        data.order_num = d(:, 1);
        data.year = d(:, 2);
        data.month = d(:, 3);
        data.day = d(:, 4);
        data.hour = d(:, 5);
        data.minute = d(:, 6);
        data.second = d(:, 7);
        data.delta_t = d(:, 8);
        data.temp = d(:, 9);
        data.acc = d(:, 10:12);
        data.gyr = d(:, 13:15);
        data.mag = d(:, 16:18);
        data.bias = [58.564026 -8.0123595 -96.628601];
    elseif c == 19 % current output from kris code
        % process to remove NAN values. probably needs to go through all 19
        % elements
%         for k = 1:c
%             id = find(isnan(d(:, k)));
%             if ~isempty(id)
%                 d(id, :) = [];
%             end
%         end
        n = size(d, 1);
        id = find(isnan(d));
        if sum(id) ~= 0
            ids = mod(id, n);
            id0 = ids == 0;
            idnot0 = ids(~id0);
            if ~isempty(idnot0)
                id = unique(idnot0);
                d(id, :) = [];
            end
            %   there is a chance that id is at the last line of the 
            if ~isempty(id0)
                %   only one lastline exists, so we can do it once
                d(end, :) = [];
            end
        end
        
        data.temp = d(:, 1);
        data.delta_t = d(:, 2);
        data.acc = d(:, 3:5);
        data.gyr = d(:, 6:8);
        data.mag = d(:, 9:11);
        data.q = d(:, 12:15);
        data.rpy = d(:, 16:18);
        data.rates = d(:, 19);
        data.bias = [58.564026 -8.0123595 -96.628601];
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
        data.bias = [58.564026 -8.0123595 -96.628601];
    end
    
    
    
%     %   if the magnetometer data is not calibrated, show its distribution
     %was data.bias = [242.33 301.695 -426.095];
    if new_handle
        fh = figure;
    else
        fh = gcf;
    end
    
    if show_figure
       
%        n = size(data.mag, 1);
%         mag = data.mag;
%         %   choose to show data with or without bias info removed
%         %     %   with bias
%         %     mag = data.mag + repmat(data.bias, [n, 1]);
%         %   with bias removed
%         scatter3(mag(:, 1), mag(:, 2), mag(:, 3));

        scatter3(data.acc(:, 1), data.acc(:, 2), data.acc(:, 3));
    end
end