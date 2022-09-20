clear;
t=0:127; f1=4; f2=8;


bfsklogic0 = sin(2*pi*f1*t/128)*127 +128 ;
bfsklogic1 = sin(2*pi*f2*t/128)*127 +128 ;

subplot(2,1,1);plot(t,bfsklogic0);title('BFSK LOGIC 0');
subplot(2,1,2);plot(t,bfsklogic1);title('BFSK LOGIC 1');

bfsklogic0_round   = round(bfsklogic0);
bfsklogic0_look_up = dec2hex(bfsklogic0_round,2);

bfsklogic1_round = round(bfsklogic1);
bfsklogic1_look_up = dec2hex(bfsklogic1_round,2);
