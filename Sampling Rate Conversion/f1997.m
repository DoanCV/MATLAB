clc
clear
close all

% Digital Signals Processing Fall 2020
% Project #1
% Derek Lee, Brian Doan, Steven Lee


%% Load audio

[ m, FREQ_INPUT ] = audioread('Wagner.wav');
FREQ_OUTPUT = 24000;


%% Convert

m_converted = srconvert( m );


%% Play original sound

%sound_old = audioplayer( m/5, FREQ_INPUT );
%play( sound_old );


%% Play new sound

sound_new = audioplayer( m_converted/5, FREQ_OUTPUT );
%play( sound_new );


%% Save sound to file

audiowrite( 'upsampled.wav', m_converted, FREQ_OUTPUT );


%% Test on impulse

%y = srconvert(([1 zeros(1,3000)])');
%verify(y);

