%%PROBLEM 5
% We add a fixing point before square presentation with a pseudorandom time
% between 2 and 5 seconclear allclose allclose allclose allclcclose allclc
clear all;
close all;
clc;

Screen('Preference','SkipSyncTests', 1);
Screen('Preference', 'VisualDebugLevel', 0);

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

%Set the color red
rectColor = [1, 0, 0];
greyColor = [0.5, 0.5, 0.5];

%Pseudorandom time of presentation for squares
SquareTime = 2 + (5 - 2) * rand;

%Pseudorandom time of presentation for each fixation
FixationTime = ones(1, 2);

for t = 1:2
    pseudorandomfixation = 0.2 + (0.5 - 0.2) * rand;
    FixationTime(t) = pseudorandomfixation;
end

%Open a window and color it grey
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
[screenWidth, screenHeight] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);
xPosition = [(screenWidth)*0.5 screenWidth *0.25]; %The squares will be presented according to xPosition and in these order



%% Fixation
% First, I tried to display a .png image of the fixation but it was so
% difficult and I was unsuccessful. Therefore, I decided to just display
% '+' using "DrawText".


%Psychtoolbox and Matlab hate Mac M1. (I think) The next lines of code are just
%due to that. (thank you GPT.)

% Position of the text
textRect = Screen('TextBounds', window, '+');
textWidth = RectWidth(textRect);
textHeight = RectHeight(textRect);

% Position of the text in the screen
textX = xCenter - textWidth / 2;
textY = yCenter - textHeight / 2;

% Setup the text type for the window
Screen('TextFont', window, 'Ariel');
Screen('TextSize', window, 50);
fixationColor = white;


%% Display the square first at the center and then on the left in
%% pseudorandom time

% Make a base Rect
baseRect = [0 0 (screenHeight) * 0.25 (screenHeight) * 0.25];

% Set the number of squares for the bucle
numSquares = length(xPosition);

for i = 1:numSquares
    % Fixation
    Screen('DrawText', window, '+', textX, textY, white);
    Screen('Flip', window);
    WaitSecs(FixationTime(i));

    % Draw the red square
    Screen('FillRect', window, rectColor, CenterRectOnPoint(baseRect, xPosition(i), yCenter));
    Screen('Flip', window);
    WaitSecs(SquareTime);
end

%Close the window
Screen('CloseAll');
