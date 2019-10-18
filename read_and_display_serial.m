%   This function is designed to read data out from teh serial port that
%   arduino connects. 
%   Inputs: 
%       ser: the port to be opened
%       formate: the string format from serial
%   Output:
%       fh: figure handle
%   To clean opened port, use
%         fclose(instrfind);
%         delete(instrfind);





function [fh, data] = read_and_display_serial(pn, starting_sign)
  
    if ~exist('starting_sign', 'var')
        starting_sign = 'qua';
    end
    
    
    format = "%f";
    for i = 1:17
        format = format + ", %f";
    end
    
    port = serial(pn);
    set(port, 'BaudRate', 115200);
    fopen(port);
    
    fh = figure;
    view(3);
    
    hold on;
    axis equal;
    axis on

    %CmdKeyCallback('reset');
    k = 0;
    
    v = zeros(3, 1);
    x = 0;
    y = 0;
    z = 0;
    
    while k < 5000
        s = fscanf(port, format);
        pause(0.01);
        d = split(s, ', ');
        if numel(d) < 5
            continue;
        end
        acc = d{3};
        acc = acc(5:end);
        acc = split(acc, ',');
        acc = str2double(acc);
        ges = d{5};
        ges = ges(5:end);
        ges = split(ges, ',');
        ges = str2double(ges);
        if k < 10
            %   get estimation for g values
            dac(:, k+1) = acc;
            dge(:, k+1) = ges;
            k = k + 1;
            continue;
        end
        if k == 10
            %   get mean for estimation values
            mdac = mean(dac, 2);
            mges = mean(ges, 2);
            R = rotation_matrix(mges(1), mges(2), mges(3));
            g = R\(mdac/16384*9.8);
            
            R = rotation_matrix(ges(1), ges(2), ges(3));
            prev_a = acc/16384*9.8 - R*g;
            %   convert it into world frame using reverse rotation
            prev_a = -R\prev_a;        
            k = k + 1;
            continue
        end
%         if CmdKeyCallback()
%             break;
%         end
        if numel(ges) < 3
            continue;
        end
        R = rotation_matrix(ges(1), ges(2), ges(3));
        %   convert from digital value to accerelation m/s^2
        curr_a = acc/16384*9.8 - R*g;
        %   convert it to world frame
        curr_a = -R\curr_a;
        %   get the difference?
        a = curr_a - prev_a;
        prev_a = curr_a;
        %   get time as a(1)
        t = d{2};
        t = t(5:end);
        t = str2double(t);
        %   compute translation in body frame
        %   get the inversed velocity in body frame
        v = v + a*t;
        p = v*t + a*t^2/2;
        %   compute velocity changes in world frame
        
        x = x + p(1);
        y = y + p(2);
        z = z + p(3);
        plot3(x, y, z, 'r.')
        s = fscanf(port);
        k = k + 1;
    end
    
    fclose(port);
end
