% TestFS
L=[];
m=4;
K=8*m;
fs=2^17;
ff=0.5*fs*rand(1,m); %random frequency locations
a=10*rand(1,m);
Ts=1/fs;
t=0:Ts:1-Ts;
x_pure=zeros(1,length(t));
for i=1:m
x_pure=x_pure+a(i).*exp(sqrt(-1).*(ff(1,i).*2.*pi.*t));
end
n=0.02*randn(1,length(t));
x=x_pure+n;

clear t;clear x_pure; clear n;
[wk,cl]=FourierSampling(x,m)

mag=abs(cl);
p=sort(mag,2,'descend');
fv=p(1:m)
f=[];
for k=1:length(mag)
    for l=1:length(fv)
        if(fv(l)==mag(k))
            f=[f wk(k)]
        end
    end
end