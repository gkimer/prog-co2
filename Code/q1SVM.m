clear
load DataTrn
load DataTst

tamanoXe= length(xe);
tamanoXv= length(xv);

% Parameters LS-SVM
iG=[-2 3]; % Gamma interval
N1=6; % Number samples
iS=[-1 2]; % Sigma2 interval
N2=6; % Number samples
Base=2; % Base 2 or 10
Param=svm_par(iG,N1,iS,N2,Base);

for m=1:30
    [X] = desfasar(m,tamanoXe,xe);

    Y = X(m+1:tamanoXe,1);
    X = X(m+1:tamanoXe,2:m+1);
    
    [Xtst] = desfasar(m,tamanoXv,xv);
    YTst = Xtst(m+1:tamanoXv,1);
    XTst{m} = Xtst(m+1:tamanoXv,2:m+1);
    XT = XTst{m};
    YT = YTst;

    for i=1:(N1*N2)
        % Training
        Gamma =Param{i}.gamma;
        Sigma2=Param{i}.sigma;
        [a b]=svm_train(X,Y,Gamma,Sigma2,m);
        % testing
        zv=svm_sim(X,Sigma2,XT,a,b);
        % Accuracy
        er=svm_perf(YT,zv);
        Err(i)=er;
        zeta{i}=zv;
        Coef(i).a=a; Coef(i).b=b;
    end
    [minimo ind(m)] = min(Err);
    MinErr(m) = Err(ind(m));
    MinZeta{m} = zeta{ind(m)};
     er= YT'-MinZeta{m};
%     %er = MinErr(m);
     RMSE(m)=sqrt(mean(er.*er));
     MAE(m)= mean(abs(er));
     R2(m)=var(er)/var(yv(1,m+1:tamanoXv));
     R2(m)=(1-R2(m));
    MinCoef(m).a = Coef(ind(m)).a;
    MinCoef(m).b = Coef(ind(m)).b;
end
[minimo mOp] = min(MinErr);
%[minimo mOp] = max(R2);
m = mOp;
save Parametros MinErr MinCoef Param m ind R2
