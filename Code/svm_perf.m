function [er] = svm_perf(yv,zv)
    %er = yv'-zv;
    er = mse(yv,zv');
end