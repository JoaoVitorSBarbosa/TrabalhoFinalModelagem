%% Modelagem de Sistemas Dinâmicos
% Trabalho Final
% Autores: Ana Clara Gomes & João Vitor Barbosa

%% Limpar Workspace
clear all;
close all;
clc;

%% Método de uma Constante de Tempo (63,2%)
disp('Método de uma Constante de Tempo')
dados = load('dadossimulacao.txt');

tempo = dados(:,1);
entrada = dados(:,2);
saida = dados(:,3);
Ganho = mean(saida(end-50:end));
saida_inicial = mean(saida(1:50));
saida_final = mean(saida(end-50:end));
saida_normalizada = (saida - saida_inicial) / (saida_final - saida_inicial);
hold on 

constante_tempo = 0.632 * Ganho;
teta_tau = 70.8; 
teta = 12.5;
tau = teta_tau - teta; 
Gconst = tf(Ganho, [tau 1], 'InputDelay', teta);

plot(tempo, saida, 'b') % linha de 63,2
[saida_modelo, tempo_modelo] = step(Gconst, tempo);
saida_modelo_interp = interp1(tempo_modelo, saida_modelo, tempo, 'linear');
plot(tempo, saida_modelo_interp, 'r');
grid on

MSE = mean((saida - saida_modelo_interp).^2);

title(['Método da Constante de Tempo - MSE: ', num2str(MSE)]);
ylabel('Amplitude (%)');
xlabel('Tempo (s)');

disp(['MSE: ', num2str(MSE)]);
disp(['Função de Transferência: H(s) = ', num2str(Ganho), ' * exp(-', num2str(teta), 's) / (', num2str(tau), 's + 1)']);

%% Traçando as retas para obter teta_tau

dados = load('dadossimulacao.txt');
Ganho = mean(dados(end-50:end, 3));

y1 = 0.632 * Ganho; 
x = linspace(0, 300, 1000); 
figure
plot(dados(:,1), dados(:,3))
hold on
yy1 = 0 * x + y1;
plot(x, yy1)
idx = find(dados(:,3) >= y1, 1);
x_intersect = dados(idx, 1);
plot(x_intersect, y1, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r')
grid
grid minor
hold off
