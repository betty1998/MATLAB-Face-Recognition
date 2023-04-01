clc,clear  
npersons=40;%ѡȡ40���˵���  
global imgrow;  
global imgcol;  
global edit2
global samples
samples=5;
imgrow=112;  
imgcol=92;  
  
disp('��ȡѵ������......')%��ʾ�ھ��Ϊedit2���ı�����  
drawnow     %���´��ڵ����ݣ���Ȼ�������ʱ�Ż���ʾ������ֻ�ܿ������һ��  
f_matrix=ReadFace1(npersons,0);%��ȡѵ������  
nfaces=size(f_matrix,1);%��������������  
  
disp('ѵ������PCA������ȡ......')  
drawnow  
mA=mean(f_matrix);  
k=35;%��ά��20ά  
[pcaface,V]=fastPCA(f_matrix,k,mA);%���ɷַ�����������ȡ  
  
disp('ѵ�����ݹ淶��......')  
drawnow  
lowvec=min(pcaface);  
upvec=max(pcaface);  
scaledface = scaling( pcaface,lowvec,upvec);  
  
disp('SVM����ѵ��......')  
drawnow  
gamma=0.0078;  
c=128;  
multiSVMstruct=multiSVMtrain( scaledface,npersons,c);  
save('recognize.mat','multiSVMstruct','npersons','k','mA','V','lowvec','upvec');  
  
disp('��ȡ��������......')  
drawnow  
[testface,realclass]=ReadFace1(npersons,1);
  
disp('��������������ά......')  
drawnow  
m=size(testface,1);  
for i=1:m  
    testface(i,:)=testface(i,:)-mA;  
end  
pcatestface=testface*V;  
  
set(edit2,'string','�������ݹ淶��......')  
drawnow  
scaledtestface = scaling( pcatestface,lowvec,upvec);  
tic  
set(edit2,'string','SVM��������......')  
drawnow  
class= multiSVM(scaledtestface,multiSVMstruct,npersons);
toc
set(edit2,'string','������ɣ�')  
accuracy=sum(class==realclass)/length(class);  
disp(['ʶ��׼ȷ�ʣ�',num2str(accuracy*100),'%��'])
