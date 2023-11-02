%Github: martinez-lopezpablo
%Last update: 2/11/2023

%In this script we complete step 0 of the course.
%We try showing "Hello World" on the screen

Screen('Preference','SkipSyncTests', 1); %This line prevents screen-frames issues 

% Open a window for stimuli presentation
[window, rect]= Screen('OpenWindow',0);

% Define the center of the screen
[xCenter, yCenter] = RectCenter(rect);

%%Display the text "Hello world!"
Screen('DrawText',window,'Hello world!',xCenter,yCenter,1);
Screen('Flip',window);
WaitSecs(5) %The text will be displayed for 5 seconds
%Display the text "Goodbye world"
Screen('DrawText',window,'Goodbye world',xCenter,yCenter,1);
Screen('Flip',window);
WaitSecs(2) %The text will be displayed for 2 seconds
%End of step 0 task
Screen('CloseAll'); 

%David: ¡Excelente! 

