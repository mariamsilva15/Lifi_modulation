%% Simulação óptica

% Exemplo: Modulação OOK - RZ a partir de pulso elétrico
% Etapas:
%       1. Geração sequência aleatória
%       2. Modulação elétrica (simulação do pulso recebido)
%       3. Modulação óptica a partir do pulso recebido
%       4. Demodulação 

clear all
clc

% Colocar no terminal: 
% addpath C:\Users\maria\OneDrive\Documentos\MMS\Maria\Github\Lifi_modulation_matlab\Simulation\Modulation_Maria

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parâmetros do gráfico

Nsymb = 64;  % número de símbolos
Nt    = 64;  % pontos por símbolo
Nch   = 1;   % número de canais

%% Parâmetros do pulso óptico -> não sei se pulso elétrico

symbrate = 10;      % taxa de símbolos em bilhoões de símbolos por segundo [Gbaud]
                    % define a velocidade de transmissão do sistema
duty     = 1;       % ciclo de trabalho
roll     = 0.2;     % roll-off do pulso -> suavidade das bordas / largura de transição

%% Parâmetros do sinal óptico modulado

Rb=1;
% taxa de bit por segundo
Tb=1/Rb;
% duração de bits
%%%%%SigLen=1000; -> nao precisa
% número de bits ou símbolos 
fsamp=Rb*10;
% frequência de amostragem 
nsamp=fsamp/Rb; 
% número de amostras por símbolos


%% Geração e modulação do sinal elétrico

reset_all(Nsymb, Nt, Nch, mfilename);  % reseta todas as variáveis globais

pat = patttern('debruijn', 1);  % gera o padrão de bits

% Definine options como binário
options.alphabet = 2;

% Gera o padrão aleatório e sinal elétrico recebido no transmissor
pat = patttern('random', [], options);
elec=electricsource(pat,'ook',symbrate,'cosroll',duty,roll);

% Plotagem do sinal elétrico
figure;
subplot(2, 1, 1);
plot(elec);
title('Sinal Elétrico Modulado');
xlabel('Tempo [s]');
ylabel('Amplitude');
grid on;

%% Sem transmissor / fonte óptica

%% Modulação do sinal óptico a partir do sinal elétrico

% Vetor com limiar de decisão que avalia sinal elétrico

threshold = 0.5;
% limiar = (amp.max - amp.min)/2

symbol_indices = round((0.5:1:(Nsymb-0.5)) * Nt);
% gera array que vai de símbolos de elec que vai do símb 0.5 até 63.5 (valor médio do símb)
% ao multiplicar n.5 por Nt (núm de amostras) temos a posição central do símb

bin_data = elec(symbol_indices) > threshold;
% gera o array binário a partir do valor central de cada símbolo
% considerando o núm de amostras por símb

% Printando a comparação entre o padrão para o sinal elétrico e para o
% sinal óptico em linha (originais são em coluna)
disp('pat:');
fprintf('%d ', pat);
fprintf('\n');
disp('array');
fprintf('%d ', bin_data);
fprintf('\n');

% Filtro transmissor para RZ com ciclo de trabalho = 0.5
Tx_filter_RZ=[ones(1,nsamp/2) zeros(1, nsamp/2)]; 
% metade do vetor é composto por uns e a outra metade por zeros
% com comprimento de nsamp amostras que compoem 1 bit.

% Função de modelagem de pulso para RZ
bin_signal_RZ=conv(Tx_filter_RZ, upsample (bin_data,nsamp)); 
bin_signal_RZ=bin_signal_RZ(1:Nsymb*nsamp);

%% Sem canal óptico

%% Plota sinal modulado RZ
subplot(2, 1, 2);
plot(bin_signal_RZ);
title('Sinal Óptico Modulado');
xlabel('time [symbols]');
ylabel('normalised power [a.u.]');
grid on;





