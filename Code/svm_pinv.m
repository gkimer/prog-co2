function [a b] = svm_pinv(H,ye)    
    Ones=ones(size(ye,1),1);
    mu=H\Ones;
    eta=H\ye;
    s=Ones'*mu;
    b=(mu'*ye)./s;
    a=eta-(mu*b);
end