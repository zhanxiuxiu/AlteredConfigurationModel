%Zhan XiuXiu
%zhanxxiu@gmail.com
%
function [X,C,A]=LI5(N)      %����ȷ���ȷֲ���������
%%ȷ��������
tic;
syms t
F=int('-ln(1-t)/t',t,0,exp(-1/5));
NK=[];
for k=1:100
    Pk=(k.^(-2)).*exp(-k/5)/F;
    Nk=N*Pk;
    NK=[NK;k,Nk];    %��Ϊk�Ľڵ���ΪNk
end
x=NK(:,1);y=NK(:,2);
loglog(x,y,'r*');
nk=subs(NK(:,2));  %sub���������ź���ת��ΪС��������round������ÿ����������������
h=round(nk);
X=[];       %����Xÿһ�б�ʾ��Ϊk�Ľڵ������
X(:,1)=1:100;
X(:,2)=h;
e=find(X(:,2)==0);
X(e,:)=[];       %ȥ��X����Щ�ڵ���Ϊ�����
N1=sum(X(:,2));    %�������������ڵ�����͸տ�ʼ�����Ľڵ�����̫һ�£�N1Ϊ���֮��Ľڵ���
%%���ÿ���ڵ�Ķ�
m=X(:,2);
m=[1;m];
mm=cumsum(m);
K=[];
for i=1:length(m)-1
    K=[K;[(mm(i):mm(i+1)-1)',ones(m(i+1),1)*i]];    %����K��ʾÿ���ڵ�Ķ�
end
%%������
Y=[];
for i=1:N1
   Y=[Y;ones(K(i,2),1)*i];    %Y�����ʾÿ���ڵ���������ͷ
end
z=size(Y,1);  C=[];
while  z>=2
    k1=randi([1,z]);
    k2=randi([1,z]);      
    if k1~=k2 && Y(k1)~=Y(k2)
        c1=Y(k1);
        c2=Y(k2);
        C=[C;c1,c2];
        if k1<k2
            Y(k2)=[];
            Y(k1)=[];
        else
            Y(k1)=[];
            Y(k2)=[];
        end
    end
    z=size(Y,1);
end
    A=zeros(N1);            %�����ڽӾ���
   for i=1:size(C,1)
       A(C(i,1),C(i,2))=1; A(C(i,2),C(i,1))=1;
   end
   H=(sum(A,1))';    %���������ɵ�����Ķȷֲ������۶ȷֲ��Ƿ����
hh=max(H);
DD=[];
for i=1:hh
e=length(find(H==i));
DD=[DD;i,e];
end
