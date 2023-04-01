function [ multiSVMstruct ] =multiSVMtrain( traindata,nclass,c)  
%��������SVM������  
%   Detailed explanation goes here
global samples;
for i=1:nclass-1  
    for j=i+1:nclass  
        X=[traindata(samples*(i-1)+1:samples*i,:);traindata(samples*(j-1)+1:samples*j,:)];  
        Y=[ones(samples,1);zeros(samples,1)];  
        multiSVMstruct{i}{j}=fitcsvm(X,Y,'KernelFunction','kfun_rbf','BoxConstraint',c);  
    end  
end  
end  