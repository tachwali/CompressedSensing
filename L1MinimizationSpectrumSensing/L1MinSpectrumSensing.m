clear all, close all     
 
fs=2e9;  % sampling frequency 2GHz
fc=200e6; % carrier frequency 200MHz
 
n=2048; % the number of samples used by energy detector
 
for m = [128,256,512];   % number of smaples used by compressed sensing
    
    t = 0:n-1;
    fm=32e3; % frequency of the signal m(t)
    dev=5e3; % frequency deviation 
    
    s_t = fmmod(sin(2*pi*fm*t/fs),fc,fs,dev)'; % generate an FM modulated signal
    
    x_t =  awgn(s_t,0); %  generate a noisy signal with SNR = -12 dB
    
    X_f = abs((1/sqrt(n))*fft(x_t)); % the noisy signal in frequency domain
    
    k = 0:n-1;  
 
    F = exp(-1i*2*pi*k'*t/n)/sqrt(n);    % Fourier matrix
 
    freq = randsample(n,m);   % pick a random number of 
 
    A = [real(F(freq,:)); imag(F(freq,:))];    % Incomplete Fourier matrix
 
    b= A*X_f;
 
    % Solve l1 using CVX
    cvx_quiet(true);
    %cvx_solver('sedumi'); 
    cvx_begin
        variable x(n);
        minimize(norm(x,1));
        A*x == b;
    cvx_end
        
    % calculate the performance        
    norm(abs(x) - X_f)/norm(X_f)
    %figure, plot(1:n,X_f,'b*',1:n,abs(x),'ro'), legend('original','decoded')
    figure, plot(1:n,X_f,'b',1:n,abs(x),'r'), legend('original','decoded')
 
end
