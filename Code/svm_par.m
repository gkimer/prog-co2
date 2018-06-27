function [Param] = svm_par(iG,N1,iS,N2,Base)
    gama_inf = Base.^iG(1);
    gama_sup = Base.^iG(2);
    sigma_inf = Base.^iS(1);
    sigma_sup = Base.^iS(2);
    inter_gama=(gama_sup-gama_inf)/(N1-1);
    inter_sigma=(sigma_sup-sigma_inf)/(N2-1);
    arr_gama=zeros(N1,1);
    arr_sigma=zeros(N2,1);
    for i=1:N1
        if i==1
            arr_gama(i,1)=gama_inf;
        else
            arr_gama(i,1)=arr_gama(i-1,1)+inter_gama;
        end
    end
    for i=1:N2
        if i==1
            arr_sigma(i,1)=sigma_inf;
        else
            arr_sigma(i,1)=arr_sigma(i-1,1)+inter_sigma;
        end
    end
    for i=1:N1
        for j=1:N2
            Param{i,j}.gamma=arr_gama(i);
            Param{i,j}.sigma=arr_sigma(j);
        end
    end
Param;