clc;clear;close all;

load('projIB.mat');

Wp = 2500;
Ws = 4000;
Ap = 3; %40-37
As = 55;

Butter = designfilt('lowpassiir','PassbandFrequency',Wp, ...
         'StopbandFrequency',Ws,'PassbandRipple',Ap, ...
         'StopbandAttenuation',As,'SampleRate',fs,'DesignMethod','butter');
     
ChebyshevI = designfilt('lowpassiir','PassbandFrequency',Wp, ...
         'StopbandFrequency',Ws,'PassbandRipple',Ap, ...
         'StopbandAttenuation',As,'SampleRate',fs,'DesignMethod','cheby1');
     
ChebyshevII = designfilt('lowpassiir','PassbandFrequency',Wp, ...
         'StopbandFrequency',Ws,'PassbandRipple',Ap, ...
         'StopbandAttenuation',As,'SampleRate',fs,'DesignMethod','cheby2');
     

Elliptic = designfilt('lowpassiir','PassbandFrequency',Wp, ...
         'StopbandFrequency',Ws,'PassbandRipple',Ap, ...
         'StopbandAttenuation',As,'SampleRate',fs,'DesignMethod','ellip');
     
     
McClellan = designfilt('lowpassfir','PassbandFrequency',Wp, ...
         'StopbandFrequency',Ws,'PassbandRipple',Ap, ...
         'StopbandAttenuation',As,'SampleRate',fs,'DesignMethod','equiripple');    
     
Kaiser = designfilt('lowpassfir','PassbandFrequency',Wp, ...
         'StopbandFrequency',Ws,'PassbandRipple',Ap, ...
         'StopbandAttenuation',As,'SampleRate',fs,'DesignMethod','kaiserwin');


[butter_order, noise_butter, butter_coeff] = graphplot(Butter, fs,noisy, "ButterWorth Filter");

[chebyshevI_order, noise_chebyshevI, chebyshevI_coeff] = graphplot(ChebyshevI, fs, noisy, "chebyshevI filter");

[chebyshevII_order, noise_chebyshevII, chebyshevII_coeff] = graphplot(ChebyshevII, fs, noisy, "chebyshevII filter");

[elliptic_order, noise_elliptic, elliptic_coeff] = graphplot(Elliptic, fs, noisy, "elliptic filter");

[McClellan_order, noise_McClellan, McClellan_coeff] = graphplot(McClellan, fs, noisy, "Parks-McClellan filter");

[Kaiser_order, noise_Kaiser, Kaiser_coeff] = graphplot(Kaiser, fs, noisy, "Kaiser filter");

disp("Order of Butterworth filter: " + butter_order);
disp("# of Multiplies for  Butterworth filter: " + butter_coeff);

disp("Order of chebyshevI filter: " + chebyshevI_order);
disp("# of Multiplies for chebyshevI filter: " + chebyshevI_coeff);

disp("Order of chebyshevII filter: " + chebyshevII_order);
disp("# of Multiplies for chebyshevII filter: " + chebyshevII_coeff);

disp("Order of elliptic filter: " + elliptic_order);
disp("# of Multiplies for elliptic filter: " + elliptic_coeff);

disp("Order of Parks-McClellan filter: " + McClellan_order);
disp("# of Multiplies for Parks-McClellan filter: " + McClellan_coeff);

disp("Order of Kaiser filter: " + Kaiser_order);
disp("# of Multiplies for Kaiser filter: " + Kaiser_coeff);

% All the output sound are very good
% There seems to be a background noise can be heard and those are a little
% different with each filter

% Butterworth has very quiet background noise
% Chebyshev I also has very quiet background noise
% Chebyshev II has higher pitched and more noticeable background noise
% Elliptic also has more noticeable background noise
% McClellan also has more noticeable background noise, although lower pitched that Elliptic & Chebyshev II
% Kaiser has quiet background noise, more noticeable than Butterworth and Chebyshev I but less noticeable than Chebyshev II, Elliptic, and McClellan