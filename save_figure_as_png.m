function save_figure_as_png(figure_handle, filename)
%   this function 
%       save_figure_as_png(figure_handle, filename)
%   Inputs:
%       figure_handle: handle of this figure
%       filename: name and path of the file to be saved
%   is to save a figure into an image file with maximum size

if exist('verLessThan', 'file') && ~verLessThan('matlab', '9.4')
    %   java-less since 2018a
    set(figure_handle, 'WindowState', 'maximized');
else
    % Old Java version
    drawnow(); % Required to avoid Java errors
    set(figure_handle, 'WindowStyle', 'normal');
    % Suppress warning about Java obsoletion
    %oldState = warning('off', 'MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
    jFig = get(handle(figure_handle), 'JavaFrame'); 
    jFig.setMaximized(true);
end

figure_handle.PaperPositionMode = 'auto';
fig_pos = figure_handle.PaperPosition;
figure_handle.PaperSize = [fig_pos(3) fig_pos(4)];

print(figure_handle, filename,'-dpng', '-r0');
