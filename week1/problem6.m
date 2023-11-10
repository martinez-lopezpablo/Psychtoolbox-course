
%git-hub: martinez-lopezpablo

%Last update: 10/11/2023

% PROBLEM 6
% Now we present a green circle on the right side with the second red square presentation. We present
% both 1/4 of the height away from the center of the screen

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

%Set the colors
rectColor = [1, 0, 0];
dotColor = [0, 1, 0];
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

%Get the size of the on screen window in pixels
[xCenter, yCenter] = RectCenter(windowRect);

%%%%% Relevant positions %%%%%

RightQuarterofheightAwayFromCenter = xCenter + (screenHeight)*0.25;
LeftQuarterofheightAwayFromCenter = xCenter - (screenHeight)*0.25;
xPosition = [(screenWidth)*0.5 LeftQuarterofheightAwayFromCenter]; %The squares will be presented according to xPosition and in these order

% Enable alpha blending for anti-aliasing
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);


%% Fixation

%Psychtoolbox and Matlab hate M1 Mac. (I think) The next lines of code are just
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


%% Display the square first at the center and then on the left with the green circle on the right side
%% 1/4 of the Height away from the center of the screen. We have pseudorandom presentation time for each fixation 
%% and for the shapes (fixed).

% Size of shapes
baseRect = [0 0 (screenHeight) * 0.25 (screenHeight) * 0.25];
dotSizePix = 63;

% Set the number of trials for the bucle
trials = length(xPosition);

for i = 1:trials
    % Fixation
    Screen('DrawText', window, '+', textX, textY, white);
    Screen('Flip', window);
    WaitSecs(FixationTime(i));

    % Draw the red square
    % Draw a green circle with the second square
    if i == 2
        Screen('DrawDots', window, [RightQuarterofheightAwayFromCenter, yCenter], dotSizePix, dotColor, [], 2);
    end
    Screen('FillRect', window, rectColor, CenterRectOnPoint(baseRect, xPosition(i), yCenter));
    Screen('Flip', window);
    WaitSecs(SquareTime);
    
end

%Close the window
Screen('CloseAll');
