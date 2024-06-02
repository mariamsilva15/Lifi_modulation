function mod = modulated_signal_RZ(num_elec_symb, samp_per_elec_symb, threshold_opt, elec_signal, modulation_type, samp_per_opt_symb)

%num_elec_symb = numero de símbolos do sinal elétrico
%samp_per_elec_symb = amostras por símbolo do sinal elétrico
%threshold_opt = limiar de decisão para o sinal óptico modulado
%elec_signal = sinal elétrico modulado
%modulation_type = tipo de modulação óptica
%samp_per_opt_symb = amostras por símbolo do sinal modulado óptico

%% Modulação do sinal óptico a partir do sinal elétrico

% Vetor com limiar de decisão que avalia sinal elétrico
symbol_indices = round((0.5:1:(num_elec_symb-0.5)) * samp_per_elec_symb);
% gera array que vai de símbolos de elec que vai do símb 0.5 até 63.5 (valor médio do símb)
% ao multiplicar n.5 por Nt (núm de amostras) temos a posição central do símb
    
bin_data = elec_signal(symbol_indices) > threshold_opt;
% gera o array binário a partir do valor central de cada símbolo
% considerando o núm de amostras por símb

% Printando a comparação entre o padrão para o sinal elétrico e para o
% sinal óptico em linha (originais são em coluna)
disp('Padrão óptico:');
fprintf('%d ', bin_data);
fprintf('\n');


if strcmp(modulation_type, 'ook-rz')
    % Filtro transmissor para RZ com ciclo de trabalho = 0.5
    Tx_filter_RZ = [ones(1, samp_per_opt_symb/2) zeros(1, samp_per_opt_symb/2)];
    % metade do vetor é composto por uns e a outra metade por zeros
    % com comprimento de nsamp amostras que compoem 1 bit.
    
    % Função de modelagem de pulso para RZ
    modulated_signal_RZ = conv(Tx_filter_RZ, upsample(bin_data, samp_per_opt_symb));
    mod = modulated_signal_RZ(1:num_elec_symb * samp_per_opt_symb);
else
    error('Tipo de modulação não encontrada.');
end

end
