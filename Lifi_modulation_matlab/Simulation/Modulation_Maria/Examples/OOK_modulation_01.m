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

%% Parâmetros do gráfico do sinal elétrico

Nsymb = 64;  % número de símbolos
Nt    = 64;  % pontos por símbolo
Nch   = 1;   % número de canais

%% Parâmetros do pulso óptico -> não sei se pulso elétrico

symbrate = 10;      % taxa de símbolos em bilhoões de símbolos por segundo [Gbaud]
                    % define a velocidade de transmissão do sistema
duty     = 1;       % ciclo de trabalho
roll     = 0.2;     % roll-off do pulso -> suavidade das bordas / largura de transição

%% Parâmetros do sinal óptico modulado

threshold = 0.5;
% limiar de decisão para 0 ou 1 = (amp.max - amp.min)/2
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

% Printando a comparação entre o padrão para o sinal elétrico e para o
% sinal óptico em linha (originais são em coluna)
disp('Padrão elétrico:');
fprintf('%d ', pat);
fprintf('\n');

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

mod = modulated_signal_RZ(Nsymb, Nt, threshold, elec, 'ook-rz', nsamp);

%% Sem canal óptico

%% Plota sinal modulado RZ
subplot(2, 1, 2);
plot(mod);
title('Sinal Óptico Modulado');
xlabel('time [symbols]');
ylabel('normalised power [a.u.]');
grid on;


%escala temporal nao correta -> relação de simbolos por segundo tem que ser
%igual nos dois gráficos (prioridade)

% figura de baixo teria que ser de 0 a 64
% colocar o optico com 10Gbaud
% colocar os dois 1 Mbps / 10 Mbps

% função em arquivo único

% demodulação (prioridade)

%código 8.2: alterar para calcular individualmente para cada parede




