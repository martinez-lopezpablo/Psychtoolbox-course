
%git-hub: martinez-lopezpablo

%Last update: 16/11/2023

% PROBLEM 7, 8 & 9
%In half of the trials, the square is on the left and the circle on the
%right and in the other half it's the opposite
clear all;
close all;
clc;

Screen('Preference','SkipSyncTests', 1);
Screen('Preference', 'VisualDebugLevel', 0);

%Default settings 
PsychDefaultSetup(2);

% Grey color for the background
white = WhiteIndex(0);
grey = white / 2;
black = BlackIndex(0);

%Open a window
[window, windowRect] = PsychImaging('OpenWindow', 0, grey);

%Get the size of the on screen window in pixels
[screenWidth, screenHeight] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

%% Create the fixation cross
% Due to software issues I need some extra lines of code

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

%% Create a square and a circle
% We will use the same red square and green circle as in problem 6

rectSize = [0 0 (screenHeight) * 0.25 (screenHeight) * 0.25];
dotSize = 63;

%Set the colors
rectColor = [1, 0, 0];
dotColor = [0, 1, 0];
greyColor = [0.5, 0.5, 0.5];

%% Relevant positions
xLeft = (screenWidth)*0.25;
xRight = (screenWidth)*0.75;

%% Random order
% Half of the trials will present the square on the left and the circle on
% the right side and in the other half it is opposite

tipo_trials=ones(1,6);
tipo_trials(1,1:3)=1;
tipo_trials(1,4:6)=2;

tipo_trials_random = Shuffle(tipo_trials);

num_trials = length(tipo_trials);

%% Time 
%Pseudorandom time for each parameter
StimulusTime = ones(1,6);

FixationTime = ones(1,6);

for t = 1:6
    pseudorandomFixationTime = 0.2 + (0.5 - 0.2) * rand;
    FixationTime(t) = pseudorandomFixationTime;
    pseudorandomStimulusTime = 2 + (5 - 2) * rand;
    StimulusTime(t) = pseudorandomStimulusTime;
end

%% Presentation of stimuli
% We will present first a fixation cross, then the stimuli and finally a
% grey brackground for 0.5s
%In half of the trials, the square is on the left and the circle on the
%right and in the other half it's the opposite
for i = 1:num_trials
    % Fixation
    Screen('DrawText', window, '+', textX, textY, white);
    Screen('Flip', window);
    WaitSecs(FixationTime(i));

    % We present the stimuli on the right/left side pseudorandomly
    if tipo_trials_random(i) == 1 
        Screen('DrawDots', window, [xRight, yCenter], dotSize, dotColor, [], 2);
        Screen('FillRect', window, rectColor, CenterRectOnPoint(rectSize, xLeft, yCenter));
        Screen('Flip', window);
        WaitSecs(StimulusTime(i)); %Pseudorandom time of presentation

        % Grey background for 0.5s
        Screen('FillRect', window, greyColor, CenterRectOnPoint(rectSize, xLeft, yCenter));
        Screen('DrawDots', window, [xRight, yCenter], dotSize, greyColor, [], 2);
        Screen('Flip', window);
        WaitSecs(0.5);
    else
        Screen('DrawDots', window, [xLeft, yCenter], dotSize, dotColor, [], 2);
        Screen('FillRect', window, rectColor, CenterRectOnPoint(rectSize, xRight, yCenter));
        Screen('Flip', window);
        WaitSecs(StimulusTime(i)); %Pseudorandom time of presentation

        % Grey background for 0.5s
        Screen('FillRect', window, greyColor, CenterRectOnPoint(rectSize, xRight, yCenter));
        Screen('DrawDots', window, [xLeft, yCenter], dotSize, greyColor, [], 2);
        Screen('Flip', window);
        WaitSecs(0.5);
    end
end

%Close the window
Screen('CloseAll');

