function [a b] = svm_train(xe,ye,Gamma,Sigma,m)
    Limite=366-m;
    K=svm_kernel_rbf(xe,Sigma);
    MId=eye(Limite);
    H=K+(1/Gamma*MId);
    [a b] = svm_pinv(H,ye);
end