clear
load DataTrn
load DataTst

tamanoXe= length(xe);
tamanoXv= length(xv);

for m=1:30
    [X] = desfasar(m,tamanoXe,xe);

    Y = X(m+1:tamanoXe,1);
    X = X(m+1:tamanoXe,2:m+1);

    A{m}=X\Y;

    [Xtst] = desfasar(m,tamanoXv,xv);
    
    XTst{m} = Xtst(m+1:tamanoXv,2:m+1);
    YTst{m} = XTst{m}*A{m};
    
    YT = YTst{m};
    er=yv(1,m+1:tamanoXv)'-YT(1:tamanoXv-m,1);
    %=== Metrics========
    RMSE(m)=sqrt(mean(er.*er));
    MAE(m)= mean(abs(er));
    R2(m)=var(er)/var(yv(1,m+1:tamanoXv));
    R2(m)=(1-R2(m));
end

[j,k] = max(R2);
mOp = k;
AOp = A{k};
YOp = XTst{k}*AOp;

save DataQ1AR mOp RMSE MAE R2 tamanoXv yv YOp