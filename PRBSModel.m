%% Modelagem de Sistemas Dinâmicos
% Trabalho Final
% Autores: Ana Clara Gomes & João Vitor Barbosa

%% Limpar Workspace
clear all;
close all;
clc;

%% PRBS Generator

% Gerar entrada PRBS
n_amostras = 3000;
prbs = idinput(n_amostras,'prbs',[0 1],[0 1]);

fileID = fopen('prbs.txt','w');
fprintf(fileID,'%6.2f \n',prbs);
fclose(fileID);

%% Método de Sundaresan
dados = load('dadosPRBS.txt');
tempo = dados(:,1);
entrada = dados(:,2);
saida = dados(:,3);
s = tf('s');
Ganho = mean(saida(end-50:end));

x = linspace(min(tempo), max(tempo), 1000);


plot(x, Ganho*ones(size(x)), 'g--', 'DisplayName', 'Ganho') % Reta y1
hold on
Y_normalizada = saida / Ganho;

tetatau_9 = trapz(tempo, entrada - Y_normalizada); 

tm = 91.45;  
ti = 30; 

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

plot(tempo, saida, 'b', 'DisplayName', 'Dados experimentais');  

plot(t_model, y_model, 'r', 'DisplayName', 'Modelo de Sundaresan');  
grid on;
legend;
title(['Método de Sundaresan - MSE: ' num2str(MSE)]);
xlabel('Tempo (s)');
ylabel('Resposta');
hold off;
%% Método de Mollenkamp
dados = load('dadosPRBS.txt');
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
