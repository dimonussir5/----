N = 25;

P = zeros(N+1, N+1); % создание матрицы из нулей
P(0+1,0+1) = 1; %P(0,0)
l0 = 8;
mu_pam = l0;
mu_per = 1; %интенсивность передачи пакетов по каналу
mu_pr = 10;% интенсивность обработки пакета в процессоре
L=18; %Число каналов по условию задачи
nodes = 3*(L+1);
mu = zeros(1,nodes);
TO = 2/mu_per; %среднее время тайм оут
L_TO = 1/TO; % интенсивность

TU = 0.1 / mu_per; % время успешной доставки квитанции
L_TU = 1/TU;% интенсивность 
mu_per_ar =  mu_per * ones(1, L);
L_TO_ar =  L_TO * ones(1, L);
L_TU_ar =  L_TU * ones(1, L);

mu = [l0, mu_pr,mu_pam,mu_per_ar,L_TU_ar,L_TO_ar ];
m_mu_per_ar =  1 * ones(1, L);
m_L_TO_ar =  N * ones(1, L);
m_L_TU_ar =  N * ones(1, L);
m = [1,N,1,m_mu_per_ar,m_L_TU_ar,m_L_TO_ar]; %число каналов
%расчет w
P_k = (1/L) * ones(1, L);
F = 0.1 * ones(1, L);
w_l = zeros(1, L);
w_m = zeros(1, L);
w_r = zeros(1, L);
w_k0 = 1;
w_l0 = 1;
w_m0 = 1;



for i = 1:L 
     w_l(i) = P_k(i) / (1-F(i));
     w_m(i) = P_k(i);
     w_r(i) = F(i) * P_k(i) / (1-F(i));
end

w = zeros(1,nodes);

w = [w_k0,w_l0,w_m0, w_l, w_m, w_r];


[t_array, P_array] = mhcnCFR(mu,w, m, N, nodes );


P_0_N = P_array{1}(0+1, N+1);

disp(P_0_N); % Вывод результата
n1 = N * (1-P_0_N(1));
l1 = l0*(1-P_0_N(1));
N_uk = N-n1;
t = N_uk / (l0 * (1-P_0_N(1)));
disp("a)вероятность отказа в приёме пакета в буферную память");
fprintf("P(0,N) =%.2f\n", P_0_N(1))
disp("б)среднее время пребывания пакета в буферной памяти");
fprintf("t = %.2f\n", t)
disp("в) среднее число пакетов в маршрутизаторе");
fprintf("N_uk = %.2f\n", N_uk)
disp("г) средняя интенсивность потока пакетов, занимающих буферную память маршрутизатора");
fprintf("l1 = %.2f\n", l1)


