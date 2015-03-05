%%%%Loading the EMG data into the MATLAB environment and plot them%%%%%%%
    %y=load('emg2.txt');
    y=load('test.txt');
  %  y=load('emg_healthy.txt');
  

  %%%%%%%%%%%Remove any DC offset of the signal%%%%%%%%%%%%5
   y2=detrend(y);
  

   %%%%%%%%%%%Rectification of the EMG signal%%%%%%%%%%%%%%%%%
   rec_y=abs(y2);
   

   %%%%%%%%%Linear Envelope of the EMG signal%%%%%%%
   [b,a]=butter(5,250/2000,'low'); %  la fréquence de coupure est de 250Hz,la fréquence d'échantillonnage est de 2000 Hz, le filtre d'ordre 5.
   filter_y=filtfilt(b,a,rec_y);
    
   %plot (filter_y)

   %%%%%%%%Detection of onset of muscle contraction%%%%%%%% 
   onset_time=onset(filter_y,t);

   %%%%%%%Fourier Transform (FFT) of the EMG signals%%%%%%%%%    

   fs = 1000;                 % fréquence d'échantillonnage
   A=y(:,2);                 % les données de téléchargement
   n = length(A);            % longueur de vecteur de données
   NFFT=2^nextpow2(n);       % Transformez nombre de points - la fonction fft () définit sa propre, mais il sera nécessaire de tracer
   df=fs/NFFT;               % transformer résolution
   osf=[0: NFFT-1 ]*df;      % des points d'axe de fréquence
 
   y_fft = fft(A,NFFT);      % transformée de Fourier
   y_fft = abs(y_fft);       % module de Spectrum


  %%%%%plot results%%%%%%%%%%%%%%%%%%%%%%%%
    %subplot(2,2,1),
    figure (1)
    plot(y,'b'),xlabel('Sample Number'), ylabel('EMG Signal')
    axis ([0 1.62*1e4 -2 2])
    grid on
   
 %subplot(2,3,2), plot (y2),title('Suppression du dc-offset')
 %subplot(2,2,2), 
  
   figure (2)
   plot(rec_y, 'b'), xlabel('Sample Number'), ylabel('EMG Signal rectification') 
   axis ([0 (1.621*1e4) 0 1.4])
   grid on
   
   % subplot(2,2,3), 
   figure (3)
   plot(filter_y, 'b'), xlabel('Sample Number'), ylabel('Low-Pass Filter')
   axis ([0 (1.621*1e4) -0.1 0.7])
   grid on
   %    subplot(2,3,5),  plot(onset_time), title('Onset')
   %    subplot (2,2,4), 
   figure (4)
   plot(osf(1:3000), y_fft(1:3000), 'b'), xlabel('Frequency [Hz]'), ylabel('Amplitude')
   grid on
