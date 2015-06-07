function zz=SampleShatter(t,s,x,L,K)
z=SampleResidual(t,s,x,L,K);
zz=fft(z);
