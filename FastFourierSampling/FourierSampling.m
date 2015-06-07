%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 	Copyright © Yahia Tachwali, 2009
%	Author:     Yahia Tachwali
%	Date:       Feb 17/2010
%	Version:	1.0
%	Updated: 	Feb 17,2010
%
% 	Purpose:    This program implements the Fast Fourier Sampling  
%               algorithm as illustrated in the Tutorial paper.  
%    
%   To do:    1-Check the sudden drop in the error, it might be due to
%               small shift error in the frequency estimation because of                                          
%               counting from zero rather than 1.
%         
%             2-check the dflag stuff 
%         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [L,c]=FourierSampling(x,m,dflag)
global debugflag;
global errpwr;
global fingerprint;
%rand('state',sum(100*clock))

disp(nargchk(2, 3, nargin))           % Allow 2 to 3 inputs
if(nargin==2)
    dflag = 0;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
L=[];
N=length(x);
debugflag=dflag;

if debugflag==0
    K=8*m;
    bigloop=5;
else
    K=N;
    bigloop=3;
end

errpwr=[];
fingerprint=zeros(1,N);
w=zeros(1,K); %frequency locations
c=zeros(1,K); %frequency coefficients
%e_power=zeros(1,bigloop); %error power at each iteration

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Loop Start
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j=1:bigloop
    w=identification(x,L,K); %frequency location identification
    c=Estimation(x,L,w,K); %coefficient estimation
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Updating L
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if isempty(L)
        L=[c;w]; % For first iteration where L is not filled yet 
    else
        for k=1:length(w) %%%IT WAS K rather than length(w) but because of using unique(w) in Identification function, w size can be less than K
            index=[];
            index=find(L(2,:)==w(k)); % check if the identified w is available in the list L
            if length(index)>1
                error('Something worng! L has repeated ws');
            end
            if isempty(index) 
                L=[L,[c(k);w(k)]];%if frequency w(k) is not found in L then add it to L
            else
                L(1,index)=L(1,index)+c(k);%if frequency is found then accomulate the coefficients
            end
        end
    end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sorting L
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L_abs=abs(L);
[dummy,sortindex]=sortrows(L_abs');
L=L(:,sortindex);
L=L(:,end:-1:1);
if length(L)>K
   L(:,K+1:end)=[];  
end
[dummy,sortindex]=sortrows(L',2);
L=L(:,sortindex);
end

figure; stem(abs(fft(x)));
xlim([0 length(x)]);
figure; stem(L(2,:),abs(L(1,:)));
xlim([0 length(x)]);
figure;plot(errpwr);
100*(N-length(find(fingerprint==0)))/N
sum(fingerprint);
