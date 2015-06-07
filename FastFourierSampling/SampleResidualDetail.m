function [y,u,v]=SampleResidualDetail(t,s,x,L,K)
global fingerprint;

N=length(x);
if(isempty(L))
    w=[];
    aw=[];
else
    c=L(1,:);
    w=L(2,:);
end

v=zeros(1,K);
u=zeros(1,K);

for k=1:K
    u(k)=x(mod(t+s*(k-1),N)+1);
    fingerprint(mod(t+s*(k-1),N)+1)=fingerprint(mod(t+s*(k-1),N)+1)+1;
    if(isempty(w))
        v(k)=0;
    else
        v(k)=sum(c.*exp(2*pi*i*w*(t+s*(k-1))/N))/N;
    end
end
% if(~isempty(w))
% v=fast_ifft(L,s,t,K,N);
% end
y=(u-v);
%  figure;
%  plot(abs(y));


