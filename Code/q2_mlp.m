clear
load 'DataMLP'

fprintf('\n  Memoria Optimo: %f ',MOptimo);
[~,index]=min(totalErrores{MOptimo});
fprintf('\n  Nodos Ocultos: %f ',index);
er=YFinal-ZFinal;
%=== Metrics========
RMSE=sqrt(mean(er.*er));
MAE= mean(abs(er));
R2=var(er)/var(YFinal);
R2=(1-R2);

fprintf('\n ===========================\n')
fprintf(' RMSE     : %f\n',RMSE) 
fprintf(' MAE      : %f\n',MAE) 
fprintf(' R2       : %f\n',R2*100) 
fprintf('\n ===========================\n')
%=================================
% BEST FIT 
%=========================
%Mostramos el rendimiento de la red
figure(2)
plot(log(TRFinal.perf)*10,'-b')
title('Best MLP+LM')
xlabel('Iteration number')
ylabel('MSE(DB)')
axis tight
grid on

%==============================
t=1:numel(YFinal);
figure(3)
plot(t,YFinal,t,ZFinal,'-r')
title('Testing')
xlabel('time(n°Meses)')
ylabel('Dioxido de Carbono')
legend('Valor Actual','Valor Estimado');
grid on


%Graficar los valores encontrados
x=1:numel(bestR2M);
figure(4)
plot(x,bestR2M*100,'b--o')
title('Numero de Memoria VS R2')
xlabel('Numero de Memoria')
ylabel('R2')
grid on

%Graficar los valores encontrados
x=1:Nh;
figure(1)
plot(x,log(totalErrores{MOptimo})*10,'b--o')
title('Nodo Oculto VS MSE')
xlabel('Hidden Nodes')
ylabel('MSE (DB)')
grid on

