function mse_value = compute_mse(b , a , yt)

% b --> Numerator
% a --> Denominator
% yt --> Input signal

%% Mean Square Calculation
yt = mean(yt,2) ; % stereo --> mono

% y1 = conv(yt, h);
% This command is what you think you will do as you will apply
% convolution on the input with the impulse responce to get the output ,but
% bec. Convolution results in a longer signal (Length(x) + Length(h) - 1)
% so when subtracting the y1-yt the sizes won't be the same.

y1 = filter(b, a, yt); 
% Right Command bec. command is designed for systems where input 
% and output must stay synchronized.

error_signal = y1 - yt ; % Calculate the difference (error)
squared_error = error_signal .^ 2 ; % Square the error
mse_value = mean(squared_error) ; % Calculate the average (Mean)

disp(['The Mean Square Error is: ', num2str(mse_value)]); % Display the result

end
