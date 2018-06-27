clear
load DataQ1AR

RMSEOp = RMSE(mOp);
MAEOp = MAE(mOp);
R2Op = R2(mOp);

fprintf('\n ===========================\n')
fprintf(' RMSE     : %f\n',RMSEOp) 
fprintf(' MAE      : %f\n',MAEOp) 
fprintf(' R2       : %f\n',R2Op*100) 
fprintf('\n ===========================\n')
%=================================
% BEST FIT 
%=========================
% figure(2)
% plot(log(Bfit),'-r')
% title('Training: Convergence')
% xlabel('Iteration number')
% ylabel('Best Run for  log(MSE)')
% axis tight
% grid on

%==============================
t1=1:numel(yv(1,mOp+1:tamanoXv));
t2=1:numel(yv(1,mOp+1:tamanoXv));
t=1:numel(yv(1,mOp:tamanoXv));
figure(3)
plot(t1,yv(1,mOp+1:tamanoXv),t2,YOp,'-r')
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