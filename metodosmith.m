%% Modelagem de Sistemas Dinâmicos
% Trabalho Final
% Autores: Ana Clara Gomes & João Vitor Barbosa

%% Limpar Workspace
clear all;
close all;
clc;

%% Método de Smith
disp('Método de Smith')
dados = load('dadossimulacao.txt');

tempo = dados(:,1);
entrada = dados(:,2);
saida = dados(:,3);
Ganho = mean(dados(end-50:end));

t1 = 34.7;
t2 = 70.8;

tau = 1.5 * (t2 - t1);
teta = t2 - tau;

plot(tempo, saida);
grid on;
hold on;
G1 = tf(Ganho, [tau 1], 'InputDelay', teta);
[y_model, t_model] = step(G1, tempo);
y_model_interp = interp1(t_model, y_model, tempo, 'linear');
plot(tempo, y_model_interp, 'r');
grid on;

MSE = mean((saida - y_model_interp).^2);

title(['Método de Smith - MSE: ', num2str(MSE)]);
ylabel('Amplitude (%)');
xlabel('Tempo (s)');

disp(['MSE: ', num2str(MSE)]);
disp(['Função de Transferência: H(s) = ', num2str(k), ' * exp(-', num2str(teta), 's) / (', num2str(tau), 's + 1)']);

%% Traçando as retas para obter t1 e t2

dados = load('dadossimulacao.txt');
Ganho = mean(dados(end-50:end, 3));

y1 = 0.283 * Ganho; 
y2 = 0.632 * Ganho; 
x = linspace(0, 300, 1000); 
figure
plot(dados(:,1), dados(:,3))
hold on
yy1 = 0 * x + y1;
yy2 = 0 * x + y2;
plot(x, yy1)
plot(x, yy2)
idx1 = find(dados(:,3) >= y1, 1);
x_intersect1 = dados(idx1, 1);
idx2 = find(dados(:,3) >= y2, 1);
x_intersect2 = dados(idx2, 1);
plot(x_intersect1, y1, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r')
plot(x_intersect2, y2, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r')
grid
grid minor
hold off
