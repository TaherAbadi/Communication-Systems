function [Pulse_out,Power,Len_R,len_p] = Linecode_function(rolloff,r,A , SerialCode, Rb)
%Raisecosine Signal 
t = 0: 0.001:0.1;
Raise = A.*(cos(2*pi*rolloff*t)./((1-(4*rolloff*t).^2))) .*sinc(r*t);
Raise = [Raise(end:-1:2) , Raise];
Power = norm(Raise,2)^2;
Len_R = length(Raise);
Pulse = [];

% for i=1:length(SerialCode)/500

  
for k=1:length(SerialCode)
    s =find(t==(1/r))-1;
    
    if k ==1
        T=  (cos(2*pi*rolloff*t)./((1-(4*rolloff*t).^2))) .*sinc(r*t);
        if SerialCode(k)==1
            
            %             Pulse(i,:) = circshift(Raise, s*(i-1));
            Pulse(1, 1:length(T)) = T;
        %    Pulse1(k, 1:length(T)) = T;
            %Pulse(k, 1:length(Raise))=  Raise;
%             Pulse1(k,:) = Raise
            %Pulse1 = [fft(T), zeros(1,length(Raise)-length(fft(T)))];
            %             Pulse1 = [Pulse1 , b];
            %             Pulse = [Pulse , Raise];
%             Pulse1 = fftshift(Raise);
            
        end
        
        if SerialCode(k)==0
            
            %             Pulse(i,:) =circshift(-Raise, s*(i-1));
            Pulse(1, 1:length(T))=  -T;
            %Pulse1(k, 1:length(T))=  -T;
            %Pulse(k, 1:length(Raise))=  -Raise;
%             Pulse1(k,:) = -Raise
            %               Pulse1 =  [Pulse1 , -b];
            %               Pulse =  [Pulse , -Raise];
            %Pulse1 = [fft(-T), zeros(1,length(Raise)-length(fft(T)))];
            %Pulse1 = fft(-Raise);
        end
        
    else
    %         s=find(Raise ==max(Raise));
    
    if SerialCode(k)==1
        
%        Pulse1(k,:) = circshift(Raise, s*(k-1));
        if s*(k-1)+1-length(T)<=0
            Pulse(2, 1:s*(k-1)+length(T)) =  Raise(abs(s*(k-1)+1-length(T))+1:end);
          
            %Pulse1(k, 1:s*(k-1)+length(T)) =  Raise(abs(s*(k-1)+1-length(T))+1:end);
        else
            Pulse(2, s*(k-1)+1-length(T):s*(k-1)+length(T)-1) =  Raise;

            %Pulse1(k, s*(k-1)+1-length(T):s*(k-1)+length(T)-1) =  Raise;
        end
        %             Pulse1 = [Pulse1 , b];
        %             Pulse = [Pulse , Raise];
%         Pulse1 = Pulse1+(fft(Raise).*exp(1i*2*pi*f*(s*(k-1)+1)));
    end
    
    if SerialCode(k)==0
        
               
        if s*(k-1)+1-length(T)<=0
            Pulse(2, 1:s*(k-1)+length(T)) =  -Raise(abs(s*(k-1)+1-length(T))+1:end);
           
            %Pulse1(k, 1:s*(k-1)+length(T)) =  -Raise(abs(s*(k-1)+1-length(T))+1:end);
            
        else
        Pulse(2, s*(k-1)+1-length(T):s*(k-1)+length(T)-1) =  -Raise;
    
        %Pulse1(k, s*(k-1)+1-length(T):s*(k-1)+length(T)-1) =  -Raise;
%         Pulse1 = Pulse1+(fft(-Raise).*exp(1i*2*pi*f*(s*(k-1)+1)));
        %               Pulse1 =  [Pulse1 , -b];
        %               Pulse =  [Pulse , -Raise];
        
    end
    end
     Pulse(1,:) = sum(Pulse);
     Pulse(2,:) = [];
    end
   

end
Pulse_out = Pulse(1,:);
tb=0:seconds (0.001):seconds(0.3);
tb=tb(1:end-1);
figure

subplot(3,1,1)
stem(SerialCode(1:20));
title('Transmitted Signal ')

subplot(3,1,2)
plot(Raise);
title('Raisecoseine ')
marker = 1:s:numel(tb);
subplot(3,1,3)
plot(tb, Pulse_out(1,1:numel(tb)), 'o-','MarkerIndices',marker)
title('Line coded Transmited Signal ')
Len_R =s;
len_p=k;
end

