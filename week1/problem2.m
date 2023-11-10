
%%PROBLEM 2
%We want to present a red square 400x400 in the center for 2 seconds, 
% then make it disappear for 1 second, and finally present it in the left side of the screen.

clear all;
close all;
sca;

Screen('Preference','SkipSyncTests', 1);

%Default settings 
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Select the external screen if it is present, else revert to the native
% screen
screenNumber = max(screens);

% Define black, white and grey
black = BlackIndex(screenNumber);
white = WhiteIndex(screenNumber);
grey = white / 2;

% Make a base Rect of 400 by 400 pixels.
baseRect = [0 0 400 400];

%Set the color red
rectColor = [1, 0, 0];
greyColor = [0.5, 0.5, 0.5];

%Set the intersquare time
GreyScreenTime = [1 0];

%Open a window and color it grey
[window, rect]= PsychImaging('OpenWindow',0,grey);
[screenWidth, screenHeight] = Screen('WindowSize', window);
xPosition = [(screenWidth)*0.5 screenWidth *0.25]; %The squares will be presented according to xPosition and in these order
yCenter = (screenHeight)/ 2; %This is the center in the y Axis

%Set the number of squares for the bucle
numSquares = length(xPosition); 


% Display the square first at the center and then on the left
for i = 1:numSquares
    % Draw the red square
    Screen('FillRect', window, rectColor, CenterRectOnPoint(baseRect, xPosition(i), yCenter));
    Screen('Flip', window);
    WaitSecs(2);
    
    % Clear the screen and display the grey background
    Screen('FillRect', window, greyColor, CenterRectOnPoint(baseRect, xPosition(i), yCenter));
    Screen('Flip', window);
    WaitSecs(GreyScreenTime(i));
end

%Close the window
Screen('CloseAll');






