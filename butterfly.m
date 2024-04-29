clear all;
clc;

t=input("the channel is ");

if mod(log2(t), 1) ~= 0
    error("Number of channels must be a power of 2.");
    return;
end
stage=log2(t);
n=(log2(t))*t/2;
X=NaN(n);
for i=1:1:n
    for j=1:1:n
        X((i-1)*n+j)=0;
    end
end
index_plus=0;
A=[];
C=[];
for m=0:1:stage-2
    i=0;
    x=2^m; 

    for z=0:1:x-1
        
        for k=0:1:t/(x*4)-1
            fprintf("location is %d\n",k+i+index_plus);
            location=k+i+index_plus;
            X(location+1,location+1+t/2)=1;%location  location+t/2^(m+2) location+t/2 location+t/2^(m+2)+t/2
            X(location+1,location+1+t/2^(m+2)+t/2)=1;
            X((location+1+t/2^(m+2)),location+1+t/2)=1;
            X((location+1+t/2^(m+2)),location+1+t/2^(m+2)+t/2)=1;       
        end
         i=i+t/(x*2) ; 
    end
    index_plus=index_plus+t/2;
end

for m=1:1: stage
    for n=1:1:t/2
        B=m+1;
        A=[A,B];
        D=t/2-n;
        C=[C,D];
    end
end

G=digraph(X);
[~,order] = sort(outdegree(G),'descend');
h=plot(G);
h.EdgeColor = 'k';
h.NodeColor = 'k';
h.XData = A;
h.YData = C;
