%Zhan XiuXiu
%zhanxxiu@gmail.com
%
function [X,C,A]=LI5(N)      %根据确定度分布生成网络
%%确定度序列
tic;
syms t
F=int('-ln(1-t)/t',t,0,exp(-1/5));
NK=[];
for k=1:100
    Pk=(k.^(-2)).*exp(-k/5)/F;
    Nk=N*Pk;
    NK=[NK;k,Nk];    %度为k的节点数为Nk
end
x=NK(:,1);y=NK(:,2);
loglog(x,y,'r*');
nk=subs(NK(:,2));  %sub函数将符号函数转化为小数，再用round函数对每个数进行四舍五入
h=round(nk);
X=[];       %矩阵X每一行表示度为k的节点的数量
X(:,1)=1:100;
X(:,2)=h;
e=find(X(:,2)==0);
X(e,:)=[];       %去掉X中那些节点数为零的行
N1=sum(X(:,2));    %由于四舍五入后节点数会和刚开始给出的节点数不太一致，N1为算出之后的节点数
%%标记每个节点的度
m=X(:,2);
m=[1;m];
mm=cumsum(m);
K=[];
for i=1:length(m)-1
    K=[K;[(mm(i):mm(i+1)-1)',ones(m(i+1),1)*i]];    %矩阵K表示每个节点的度
end
%%随机配对
Y=[];
for i=1:N1
   Y=[Y;ones(K(i,2),1)*i];    %Y矩阵表示每个节点引出的线头
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
    A=zeros(N1);            %生成邻接矩阵
   for i=1:size(C,1)
       A(C(i,1),C(i,2))=1; A(C(i,2),C(i,1))=1;
   end
   H=(sum(A,1))';    %检验新生成的网络的度分布与理论度分布是否相符
hh=max(H);
DD=[];
for i=1:hh
e=length(find(H==i));
DD=[DD;i,e];
end
