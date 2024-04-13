max_bs = 50;
n1 = zeros(1,max_bs);
l1 = zeros(1,max_bs);
N_uk = zeros(1,max_bs);
t = zeros(1,max_bs);
P_0_N = zeros(1,max_bs);
for N = 1:max_bs
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


    
    [t_array, P_array,l1_array] = mhcnCFR(mu,w, m, N, nodes );

    n1(N) = 0;

    for ni = 0:N 
        n1(N) = n1(N) + ni * P_array{1}(ni+1, N + 1);
    end
   


    %disp(P_0_N); % Вывод результата
    P_0_N(N) = P_array{1}(0+1, N+1);
    %n1(N) = N * (1-P_0_N(N));
    l1(N) = l0*(1-P_0_N(N));
    %l1(N) = l1_array{1}(N);
    N_uk(N) = N-n1(N);
    t(N) = N_uk(N)/ l1(N);
    %t(N) = t_array{1}(N);
end

N = 1:max_bs; % Значения N от 1 до 50

% Построение первого графика в первом окне
figure; % Создание нового окна
plot(N,  P_0_N, 'LineWidth', 2);
xlabel('N');
ylabel('P(0,N)');
title('График P(0,N)');
grid on;

% Построение второго графика во втором окне
figure; % Создание нового окна
plot(N, t, 'LineWidth', 2);
xlabel('N');
ylabel('t');
title('График t');
grid on;

% Построение первого графика в первом окне
figure; % Создание нового окна
plot(N, N_uk, 'LineWidth', 2);
xlabel('N');
ylabel('N_uk');
title('График N_uk');
grid on;

% Построение второго графика во втором окне
figure; % Создание нового окна
plot(N, l1, 'LineWidth', 2);
xlabel('N');
ylabel('l1');
title('График l1');
grid on;