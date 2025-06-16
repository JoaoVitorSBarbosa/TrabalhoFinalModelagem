%% Modelagem de Sistemas dinâmicos
% Trabalho Final
% Autores: Ana Clara Gomes & João Vitor Barbosa


%%Limpar Workspace
clear all;
close all;
clc;

%% Método das integrais
disp('Método das Integrais')
dados = load('dadossimulacao.txt');

Ganho = mean(dados(end-50:end, 3));
y1 = dados(:,3) / Ganho;

teta_tau = trapz(dados(:,1), dados(:,2) - y1); 
ind = find(dados(:,1) <= teta_tau); 

tau1 = exp(1) * trapz(dados(1:ind(end), 1), y1(1:ind(end)));
teta1 = teta_tau - tau1;

Gint = tf(Ganho, [tau1 1], 'InputDelay', teta1); 

plot(dados(:,1), dados(:,3))
hold on

[y_model, t_model] = step(Gint, dados(:,1));
y_model_interp = interp1(t_model, y_model, dados(:,1), 'linear');

MSE = mean((dados(:,3) - y_model_interp).^2);

step(Gint, 'r')
grid on
title(['Método das Integrais - MSE: ', num2str(MSE)]);
ylabel('Amplitude (%)');
xlabel('Tempo (s)');

disp(['MSE: ', num2str(MSE)]);
disp(['Função de Transferência: H(s) = ', num2str(Ganho), ' * exp(-', num2str(teta1), 's) / ((', num2str(tau1), 's + 1))']);
