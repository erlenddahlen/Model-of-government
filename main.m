% Notes about system: 
% Flow of money is given in MNOK

% 1 Parameters
% Time lags 
Tg = 0.3; %Government
Tpub = 0.9; %Public sector
Tpriv = 0.9; %Private sector
Tf = 0.3; %Firms
% Regulator
Kp = 1*10^6; %Proportional part
Ki = 0.2*10^6; %Integral part
Kd = 0.2*10^6; %Derivative part
%Taxes
tx_priv = 0.4; %Private tax
tx_firm = 0.3; %Firm tax
VAT = 0.07; %Value-added Tax
%Other 
sigma = 0.6; %Amount of government spending directed at firms
target_employment = 2700000; %Ideal number of people employed
Start = 1*10^6; %Initialize economy (1000mrd)
Amp = 0.1*10^6; %business cycle (100mrd)

sim_time = 100;

out = sim('gov_modularised', sim_time);

figure('rend','painters','pos',[1 600 750 400])
hold on;
plot(out.e_public, "b");
plot(out.e_private, "r");
plot(out.e_total, "g");
title("Employment");
xlabel("time [year]");
ylabel("Employment[People]");
grid on;
hold off;
legend({"public","private","total"}, "Location", "northeast");
%legend({"Ck", "Cw"}, "Location", "northeast");
%legend({"Loans"}, "Location", "northeast");

figure('rend','painters','pos',[10 100 750 400])
hold on;
plot(out.regulator, "b");
plot(out.taxes, "r");
plot(out.business_cycle);
plot(out.total_spend, "g");
title("Government");
xlabel("time [Year]");
ylabel("Money[MNOK]");
grid on;
hold off;
legend({"money-reg","taxes","business cycle", "total spend"}, "Location", "northeast");

figure('rend','painters','pos',[750 100 750 400])
hold on;
plot(out.c_public, "b");
plot(out.c_private, "r");
plot(out.BNP, "g");
title("Consumption");
xlabel("time [Year]");
ylabel("Money[MNOK]");
grid on;
hold off;
legend({"Goverment","Households","BNP"}, "Location", "northeast");

