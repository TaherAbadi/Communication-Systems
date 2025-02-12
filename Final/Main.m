%Main
clc;
clear all;
close all;
%%%%ADC_Function Input
% n=input('Enter for n-bit PCM system : '); %Encodebook Bit Length
% fs=input('Enter Sampling Frequency : '); %Sampling Frequency
% signal= input('Enter voice signal: '); % Inpit Signal

%%%LineCode_function_Input
% Rb=input('Enter bit rate : ');
% rolloff=input('Enter rolloff factor : '); % rolloff factor
% r =input('Enter baud rate r: '); % baud rate
% A = input('Enter amplitude A: '); % amplitude

%%
% B = input('Enter channel bandwidth : ') ;
% N0 = input('Enter noise power spectral density : ') ;
% A_C = input('Enter amplitude A_Channel: '); % amplitude
% d = input('Enter d: '); % amplitude
n=3; %Encodebook Bit Length
fs=4000; %Sampling Frequency
signal=  'voice.wav'; % Inpit Signal
Rb = 1000; % Bit Rate
% rolloff factor
r =20; % baud rate
rolloff=6; % rolloff factor
A = 1; % amplitude
B = 12 ;

A_C = 1;
d = 20;
t=0:0.001:0.1;
[y,Fs] = audioread(signal); % audio file 
info = audioinfo(signal); % Information about audio file 
[SerialCode ,Vmax,Vmin,len_t,len_ts] = PCM_function(signal ,  n , fs);
[Pulse, Power,s,len_p] = Linecode_function(rolloff,r, A , SerialCode,Rb);
N0 = 1e-3*Power;
Pulse_output_channel = Channel(B,N0,A_C,Pulse,Rb,d);
 r_bit = Line_Decoder(Pulse_output_channel,SerialCode,r,d,s);
 sound_out = DAC_function(r_bit,n,Vmax,Vmin,len_p,len_t,len_ts)
 sound(sound_out,Fs)
