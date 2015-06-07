function cl=Estimation(x,L,wk,K)
global errpwr;
global debugflag;
N=length(x);
c=[];
cl=[];
reps=5;
for j=1:reps
    %--------Generate sigma (s)--------------
%     current=1;
%     sset=[];
%     while(current<N)
%         sset=[sset current];
%         current=current+2;
%     end
%     ind=round(length(sset)*rand());
%     if(ind==0)
%         ind=1;
%     end
%     s=sset(ind);
    odd_set=[1:2:N-1];
%   s=odd_set(round((N/2-1)*rand())+1);
    s=odd_set(randint(1,1,[1 length(odd_set)]));
%     s=1;
%-----------------------------------------
    t=round((N-1)*rand());
%     t=0;
%-----------------------------------------
  %  [u,a,b]=SampleResidualDetail(t,s,x,L,K);
    u=SampleResidual(t,s,x,L,K);
    if debugflag==0
    else
        figure;
        subplot(3,1,1);
        plot(abs(a));
        subplot(3,1,2);
        plot(abs(b));
        subplot(3,1,3);
        plot(abs(a-b));
    end
    errpwr=[errpwr sum((abs(u).^2))];
%    [r col]=size(c);
%    i=sqrt(-1);
length(wk)
     for l=1:length(wk)
  
         c(j,l)=(N/K)*exp(-2*pi*i*wk(l)*t/N) * sum(u.*exp(-2*pi*i.*wk(l)*s.*[0:K-1]/N));
 
     end
end
for l=1:length(wk)
%    cl(l)=median(c(:,l));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%     Justin Idea                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     creal=median(real(c(:,l)));    %
     cimag=median(imag(c(:,l)));    %
     cl(l)=creal+sqrt(-1)*cimag;    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
