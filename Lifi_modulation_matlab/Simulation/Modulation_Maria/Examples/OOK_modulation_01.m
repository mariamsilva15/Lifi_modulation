% Simulação óptica

% Exemplo: Modulação OOK - RZ a partir de pulso elétrico
% Etapas:
%       1. Geração sequência aleatória
%       2. Modulação elétrica (simulação do pulso recebido)
%       3. Modulação óptica a partir do pulso recebido

clear all
clc

% Colocar no terminal: 
% addpath C:\Users\maria\OneDrive\Documentos\MMS\Maria\Github\Lifi_modulation_matlab\optilux-master\Simulation\Modulation_Maria

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% Parâmetros do gráfico

Nsymb = 64;  % número de símbolos
Nt    = 64;  % pontos por símbolo
Nch   = 1;   % número de canais

%%%%%% Parâmetros do pulso óptico

symbrate = 10;      % taxa de símbolos em bilhoões de símbolos por segundo [Gbaud]
                    % define a velocidade de transmissão do sistema
duty     = 1;       % ciclo de trabalho -> define se é modulação NRZ ou RZ
roll     = 0.2;     % roll-off do pulso -> suavidade das bordas / largura de transição


%%%%%% Geração e modulação do sinal

reset_all(Nsymb, Nt, Nch, OOK_modulation_01);  % reseta todas as variáveis globais

pat = patttern('debruijn', 1);  % gera o padrão de bits

% Definine options como binário
options.alphabet = 2;

% Gera o padrão aleatório
pat = patttern('random', [], options);
elec=electricsource(pat,'ook',symbrate,'cosroll',duty,roll);

% Sem transmissor / fonte óptica

% Sem modulação do sinal ótpico

% Sem canal óptico



