
clc; clear all;
t=1:128; f=1;

normal_sine=sin(2*pi*f*t/128)*127 +128;
inverted_sine = -sin(2*pi*f*t/128)*127 +128;

normal_sine=round(normal_sine);
look_up1 = dec2hex(normal_sine);

inverted_sine = round(inverted_sine);
look_up2 = dec2hex(inverted_sine);

figure(1); plot(t,normal_sine);
figure(2); plot(t,inverted_sine);
