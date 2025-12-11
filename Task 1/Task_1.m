close all;
clear all;

%Parameters
D = 1000 ;
bk = [1 , 0.9 , 0.8 , 0.7] ; % Impulse at 0,1000,2000,3000

%Read Audio File
[yt,Fs] = audioread("audio_sample.wav") ;

%% Digital Echo System H Before
% k = length(bk) ; % Here K=4
% h = zeros(1,(k-1)*D + 1) ; 
% % Making an array having zeros its length equal (4-1)*1000 = 3000
% % Starting from 1 to 3000+1
% % Why +1 ?? because the Array indecies must be positive integers 
% % (zero not allowed) --> there is nothing called h(0) 
% 
% 
% % Get Impulse responce
% for x = 1:k
%     index = (x-1)*D + 1 ; 
%     % at x = 1 --> index = 1
%     % at x = 2 --> index = 1001
%     % at x = 3 --> index = 2001
%     % at x = 4 --> index = 3001
% 
%     h(index) = bk(x) ; 
%     % at index 1 --> its value is bk(0) = 1
%     % at index 1001 --> its value is bk(0) = 0.9
%     % at index 2001 --> its value is bk(0) = 0.8
%     % at index 3001 --> its value is bk(0) = 0.7
% 
% end
% 
% % Filter Coeffiecents
% bh = h ;
% ah = 1 ;
% plot_filter_analysis(bh , ah , Fs , D ,k) ;
% 
% % Mean Square Calculation
% [mse_h, y_h] = compute_mse(bh , ah , yt) ;

%% Digital Echo System H
k = length(bk) ; % Here K=4

% This inserts (D-1) zeros between every sample in bk
h = upsample(bk, D);
% Note: This makes the vector slightly longer (length 4000 instead of 3001)
% because it puts zeros after the last number too. 
% Mathematically, this changes NOTHING. The filter is identical.

% Filter Coeffiecents
bh = h ;
ah = 1 ;
plot_filter_analysis(bh , ah , Fs , D ,k) ;

% Mean Square Calculation
[mse_h, y_h] = compute_mse(bh , ah , yt) ;

%% Equalizer System G.

% since ,G(Z) = 1/H(Z)
% Therefore ,the coefficients are reversed

% Filter Coeffiecents
ag = bh ;
bg = ah ;
plot_filter_analysis(bg , ag , Fs , D ,k) ;

% Mean Square Calculation
[mse_g, y_g] = compute_mse(bg , ag , yt) ;


