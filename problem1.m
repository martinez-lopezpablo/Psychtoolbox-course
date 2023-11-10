


%%PROBLEM 1 - Display a grey screen for 5 seconds

close all;
clear;
sca

% Default settings for setting up Psychtoolbox
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
w = [1 0]
% Open a screen and colour it grey
[window, rect]=Screen('OpenWindow',0, grey);

%for 5 seconds
WaitSecs(5);

%and Close the window
Screen('CloseAll');


