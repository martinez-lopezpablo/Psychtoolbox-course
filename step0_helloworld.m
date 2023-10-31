
%Github: martinez-lopezpablo

%In this script we complete step 0 of the course.
%We try showing "Hello World" on the screen
Screen('Preference','SkipSyncTests', 1); %This line prevents screen-frames issues 
[window, rect]=Screen('OpenWindow',0);
[screenWidth, screenHeight] = Screen('WindowSize', window);
xCenter = (screenWidth)/ 2;
yCenter = (screenHeight)/ 2;


Screen('DrawText',window,'Hello world',xCenter,yCenter,1);
Screen('Flip',window)
WaitSecs(5)
Screen('DrawText',window,'Goodbye world',xCenter,yCenter,1);
Screen('Flip',window)
WaitSecs(2)
Screen('CloseAll');

