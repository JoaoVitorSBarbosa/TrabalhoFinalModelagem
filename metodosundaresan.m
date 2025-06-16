%% Modelagem de Sistemas Dinâmicos
% Trabalho Final
% Autores: Ana Clara Gomes & João Vitor Barbosa

%% Limpar Workspace
clear all;
close all;
clc;

%% Método de Sundaresan
dados = load('dadossimulacao.txt');
tempo = dados(:,1);
entrada = dados(:,2);
saida = dados(:,3);

Ganho = mean(saida(end-50:end));
s = tf('s');  

Y_normalizada = saida / Ganho;

tetatau_9 = trapz(tempo, entrada - Y_normalizada); 

tm = 79.3;  
ti = 21; 

Mi = 1 / (tm - ti);
lambda = (tm - tetatau_9) * Mi;
n = 0.05;
tau9_1 = (n^(n/(1-n))) / Mi;
tau9_2 = (n^(1/(1-n))) / Mi;
taud = 64.9378 - tau9_1 - tau9_2;
G9 = Ganho * exp(-taud * s) / ((tau9_1 * s + 1) * (tau9_2 * s + 1));

[y_model, t_model] = step(G9, tempo); 

y_interp = interp1(t_model, y_model, tempo); 
MSE = mean((saida - y_interp).^2); 

disp(['Erro Médio Quadrático (MSE): ', num2str(MSE)])
figure
plot(tempo, saida, 'b', 'DisplayName', 'Dados experimentais');  
hold on
plot(t_model, y_model, 'r', 'DisplayName', 'Modelo de Sundaresan');  
grid on
legend
title(['Método de Sundaresan - MSE: ' num2str(MSE)])
xlabel('Tempo (s)')
ylabel('Resposta')
hold off
