% Notes about system: 
% Flow of money is given in MNOK

% 1 Parameters
% Time lags 
Tg = 1; %Government
Tpub = 0.25; %Public sector
Tpriv = 0.25; %Private sector
Tjg = 0.1; %Job Guarantee // NAV
Tf = 1; %Firms

% Regulator
Kp = 1*10^6; %Proportional part
Ki = 0.2*10^6; %Integral part
Kd = 0.1*10^6; %Derivative part

%Taxes
tx_priv = 0.4; %Private tax
tx_pub = 0.4; %Public tax
tx_firm = 0.3; %Firm tax
tx_JG = 0.3; %JG tax
VAT = 0.07; %Value-added Tax
JG_salary = 0.3;

%Start values
start_priv = 200*10^3; 
start_pub = 100*10^3;
start_gov = 100*10^4;
start_firms = 500*10^3;

%Other 
Gov_spend_to_firms = 0.35; %Amount of government spending directed at firms
target_employment = 2700000; %Ideal number of people employed
max_employment = 2750000; % Max number of people employed, above this will cause wage-inflation
priv_payroll = 0.5; %Part of money flowing from firms to private salaries

sim_time = 80; %Only use round numbers bc. stop_index

out = sim('JG_shock', sim_time);

% Data formatting
time = out.e_public.time;
%stop_index = sim_time*2.8;
length_index = size(time,1);
start_year = 23;
end_year = 80;
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
JG_pct_change = 100 * out.e_JG.data(start_index:stop_index) ./  Max_vector(start_index:stop_index)';
Total_pct_change = public_pct_change + private_pct_change + JG_pct_change;
% Plotting 

% Spending
figure('rend','painters','pos',[10 100 750 400])
hold on;
plot(time(start_index:stop_index),out.fiscal.data(start_index:stop_index), 'b:', 'LineWidth',2);
plot(time(start_index:stop_index),out.taxes.data(start_index:stop_index)-median_taxes, 'c', 'LineWidth',2);
plot(time(start_index:stop_index),out.total_spend.data(start_index:stop_index)-median_spend, 'r--', 'LineWidth',2);
%plot(time(start_index:stop_index),out.JG_stimulus.data(start_index:stop_index), 'g-.', 'LineWidth',2);
title("Stimulus, spending and taxes");
xlabel("Time [Year]");
ylabel("Money[MNOK]");
grid on;
hold off;
%legend({"Fiscal stimulus","Change in taxes", "Change in total spend", "JG stimulus"}, "Location", "northeast");
legend({"Fiscal stimulus","Change in taxes", "Change in total spend"}, "Location", "northeast");

% Employment in sectors
figure('rend','painters','pos',[1 600 750 400])
hold on;
plot(time(start_index:stop_index), public_pct_change, 'b:', 'LineWidth',2);
plot(time(start_index:stop_index), private_pct_change, 'c', 'LineWidth',2);
%plot(time(start_index:stop_index), JG_pct_change, 'r--', 'LineWidth',2);
plot(time(start_index:stop_index), Total_pct_change, 'g-.', 'LineWidth',2);
title("Change in employment for sectors");
xlabel("Time [Year]");
ylabel("Employment[%]");
grid on;
hold off;
%legend({"Public", "Private","JG", "Total"}, "Location", "northeast");
legend({"Public", "Private","Total"}, "Location", "northeast");


% Target employment
figure('rend','painters','pos',[750 100 750 400])
hold on;
plot(time(start_index:stop_index),(out.e_private.data(start_index:stop_index) + out.e_public.data(start_index:stop_index)), 'b');
plot(time(start_index:stop_index),out.e_total.data(start_index:stop_index), 'g');
plot(time(start_index:stop_index),Max_vector(start_index:stop_index), "--");
plot(time(start_index:stop_index),Target_vector(start_index:stop_index), "--");
title("Employment");
xlabel("Time [Year]");
ylabel("Employment[People]");
grid on;
hold off;
legend({"Private + Public" "Private + Public + JG", "Max Employment", "Target Employment"}, "Location", "northeast");
%legend({"Private + Public", "Max Employment", "Target Employment"}, "Location", "northeast");

% Consumption
figure('rend','painters','pos',[750 600 750 400])
hold on;
%plot(time(start_index:stop_index),out.c_public.data(start_index:stop_index));
plot(time(start_index:stop_index),out.c_private.data(start_index:stop_index), 'b');
%plot(time(start_index:stop_index),out.BNP.data(start_index:stop_index));
plot(time(start_index:stop_index),out.total_spend.data(start_index:stop_index), 'g');
title("Demand in the economy");
xlabel("Time [Year]");
ylabel("Money[MNOK]");
grid on;
hold off;
legend({"Household consumption", "Gov Budget"}, "Location", "northeast");

