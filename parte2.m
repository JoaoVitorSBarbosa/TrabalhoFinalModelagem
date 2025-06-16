%% Modelagem de Sistemas Dinâmicos
% Trabalho Final
% Autores: Ana Clara Gomes & João Vitor Barbosa

%% Limpar Workspace
clear all;
close all;
clc;

%% Mollenkamp

disp('Método MollenKamp 2 parte')
dados = load('dadossimulacao.txt');

tempo = dados(:,1);
entrada = dados(:,2);
saida = dados(:,3);

Ganho = mean(saida(end-50:end));

t1 = 23.1;
t2 = 53.5;
t3 = 99.6;

x = (t2 - t1)/(t3 - t1);

Fa = (0.0805 - (5.547 * ((0.475 - x) ^ 2))) / (x - 0.356);

if(Fa < 1)
    f1 = 0.708 * ((2.811) ^ Fa);

else
    f1 = (2.6 * Fa) - 0.6;
end

wn = f1 / (t3-t1);

f2 = 0.922 * ((1.66) ^ Fa);

taud = t2 - (f2/wn);

disp(taud);
s = tf('s');

H_s = 4 * (exp(-taud * s) * (wn^2)) / ((s ^2)  + (2 * Fa * wn * s) + (wn ^2));

[y_model, t_model] = step(H_s, tempo); 

plot(tempo, saida, 'b', 'DisplayName', 'Dados experimentais');  
hold on
plot(t_model, y_model, 'r', 'DisplayName', 'Modelo de Mollenkamp');

disp(['Fator amortecimento:' num2str(Fa) ' wn:' num2str(wn) ' Ganho:' num2str(Ganho) ' Atraso: ' num2str(taud)]);

y_interp = interp1(t_model, y_model, tempo); 
MSE = mean((saida - y_interp).^2); 

disp(['Erro Médio Quadrático (MSE): ', num2str(MSE)]);

%% Sundaesan

disp('Método MollenKamp 2 parte')
dados = load('dadossimulacao.txt');

tempo = dados(:,1);
entrada = dados(:,2);
saida = dados(:,3);

tm  = 87;
x1 = 1;
x2 = 100;
y1 = 1;
y2 = 3.9;

Mi = (y2 - y1) / (x2 - x1);

Ganho = mean(saida(end-50:end));

saidaNormalizada = saida / Ganho;

plot(tempo, saidaNormalizada, 'b', 'DisplayName', 'Dados experimentais'); 
grid on;
hold on;


m1 = trapz(dados(:,1),1 - saidaNormalizada);
disp(m1);
disp(Mi);
lambda = (tm - m1) * Mi;
n = 1;
tau1 = (n ^ (n/(1-n))) / Mi;
tau2 = (1 ^ (n/(1-n))) / Mi;
taud = m1- tau1 - tau2;
s = tf('s');
Hs = (exp(-taud * s)) / (((tau1 * s) + 1) * ((tau1 * s) + 1));
step(Hs,'r');