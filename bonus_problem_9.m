
%git-hub: martinez-lopezpablo

%Last update: 20/11/2023

% PROBLEM 9: BONUS
% In half of the trials, the square is on the left and the circle on the
%right and in the other half it's the opposite. Also, the square and the
%circle change their color to red or green in half of the trials
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
redColor = [1, 0, 0];
greenColor = [0, 1, 0];
greyColor = [0.5, 0.5, 0.5];

%% Relevant positions
xLeft = (screenWidth)*0.25;
xRight = (screenWidth)*0.75;
xPosition = [xLeft xRight];

%% Random order

%Conditions: We have 8 different types of trials

trial_type=ones(2,8);

%Positions: Left/Right

trial_type(1,1:1:8)= 1; % Righ circle
trial_type(1,2:2:8)= 2; % Left circle

%Colors: Red/Green square and Red/Green circle
trial_type(2,1:2)= 1; % Red square & Red circle
trial_type(2,3:4)= 2; % Red square & Green circle
trial_type(2,5:6)=3; % Green square & Red circle
trial_type(2,7:8)=4; % Green square & Green circle


random_trial_type = trial_type(:, randperm(size(trial_type, 2))); % This line randomly shuffles columns
% As I saw, we cannot use just the "Shuffle" function. It mixes all values
% together.

num_trials = length(trial_type);

%% Time 
%Pseudorandom time for each parameter
StimulusTime = ones(1,num_trials);

FixationTime = ones(1,num_trials);

for t = 1:num_trials
    pseudorandomFixationTime = 0.2 + (0.5 - 0.2) * rand;
    FixationTime(t) = pseudorandomFixationTime;
    pseudorandomStimulusTime = 2 + (5 - 2) * rand;
    StimulusTime(t) = pseudorandomStimulusTime;
end

%% Presentation of stimuli
% We will present first a fixation cross, then the stimuli and finally a
% grey brackground for 0.5s
%In half of the trials, the square is on the left and the circle on the
%right and in the other half it's the opposite. Also, the square and the
%circle change to red or green in half of the trials

for i = 1:num_trials
    % Fixation
    Screen('DrawText', window, '+', textX, textY, white);
    Screen('Flip', window);
    WaitSecs(FixationTime(i));

    % We present the stimuli on the right/left side and
    % colored red or green pseudorandomly

    if random_trial_type(1,i) == 1 % Position
        
        %Color
        if random_trial_type(2,i) == 1 % Red square & Red circle
        Screen('DrawDots', window, [xRight, yCenter], dotSize, redColor, [], 2);
        Screen('FillRect', window, redColor, CenterRectOnPoint(rectSize, xLeft, yCenter));
        elseif random_trial_type(2,i) == 2 % Red square & Green circle
            Screen('DrawDots', window, [xRight, yCenter], dotSize, greenColor, [], 2);
            Screen('FillRect', window, redColor, CenterRectOnPoint(rectSize, xLeft, yCenter));
        elseif random_trial_type(2,i) == 3 % Green square & Red circle
            Screen('DrawDots', window, [xRight, yCenter], dotSize, redColor, [], 2);
            Screen('FillRect', window, greenColor, CenterRectOnPoint(rectSize, xLeft, yCenter));
        elseif random_trial_type(2,i) == 4 % Green square & Green circle
            Screen('DrawDots', window, [xRight, yCenter], dotSize, greenColor, [], 2);
            Screen('FillRect', window, greenColor, CenterRectOnPoint(rectSize, xLeft, yCenter));
        end
        Screen('Flip', window);
        WaitSecs(StimulusTime(i)); %Pseudorandom time of presentation

        % Grey background for 0.5s
        Screen('DrawDots', window, [xRight, yCenter], dotSize, greyColor, [], 2);
        Screen('FillRect', window, greyColor, CenterRectOnPoint(rectSize, xLeft, yCenter));
        Screen('Flip', window);
        WaitSecs(0.5);

    elseif random_trial_type(1,i) == 2 % Position

        % Color
        if random_trial_type(2,i) == 1 % Red square & Red circle
        Screen('DrawDots', window, [xLeft, yCenter], dotSize, redColor, [], 2);
        Screen('FillRect', window, redColor, CenterRectOnPoint(rectSize, xRight, yCenter));
        elseif random_trial_type(2,i) == 2 % Red square & Green circle
            Screen('DrawDots', window, [xLeft, yCenter], dotSize, greenColor, [], 2);
            Screen('FillRect', window, redColor, CenterRectOnPoint(rectSize, xRight, yCenter));
        elseif random_trial_type(2,i) == 3 % Green square & Red circle
            Screen('DrawDots', window, [xLeft, yCenter], dotSize, redColor, [], 2);
            Screen('FillRect', window, greenColor, CenterRectOnPoint(rectSize, xRight, yCenter));
        elseif random_trial_type(2,i) == 4 % Green square & Green circle
            Screen('DrawDots', window, [xLeft, yCenter], dotSize, greenColor, [], 2);
            Screen('FillRect', window, greenColor, CenterRectOnPoint(rectSize, xRight, yCenter));
        end
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

