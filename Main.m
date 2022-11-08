% Enhanced CJAYA Algorithm %

% Cite: M. Premkumar, Pradeep Jangir, R. Sowmya, M.E. Rajvikram, 
% and B. Santhosh Kumar, “Enhanced Chaotic JAYA Algorithm for Parameter 
% Estimation of Photovoltaic Cell/Modules,” ISA Transactions (Elsevier), 
% Vol. 116, pp. 139-166, 2021. DOI: https://doi.org/10.1016/j.isatra.2021.01.045

clear; 
close all;
clc;

nP=40;         

Func_name='F1'; %SDM Fitness Function

MaxIt=500;      % Maximum number of iterations

[lb,ub,dim,fobj]=Objective_func(Func_name);

[Best_fitness,BestPositions,Convergence_curve]=CJAYA(nP,MaxIt,lb,ub,dim,fobj);

%% Draw objective space
subplot(1,1,1)
semilogy(Convergence_curve,'Color','r','linewidth',3);