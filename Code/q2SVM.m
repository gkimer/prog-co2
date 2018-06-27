
clear
load Parametros
load DataTrn
load DataTst
tamanoXe= length(xe);
tamanoXv= length(xv);

[X] = desfasar(m,tamanoXe,xe);
Y = X(m+1:tamanoXe,1);
X = X(m+1:tamanoXe,2:m+1);
[Xtst] = desfasar(m,tamanoXv,xv);
YTst = Xtst(m+1:tamanoXv,1);
XTst = Xtst(m+1:tamanoXv,2:m+1);

Gamma=Param{ind(m)}.gamma;
Sig2=Param{ind(m)}.sigma;
a=MinCoef(m).a;
b=MinCoef(m).b;
zv=svm_sim(X,Sig2,XTst,a,b);
er = YTst'-zv;

RMSEOp = sqrt(mean(er.*er));
MAEOp = mean(abs(er));
R2Op = var(er)/var(YTst);
R2Op = 1-R2Op;
fprintf('\n ===========================\n')
fprintf(' RMSE     : %f\n',RMSEOp) 
fprintf(' MAE      : %f\n',MAEOp) 
fprintf(' R2       : %f\n',R2Op*100) 
fprintf('\n ===========================\n')

t1=1:numel(yv(1,m+1:tamanoXv));
t2=1:numel(yv(1,m+1:tamanoXv));
t=1:numel(yv(1,m:tamanoXv));
figure(3)
plot(t1,yv(1,m+1:tamanoXv),t2,zv,'-r')
title('Testing')
xlabel('time (n°Meses)')
ylabel('Dioxido de Carbono')
legend('Valor Actual','Valor Estimado');
grid on

%Graficar los valores encontrados
x=1:numel(R2);
figure(4)
plot(x,R2*100,'b--o')
title('Numero de Memoria VS R2')
xlabel('Numero de Memoria')
ylabel('R2')
grid on