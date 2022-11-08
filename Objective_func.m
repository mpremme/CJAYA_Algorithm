% Enhanced CJAYA Algorithm %

% Cite: M. Premkumar, Pradeep Jangir, R. Sowmya, M.E. Rajvikram, 
% and B. Santhosh Kumar, “Enhanced Chaotic JAYA Algorithm for Parameter 
% Estimation of Photovoltaic Cell/Modules,” ISA Transactions (Elsevier), 
% Vol. 116, pp. 139-166, 2021. DOI: https://doi.org/10.1016/j.isatra.2021.01.045


function [lb,ub,dim,fobj] = Objective_func(F)
switch F
	case 'F1'
        fobj = @F1;
        lb = [ 0.0  0.0      0.0  0.0    1.0];
        ub = [ 1.0  1.0e-06  0.5  100.0  2.0];
        dim = 5;
end
end

function o = F1(x)   
        o = PV_model_single(x); 
end

function  result = calculate_objective_single(x,Vpv,Ipv)
Iph = x(1);
ISD = x(2);
Rs	= x(3);
Rsh = x(4);
n	= x(5); 
q = 1.60217646e-19;
k = 1.3806503e-23;
T = 273.15 + 33.0;
V_t = k * T / q;
result = Iph - ISD * ( exp( (Vpv + Ipv*Rs) / (V_t*n) ) - 1.0 ) - ( (Vpv + Ipv*Rs)/Rsh ) - Ipv;
end

function obj = PV_model_single(x)
a = load('cell_data.txt');
for j=1:26
    error_value(j) = calculate_objective_single(x,a(j,1),a(j,2));
end
obj = sqrt(sum(error_value.^2)/26);
end