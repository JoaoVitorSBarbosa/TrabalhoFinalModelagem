%% Modelagem de Sistemas Dinâmicos
% Trabalho Final
% Autores: Ana Clara Gomes & João Vitor Barbosa

%% Limpar Workspace
clear all;
close all;
clc;

%% Método de Mollenkamp
dados = load('dadossimulacao.txt');
tempo = dados(:,1);
saida = dados(:,3);
Ganho = mean(dados(end-50:end)); 
s = tf('s'); 

t1M = 23.1;
t2M = 53.5;
t3M = 99.6;
x = (t2M - t1M) / (t3M - t1M);
qsi = (0.0805 - 5.547 * (0.475 - x)^2) / (x - 0.356);
wn = (2.6 * qsi - 0.6) / (t3M - t1M);
tetaMollen = t2M - (0.922 * 1.66^qsi) / wn;
tau1M = (qsi + sqrt(qsi^2 - 1)) / wn;
tau2M = (qsi - sqrt(qsi^2 - 1)) / wn;

GMollen = Ganho * exp(-tetaMollen * s) / ((tau1M * s + 1) * (tau2M * s + 1));

[y_model, t_model] = step(GMollen, tempo);  

y_interp = interp1(t_model, y_model, tempo);  
MSE = mean((saida - y_interp).^2);  

disp(['Erro Médio Quadrático (MSE): ', num2str(MSE)])

figure
plot(tempo, saida, 'b', 'DisplayName', 'Dados experimentais');  
hold on
plot(t_model, y_model, 'r', 'DisplayName', 'Modelo de Mollenkamp');  

grid on
legend
title(['Método de Mollenkamp - MSE: ' num2str(MSE)])
xlabel('Tempo (s)')
ylabel('Resposta')
hold off

%% Traçando as retas de Mollenkamp
dados = load('dadossimulacao.txt');
t = dados(:,1);
y = dados(:,3);
Ganho = mean(dados(end-50:end));

y1 = 0.15 * Ganho;
y2 = 0.45 * Ganho;
y3 = 0.75 * Ganho;

[~, idx1] = min(abs(y - y1)); 
[~, idx2] = min(abs(y - y2)); 
[~, idx3] = min(abs(y - y3)); 

x = linspace(min(t), max(t), 1000);
figure
plot(t, y, 'b') 
hold on

plot(x, y1*ones(size(x)), 'r--') % Reta y1
plot(x, y2*ones(size(x)), 'g--') % Reta y2
plot(x, y3*ones(size(x)), 'm--') % Reta y3

plot(t(idx1), y1, 'ro', 'MarkerFaceColor', 'r') % Ponto de interseção com y1
plot(t(idx2), y2, 'go', 'MarkerFaceColor', 'g') % Ponto de interseção com y2
plot(t(idx3), y3, 'mo', 'MarkerFaceColor', 'm') % Ponto de interseção com y3
grid on
hold off
