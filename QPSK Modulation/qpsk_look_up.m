clear;
t=0:127; f=8;

qpsk_10 =  0.707*( (sin(2*pi*f*t/128)*127 ) +(cos(2*pi*f*t/128)*127)) +128 ;
qpsk_00 = -0.707*( (sin(2*pi*f*t/128)*127 ) -(cos(2*pi*f*t/128)*127)) +128 ;
qpsk_01 = -0.707*( (sin(2*pi*f*t/128)*127 ) +(cos(2*pi*f*t/128)*127)) +128 ;
qpsk_11 =  0.707*( (sin(2*pi*f*t/128)*127 ) -(cos(2*pi*f*t/128)*127)) +128 ;

figure(1);
subplot(4,1,1);plot(t,qpsk_10);title('qpsk 10');
subplot(4,1,2);plot(t,qpsk_00);title('qpsk 00');
subplot(4,1,3);plot(t,qpsk_01);title('qpsk 01');
subplot(4,1,4);plot(t,qpsk_11);title('qpsk 11');

qpsk_10_round = round(qpsk_10);
qpsk_10_look_up = dec2hex(qpsk_10_round,2);

qpsk_00_round = round(qpsk_00);
qpsk_00_look_up = dec2hex(qpsk_00_round,2);

qpsk_01_round = round(qpsk_01);
qpsk_01_look_up = dec2hex(qpsk_01_round,2);

qpsk_11_round = round(qpsk_11);
qpsk_11_look_up = dec2hex(qpsk_11_round,2);
