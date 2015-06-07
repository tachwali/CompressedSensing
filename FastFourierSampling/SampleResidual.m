function y=SampleResidual(t,s,x,L,K)
global fingerprint;
N=length(x);
if(isempty(L))
    w=[];
    aw=[];
else
    w=L(2,:);
    aw=L(1,:);
end
v=zeros(1,K);
u=zeros(1,K);

for k=1:K
    index=mod(t+s*(k-1),N)+1;
    u(k)=x(index);
%    fingerprint(index)=fingerprint(index)+1;
    if(isempty(w))
        v(k)=0;
    else
        v(k)=sum(aw.*exp(2*pi*i*w*(t+s*(k-1))/N))/N;
    end
end

%  if(~isempty(w))
%  v1=fast_ifft(L,s,t,K,N);
%  
%  end

y=(u-v);



