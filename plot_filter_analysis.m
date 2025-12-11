function plot_filter_analysis(b , a , Fs , D , k)

% b --> Numerator
% a --> Denominator
% Fs --> Sampling Frequency
% D --> Delay value
% k --> Number of coefficients

%% Create one figure window for all plots
figure ;

%% Ploting Pole-Zero 
subplot(3,2,1) ;
zplane(b,a) ;
title('Pole-Zero Plot of Echo System H(z)') ;
grid on ;


%% Frequency Response Calculation
frmsz = 8192 ; % 2^13 
f = (-frmsz/2:(frmsz/2)-1)*(Fs/frmsz) ; % Frequency axis
[H, Wf] = freqz(b , a , frmsz , "whole") ; % Frequency response
% Without 'whole' You get 0 to pi ,but With 'whole' You get 0 to 2*pi 
% So we use it because he said get it for -Fs/2 to Fs/2

H_shift = fftshift(H) ;
% moves zero-frequency to the center of the spectrum.
% |___________|___________| ---> |_____|_____0_____|_____|
% 0           Fs            --->   -Fs/2          Fs/2


%% Magnitude Response
subplot(3,2,2) ;
plot(f, 20*log10(abs(H_shift))) ;
grid on ;
title('Magnitude Response in dB') ;
xlabel('Frequency (Hz)') ;
ylabel('Magnitude (dB)') ;


% Phase Response
subplot(3,2,3) ;
plot(f, angle(H_shift)) ;
grid on ;
title('Phase Response') ;
xlabel('Frequency (Hz)') ;
ylabel('Phase (radians)') ;


%% Group Delay
[gd,Wg] = grpdelay (b,a,frmsz,'whole') ;
gd_shift = fftshift(gd) ;
subplot(3,2,4) ;
plot (f,gd_shift) ;
grid on ;
title('Group Delay') ;
xlabel('Frequency (Hz)') ;
ylabel('Group Delay (samples)') ;


%% Ploting Impulse Response
subplot(3,2,5) ;
delta = [1, zeros(1, (k-1)*D)] ;
imp_resp = filter(b, a, delta) ;
% Make impulse response as i did in the for loop

stem(0:length(imp_resp)-1, imp_resp, 'filled') ;
title('Impulse Response') ;
xlabel('Samples (n)') ;
ylabel('Amplitude') ;


end
