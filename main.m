% Notes about system: 
% Flow of money is given in MNOK

% 1 Parameters
% Time lags 
Tg = 1; %Government
Tpub = 0.5; %Public sector
Tpriv = 0.5; %Private sector
Tjg = 0.9; %Job Guarantee // NAV
Tss = 0.9;
Tf = 0.3; %Firms
% Regulator
Kp = 1*10^6; %Proportional part
Ki = 0.2*10^6; %Integral part
Kd = 0.1*10^6; %Derivative part

%Taxes
tx_priv = 0.4; %Private tax
tx_pub = 0.35; %Public tax
tx_firm = 0.3; %Firm tax
tx_JG = 0.3; %JG tax
VAT = 0.07; %Value-added Tax
JG_salary = 0.3;

%Other 
Gov_spend_to_firms = 0.35; %Amount of government spending directed at firms
target_employment = 2700000; %Ideal number of people employed
max_employment = 2750000; % Max number of people employed, above this will cause wage-inflation
structural_unemp = 0; % Number of people structurally unemployed
Start = 1*10^6; %Initialize economy (1000mrd)
Amp = 0.1*10^6; %business cycle (100mrd)
priv_payroll = 0.5; %Part of money flowing from firms to private salaries
JG_delay = 1;


sim_time = 80; %Only use round numbers bc. stop_index

out = sim('JG_shock', sim_time);

% Data formatting
time = out.e_public.time;
%stop_index = sim_time*2.8;
length_index = size(time,1);
start_year = 27;
end_year = 67;
start_index = round(start_year*length_index/sim_time); %To avoid the part where the economy starts up
stop_index = round(end_year*length_index/sim_time);
Max_vector = max_employment*ones(1,stop_index);
Target_vector = target_employment*ones(1,stop_index);

median_taxes = median(out.taxes.data);
median_spend = median(out.total_spend.data);

% Convert series to percentages 
public_pct = 100 * out.e_public.data(start_index:stop_index) ./  Max_vector(start_index:stop_index)';
public_pct_change = public_pct - median(public_pct);
private_pct = 100 * out.e_private.data(start_index:stop_index) ./  Max_vector(start_index:stop_index)';
private_pct_change = private_pct - median(private_pct);

% Plotting 

% Spending
figure('rend','painters','pos',[10 100 750 400])
hold on;
plot(time(start_index:stop_index),out.fiscal.data(start_index:stop_index));
plot(time(start_index:stop_index),out.taxes.data(start_index:stop_index)-median_taxes);
plot(time(start_index:stop_index),out.total_spend.data(start_index:stop_index)-median_spend);
%plot(time(start_index:stop_index),out.JG_stimulus.data(start_index:stop_index));
plot(time(start_index:stop_index),out.gov_debt.data(start_index:stop_index));
title("Spending, taxes and debt");
xlabel("time [Year]");
ylabel("Money[MNOK]");
grid on;
hold off;
%legend({"Fiscal stimulus","Change in taxes", "Change in total spend", "JG stimulus", "Gov Debt"}, "Location", "northeast");
legend({"Fiscal stimulus","Change in taxes", "Change in Gov budget", "Gov Debt"}, "Location", "northeast");


% Employment in sectors
figure('rend','painters','pos',[1 600 750 400])
hold on;
plot(time(start_index:stop_index), public_pct_change);
plot(time(start_index:stop_index), private_pct_change);
%plot(time(start_index:stop_index), 100 * out.e_JG.data(start_index:stop_index) ./  Max_vector(start_index:stop_index)');
title("Change in employment for sectors");
xlabel("time [year]");
ylabel("Employment[%]");
grid on;
hold off;
%legend({"Public", "Private","JG"}, "Location", "northeast");
legend({"Public", "Private",}, "Location", "northeast");

% Target employment
figure('rend','painters','pos',[750 100 750 400])
hold on;
plot(time(start_index:stop_index),(out.e_private.data(start_index:stop_index) + out.e_public.data(start_index:stop_index)));
%plot(time(start_index:stop_index),out.e_total.data(start_index:stop_index));
plot(time(start_index:stop_index),Max_vector(start_index:stop_index), "--");
plot(time(start_index:stop_index),Target_vector(start_index:stop_index), "--");
title("Employment");
xlabel("time [year]");
ylabel("Employment[People]");
grid on;
hold off;
%legend({"Private + Public" "Private + Public + JG", "Max Employment", "Target Employment"}, "Location", "northeast");
legend({"Private + Public", "Max Employment", "Target Employment"}, "Location", "northeast");

% Consumption
figure('rend','painters','pos',[750 600 750 400])
hold on;
%plot(time(start_index:stop_index),out.c_public.data(start_index:stop_index));
plot(time(start_index:stop_index),out.c_private.data(start_index:stop_index));
%plot(time(start_index:stop_index),out.BNP.data(start_index:stop_index));
plot(time(start_index:stop_index),out.total_spend.data(start_index:stop_index));
title("Demand in the economy");
xlabel("time [Year]");
ylabel("Money[MNOK]");
grid on;
hold off;
legend({"Household consumption", "Gov Budget"}, "Location", "northeast");

%{
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
%}
