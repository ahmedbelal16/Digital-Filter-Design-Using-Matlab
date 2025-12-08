clear all;
close all;
clc;
%Read Audio File
[yt,Fs] = audioread("audio_sample.wav") ;

%Stereo --> Mono & Ploting Time Domain
yt=mean(yt,2) ; %due to that the audio signal is stereo so we got the mean to make it mono
%time domain analysis & Ploting the Time domain
[N] = plot_time_domain(yt);

%Frequency domain analysis & Ploting the Magnitude Spectrum
[yf]=plot_frequency_domain(yt, Fs);

%Energy of Time Domain using Parseval's Relation
E = sum(yt.^2) ;
fprintf('Energy of Signal in Time Domain = %E\n',E);

%Energy of Frequency Domain using Parseval's Relation
E = (1/N)*sum(yf.^2) ;
fprintf('Energy of Signal in Frequncy Domain = %E\n',E);
