%%PROBLEM 4
% Now the time is pseudorandom with a minimum of 3 seconds and a maximum of
% 7 seconds

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


%Set the color red
rectColor = [1, 0, 0];
greyColor = [0.5, 0.5, 0.5];

%Pseudorandom time of presentation: We want to present the two squares and
%the green screen for a minimum of 3 seconds and a maximum of 7 seconds. 
range = 3 + (7 - 3) * rand;
Timer = randfixedsum(3,1,range,0,7); % Roger Stafford (2023). Random Vectors with Fixed Sum 
% (https://www.mathworks.com/matlabcentral/fileexchange/9700-random-vectors-with-fixed-sum), MATLAB Central File Exchange. 

% The function generates a matrix which the rows of a column sum to a specific value.
% In this case, the specific value is a randomly selected number within the range from 3 to 7. 
% The function also allows us to specify the range of the numbers in the matrix.

%Adding a 0 to end the experiment immediately after second square
%presentation
Timer(4,1) = 0;

%Open a window and color it grey
[window, rect]= PsychImaging('OpenWindow',0,grey);
[screenWidth, screenHeight] = Screen('WindowSize', window);
xPosition = [(screenWidth)*0.5 screenWidth *0.25]; %The squares will be presented according to xPosition and in these order
yCenter = (screenHeight)/ 2; %This is the center in the y Axis

% Make a base Rect
baseRect = [0 0 (screenHeight)*0.25 (screenHeight)*0.25];

%Set the number of squares for the bucle
numSquares = length(xPosition); 


%% Display the square first at the center and then on the left in a
%% pseudorandom time

for i = 1:numSquares
    for k = 1:Timer
    % Draw the red square
    Screen('FillRect', window, rectColor, CenterRectOnPoint(baseRect, xPosition(i), yCenter));
    Screen('Flip', window);
    WaitSecs(Timer(k));
    
    % Clear the screen and display the grey background
    Screen('FillRect', window, greyColor, CenterRectOnPoint(baseRect, xPosition(i), yCenter));
    Screen('Flip', window);
    WaitSecs(Timer(k));
    end
end

%Close the window
Screen('CloseAll');

% Note: We present in pseudorandom time each square and the time between
% both. Ideally, I would have liked to have the same pseudorandom time for both
% squares and different one for time between both. 