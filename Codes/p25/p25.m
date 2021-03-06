close all; clear all; clc;
path(path, genpath('../p22'));
dbstop if error;

%%
load '../data/rose.mat'
clear laser;
len = size(relMotion, 2);
rob = [0 -3 -3; 0 -1 1] * 0.5;
%% Initialize figure
figPos = get(0, 'ScreenSize'); % [left, bottom, width, height]
figPos(3) = figPos(3) - 100;
figure('name', 'Motion animation',...
       'position', figPos,...
       'color', 'w', 'Menu', 'none');
hold on; box on; grid minor;
robPlot  = patch(0, 0, 'b', 'erasemode', 'normal');
pathPlot = plot (0, 0, 'r-', 'linewidth', 5, 'erasemode','background');
xlabel('X(m)');
ylabel('Y(m)');
axis equal;
axis([-5  15  -5 15]);
%%
pos  = zeros(3, 1);
path = zeros(3, len + 1);
for i = 1 : len
    pos          = compound(pos, relMotion(:, i));
    path(:, i+1) = pos;
    robPos       = compound(pos, rob);
    set(robPlot,  'xdata', robPos(1, :), 'ydata', robPos(2, :));
    set(pathPlot, 'xdata', path(1, 1:i), 'ydata', path(2, 1:i));
    drawnow;
    pause(0.005);
end
print('-dpng', 'path.png');

