function oo = indirect_otsu(img)
I = img;

level1 = graythresh(I)
BW1 = im2bw(I,level1);

%imshow(BW1);

%hold on;
[rows,cols] = size(I);

%imshow(I);

%hold on;

%level2 = graythresh(I);
%BW2 = im2bw(I,level2);
%imshow(BW2);


for p=1:2
        
    I = uint8(BW1.*double(I));
    
    Ni=imhist(I);%����ֱ��ͼ����
    Ni(1) = 0;%ȥ������Ҫ����Ϣ��
    N=sum(Ni);   %�����ص����
    delamax=0;   %��䷽�����ֵ
    threshold=0; %��ֵ
    for k=2:255
        u=dot(0:255,Ni/N); %ͼ�����ƽ���Ҷȼ�
        w0=sum(Ni(1:k)/N);  %C0��������ռ����ı���
        w1=1-w0;            %C1��������ռ����ı���
        if w0==0||w0==1      %��w0Ϊ1��0ʱ��ǰ��������ѭ��
            continue
        end
        u0=dot(0:(k-1),Ni(1:k)/N)/w0;   %C0�����ص�ƽ���Ҷ�
        u1=dot(k:255,Ni(k+1:256)/N)/w1; %C1�����ص�ƽ���Ҷ�
        dela(k)=w0*(u-u0)^2+w1*(u-u1)^2;  %��䷽�ʽ
        %�����䷽������ֵ�����ʱ���Ǹ�ֵ��Ӧ��kֵ����delamax
        if dela(k)>delamax
            delamax=dela(k);
            threshold=k-1;
        end
    end
    %����Ϊ��ֵ�ָ����
    if p == 2
        t2 = threshold;
    end
    if p == 3
        t3 = threshold;
        %	threshold = t2+(t3-t2)*0;
    end
    
    
    
    
    
    [width,height]=size(I);%��ȡͼƬ���
    for i=1:width
        for j=1:height
            if(I(i,j)<threshold)%�Ҷ�С����ֵʱ��Ϊ��ɫ
                BW1(i,j)=0;
            else
                BW1(i,j)=1; % �Ҷȴ�����ֵʱ��Ϊ��ɫ
            end
        end
    end
    
    if i == 2
        t2 = threshold;
    end
    
    
    if i == 3
        t3 = threshold;
    end
    
    %figure
    %hold on;
    %imshow(BW1),title('�Ա�������н��')%��ʾͼƬ
    
end
oo = BW1;
%figure
%imshow(BW1),title('�Ա�������н��')%��ʾͼƬ