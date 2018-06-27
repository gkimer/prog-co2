clear
filename = 'Emisiones de dioxido de carbono por consumo energetico, separados por fuente.xlsx';
sheet = 4;

xlRange = 'E2:E525';
x = xlsread(filename,sheet,xlRange);

for i=1:524
    XN(i) = x(i)/max(abs(x));
end

autocorr(XN,523)
PorTrn = 0.7;




%----------------------------------------------------
% Generar data para Training
%----------------------------------------------------
Limite=floor(PorTrn*523);
xe=XN(:,1:Limite);
ye=xe;
save DataTrn xe ye
%----------------------------------------------------
% Generar data para Testing
%----------------------------------------------------
xv=XN(:,Limite+1:end);
yv=xv;
save DataTst xv yv