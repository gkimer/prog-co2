
clear
load DataTrn
load DataTst
%Parametros iniciales
Nh=10;
Epoch=150;
Run=5;
%error = zeros(1:Nh);
Neta=cell(Nh,1);
zeta=cell(Nh,1);
NetRun=cell(Nh,1);
zetaRun=cell(Nh,1);
tamanoXv=numel(xv);
tamanoXe=numel(xe);
maximo=20;

for m = 1:maximo
    %optimo de los nodos
    [X] = desfasar(m,tamanoXe,xe);

    YEnt = X(m+1:tamanoXe,1);
    XEnt = X(m+1:tamanoXe,2:m+1);
    [Xtst] = desfasar(m,tamanoXv,xv);
    XTst = Xtst(m+1:tamanoXv,2:m+1);
    %Trasponemos las matrices para poder utilizarlas en la MLP

    B = XEnt';
    XEnt= B;
    B = YEnt';
    YEnt= B;
    B = XTst';
    XTst= B;
%     B = yv';
%     yv= B;

   
    for i = 1:Nh 
        %comenzar desde diferentes valores iniciales 
        for j = 1:Run

            % Training MLP

            [net Tr]=bp_lm(XEnt,YEnt,i,Epoch);

            %Testeamos el entrenamiento
            z=sim(net,XTst);
            errores = yv(1,m+1:tamanoXv)-z;
            Erun(j)= mse(abs(errores));
            NetRun{j} = net;
            zetaRun{j} = z;
            TRrun{j} = Tr;
        end
            [~,k]=min(abs(Erun));
            error(i)= Erun(k);
            Neta{i}=NetRun{k};
            zeta{i}=zetaRun{k};
            TRa{i} = TRrun{k};
            
    end
    %Guardar la mejor red en base al error cuadratico medio
    [~,k]=min(abs(error));
    errores2 = yv(1,m+1:tamanoXv)-zeta{k};
    R2=var(errores2)/var(yv(1,m+1:tamanoXv));
    R2=(1-R2);
    totalErrores{m}=error;
    bestR2M(m) = R2;
    Merror(m)= error(k);
    MNeta{m}=Neta{k};
    Mzeta{m}=zeta{k};
    MTRa{m} = TRa{k};
    fprintf('\n  MSE: %f ',Merror(m));
end
%Guardar la mejor configuracion de la memoria
[~,k] = max(bestR2M);
NetFinal = MNeta{k};
TRFinal = MTRa{k};
ZFinal = Mzeta{k};
YFinal= yv(1,k+1:tamanoXv);
MOptimo = k;

save DataMLP NetFinal TRFinal YFinal ZFinal bestR2M totalErrores MOptimo Merror
