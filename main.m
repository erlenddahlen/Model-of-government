% Notes about system: 
% Flow of money is given in MNOK

% 1 Parameters
% Time lags 
Tg = 0.3; %Government
Tpub = 0.9; %Public sector
Tpriv = 0.9; %Private sector
Tjg = 0.9; %Job Guarantee // NAV
Tf = 0.3; %Firms
% Regulator
Kp = 1*10^6; %Proportional part
Ki = 0*0.2*10^6; %Integral part
Kd = 0.1*10^6; %Derivative part

%Taxes
tx_priv = 0.4; %Private tax
tx_pub = 0.35; %Public tax
tx_firm = 0.3; %Firm tax
tx_JG = 0.3; %JG tax
VAT = 0.07; %Value-added Tax
JG_salary = 0.3;

%Other 
Gov_spend_to_firms = 0.75; %Amount of government spending directed at firms
target_employment = 2700000; %Ideal number of people employed, cannot overshoot this 
structural_unemp = 100000; % Number of people structurally unemployed
Start = 1*10^6; %Initialize economy (1000mrd)
Amp = 0.1*10^6; %business cycle (100mrd)
priv_payroll = 0.5; %Part of money flowing from firms to private salaries

sim_time = 100;

out = sim('JG_shock', sim_time);

figure('rend','painters','pos',[1 600 750 400])
hold on;
plot(out.e_public, "b");
plot(out.e_private, "r");
plot(out.e_JG);
plot(out.e_total, "g");
%plot(out.target_emp);
title("Employment");
xlabel("time [year]");
ylabel("Employment[People]");
grid on;
hold off;
legend({"public","private","JG","total", "target"}, "Location", "northeast");
%legend({"Ck", "Cw"}, "Location", "northeast");
%legend({"Loans"}, "Location", "northeast");

figure('rend','painters','pos',[10 100 750 400])
hold on;
plot(out.fiscal, "b");
plot(out.taxes, "r");
%plot(out.business_cycle);
plot(out.total_spend, "g");
plot(out.JG_stimulus);
title("Government");
xlabel("time [Year]");
ylabel("Money[MNOK]");
grid on;
hold off;
legend({"fiscal stimulus","taxes", "total spend", "JG stimulus"}, "Location", "northeast");
%{
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
%}
