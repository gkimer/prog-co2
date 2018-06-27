function [X]= desfasar(m,tamano,x)
    X = zeros(tamano,m+1);
    for i=1:m+1
        cont = 0;
        for j=i:tamano
            cont = cont + 1;
            X(j,i)=x(cont);
        end
    end
end