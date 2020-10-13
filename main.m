Tg = 0.1; %tidskonstant government
sigma = 0.5; %offentlig pengebruk
tx = 0.4; %skatt
To = 0.01; %tidskonstant offentlig ansatte
Tp = 0.01; %tidskonstant nye lån
Tf = 0.5; %tidskonstant firmaer
VAT = 0.07; %Value-added Tax
S = 1; %lønnskrav 
target = 3500000; %arbiedsutnyytelse
Kp = 10000;

sim_time = 200;

out = sim('gov_extended_2', sim_time);

figure('rend','painters','pos',[10 10 750 400])
hold on;
plot(out.offentlig, "b");
plot(out.privat, "r");
plot(out.total, "g");
title("Employment");
xlabel("time [s]");
ylabel("employment");
grid on;
hold off;
legend({"offentlig","privat","total"}, "Location", "northeast");
%legend({"Ck", "Cw"}, "Location", "northeast");
%legend({"Loans"}, "Location", "northeast");

figure('rend','painters','pos',[10 10 750 400])
hold on;
plot(out.penger, "b");
plot(out.taxes, "r");
plot(out.spending, "g");
title("Money");
xlabel("time [s]");
ylabel("Money");
grid on;
hold off;
legend({"penger","taxes","spending"}, "Location", "northeast");
