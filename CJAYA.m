% Enhanced CJAYA Algorithm %

% Cite: M. Premkumar, Pradeep Jangir, R. Sowmya, M.E. Rajvikram, 
% and B. Santhosh Kumar, “Enhanced Chaotic JAYA Algorithm for Parameter 
% Estimation of Photovoltaic Cell/Modules,” ISA Transactions (Elsevier), 
% Vol. 116, pp. 139-166, 2021. DOI: https://doi.org/10.1016/j.isatra.2021.01.045

function[Best_Cost,Best_X,Convergence_curve]=CJAYA(N,Max_IT,lb,ub,dim,fobj)

%Initialization
X = lb+rand(N,dim).*(ub-lb);

	for i=1:N
        fit(i,:) = fobj(X(i,:));   
	end  

FES = 1;
Log_C=rand;

Max_FES=dim*Max_IT;

[Best_Cost,ind] = min(fit);
Best_X = X(ind,:);

Convergence_curve(1) = Best_Cost;
      
while FES < Max_FES
            
	[~,r1] = sort(fit); 
	Best_X = X(r1(1),:);  
	Worst_X= X(r1(end),:); 
              
    if fit(r1(end),:)==0
        b=1;
    else
        b=abs(fit(r1(1),:)/(fit(r1(end),:)))^2;
    end          
    for i=1:N
        Xnew=zeros(1,dim);
        if i~=r1(1)
            if rand<rand
                for j=1:dim
                    Xnew(j) = X(i,j) + rand*(Best_X(j) -abs(X(i,j)))-b*rand*(Worst_X(j) -abs(X(i,j))); 
                end
            end
        else
            Log_C=4*Log_C*(1-Log_C);
                for k=1:dim
                    Xnew(k) = X(i,k) + Log_C*(Best_X(k)-abs(X(i,k)))-Log_C*(Worst_X(k)-abs(X(i,k))); 
                end
        end
        
        FU=Xnew>ub;FL=Xnew<lb;Xnew=(Xnew.*(~(FU+FL)))+ub.*FU+lb.*FL;
        f_new = fobj(Xnew'); 
        
        if f_new<fit(i)
        	X(i,:)=Xnew;
           	fit(i)=f_new;
        end       
        if fit(i)<Best_Cost
            Best_X=X(i,:);
            Best_Cost=fit(i);
        end 
    end
    FES=FES+1;
    Convergence_curve(FES)=Best_Cost; 
    disp(['FES: ' num2str(FES) ', Best Cost = ' num2str(Best_Cost)]);
end  
    disp(['SDM Variables : ' num2str(Best_X)]);
    disp(['RMSE Value : ' num2str(Best_Cost)]);
end