function [f_matrix,realclass] = ReadFace(npersons,flag)
%读取ORL人脸库照片里的数据到矩阵  
%输入：  
%     nPersons-需要读入的人数,每个人的前五幅图为训练样本，后五幅为验证样本  
%     imgrow-图像的行像素为全局变量  
%     imgcol-图像的列像素为全局变量  
%     flag-标志，为0表示读入训练样本，为1表示读入测试样本  
%输出：  
%已知全局变量：imgrow=112; imgcol=92;  
global imgrow;
global imgcol;
global samples;
imgrow=112;
imgcol=92;
size=imgrow*imgcol;
realclass=zeros(npersons*(10-samples),1);  
f_matrix1=zeros(npersons*samples,size);
f_matrix2=zeros(npersons*(10-samples),size);
path='orl_faces/s';
for i=1:npersons        
    path1=strcat(path,num2str(i));
    cd(path1); 
    if flag==0 %读入训练样本图像的数据
        for j=1:samples
            if j<samples
                img1=imread(strcat(num2str(j),'.pgm'));
                img2=imread(strcat(num2str(j+1),'.pgm'));
                F1 = fft2(img1); 
                F1 = fftshift(F1);
                abs1=abs(F1);
                angle1=angle(F1);
                F2 = fft2(img2); 
                F2 = fftshift(F2);
                abs2=abs(F2);
                angle2=angle(F2);
                combined = abs2 .* exp(1j .* angle1);
               
             elseif j==samples
                img1=imread(strcat(num2str(j),'.pgm'));
                img2=imread(strcat(num2str(1),'.pgm'));
                F1 = fft2(img1); 
                F1 = fftshift(F1);
                abs1=abs(F1);
                angle1=angle(F1);
                F2 = fft2(img2); 
                F2 = fftshift(F2);
                abs2=abs(F2);
                angle2=angle(F2);
                combined = abs2 .* exp(1j .* angle1);
                %imgcombined=real(ifft2(fftshift(combined)));
            end
            f_matrix1((i-1)*samples+j,:)=combined(:)';
            f_matrix=f_matrix1;
        end
    end
    if flag==1
        for j=samples+1:10
            if j<10
                img1=imread(strcat(num2str(j),'.pgm'));
                img2=imread(strcat(num2str(j+1),'.pgm'));
                F1 = fft2(img1); 
                F1 = fftshift(F1);
                abs1=abs(F1);
                angle1=angle(F1);
                F2 = fft2(img2); 
                F2 = fftshift(F2);
                abs2=abs(F2);
                angle2=angle(F2);
                combined = abs2 .* exp(1j .* angle1);
                %imgcombined=real(ifft2(fftshift(combined)));
             elseif j==10
                img1=imread(strcat(num2str(j),'.pgm'));
                img2=imread(strcat(num2str(samples+1),'.pgm'));
                F1 = fft2(img1); 
                F1 = fftshift(F1);
                abs1=abs(F1);
                angle1=angle(F1);
                F2 = fft2(img2); 
                F2 = fftshift(F2);
                abs2=abs(F2);
                angle2=angle(F2);
                combined = abs2 .* exp(1j .* angle1);
                %imgcombined=real(ifft2(fftshift(combined)));
            end
            realclass((i-1)*(10-samples)+j-samples,:)=i;
            f_matrix2((i-1)*(10-samples)+j-samples,:)=combined(:)';
            f_matrix=f_matrix2;
        end
    end
    cd ..
    cd ..
end
end  

