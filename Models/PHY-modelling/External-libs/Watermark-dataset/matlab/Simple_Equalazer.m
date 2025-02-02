 %function [symbols_PFFT] = Simple_Equalazer(QPSK_symbols, demod_sig,method,PIL,LMSG,LMSM,crr_grd,which_plots,I)       

function y_Equalized = Simple_Equalazer(tx_s, rx_s, h)
%             % ����������: tx_s - ��������� ������, rx_s - �������� ������,
%             % h- ���������� ������������� ������.
%             % tx_s ���������� ��� ������ �������
%             % h - ��� ��������� �����������
% 


y_Equalized  =  0*rx_s;
N  = length(rx_s(1,:)); % ���������� ������
K  = length(rx_s(:,1)); % ���������� �������� 


%% �������� ��������� RLS     ����������� ��� ������ �������
          
% eq = comm.LinearEqualizer('Algorithm','LMS','NumTaps',10,'StepSize',0.003);
eq = comm.LinearEqualizer('Algorithm','RLS','NumTaps',2, 'ForgettingFactor', 0.99);
eq.ReferenceTap = 1;
% eq = comm.LinearEqualizer('Algorithm','CMA','AdaptWeights',false,'InitialWeightsSource','Property')
% eq.ReferenceTap = 30;
% mxStep = maxstep(eq,rx)


for k=1:K     
    [y,err,weights] = eq(rx_s(k,:)',tx_s(k,:)');    
    y_Equalized(k,:)=y';  
end


% %% MLSE ���������
% 
% mlse = comm.MLSEEqualizer('TracebackDepth',10, 'Channel', h(10,[1:10])');
% 
% for k = 1:K     
%     % Equalize the channel output and demodulate.
%     y = mlse(rx_s(k,:)');  
%     y_Equalized(k,:)=y';  
% end

%% ������ ���������� ������������ �������

% for k=1:N 
%     % ���������� h
%     hTemp=resample(h(k,:), K, length(h(k,:)))';
%     %hTemp=h(k,[1:length(rx_s(:,1))])';
%     H_k= fft(hTemp);
% % Equalize the signal.
% eqH = conj(hTemp)./(conj(hTemp).*hTemp);
% x_k=rx_s(:,k);
% y_Equalized(:,k) = x_k./H_k;
    
% end



%%
% �����������������,  ���� ��� �����������      
%y_Equalized  =  tx_s; % ��� ������ � �����������
%y_Equalized  =  rx_s;  % ��� �����������, �� � �������



end   
