# Model-of-government

This is a model of the economy where the governmet, firms, public and private sector are aggregated into first-order transfer functions and then connected via flows of money. 

- main.m is used to to run the simulations, contain important parameters, and is used for plotting. 
- JG_shock.slx and gov_shock.slx contain the Simulink models used in the simulations. 

About the modules is in the slx.-files: 

Employment takes the total flow of wages for the respective sectors as input. It then divides these flows with the pre-determined individual salaries. As a result, it obtains the number of people employed in each sector, and it sends out "Total employment".

The Regulator takes in "Total employment", compares it with the target employment, and uses a PID-regulator to calculate an appropriate fiscal stimulus. The regulator was tuned to obtain a quick response to account for the delays in the system, while at the same time not overshooting target employment because it can lead to inflation, as argued in subsection ~\ref{sec:inflation}. As a result, there will be a lag before "Total Employment" reaches target employment, and the regulator calculates the required stimulus for the Job Guarantee to avoid unemployment. 

Allocate resources divides the government spending into wages to the Job Guarantee, wages to the public sector and government consumption from firms. First, the JG-stimulus is subtracted from the total inflow, and then the rest is divided from a pre-determined constant for the ratio between public wages and government consumption from firms. 



