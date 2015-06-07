function wout=identification(x,L,K)
global debugflag;

N=length(x);
reps=5;
w=zeros(1,K);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate sigma (s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

odd_set=[1:2:N-1]; % Odd numbers to randomly pick from
%s=odd_set(round((N/2-1)*rand())+1);
if debugflag==0
    s=odd_set(randint(1,1,[1 length(odd_set)])); % generate a random index 
else
    s=1;    
end

for b=0:log2(N/2)
    
    vote=zeros(1,K);    
    
    for j=1:reps
        if debugflag==0
            t= randint(1,1,[0 N-1]);
        else
            t=0;
        end

        u=SampleShatter(t,s,x,L,K);
        v=SampleShatter(t+N/2^(b+1),s,x,L,K);
       
        for k=1:K
            
            E0=u(k)+(exp(-pi*i*w(k)/(2^b)))*v(k);
            E1=u(k)-(exp(-pi*i*w(k)/(2^b)))*v(k);
            if(abs(E1)>=abs(E0))
                vote(k)=vote(k)+1;                
            end
            
        end
        
    end
    
    for k=1:K
        
        if(vote(k)>reps/2)
            w(k)=w(k)+2^b;
        end
        
    end
    
end

%w=unique(w);
%wout=mod(w*mulinv(s,N),N);

wout=unique(mod(w,N));

