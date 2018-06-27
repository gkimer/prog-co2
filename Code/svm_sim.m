function [zv] = smv_train(xe,Sigma2,xv,a,b)
    K=svm_kernel_rbf(xe,Sigma2,xv);
    zv=a'*K+b;
end