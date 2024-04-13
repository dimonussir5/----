% Многоканальные однородные замкнутые сети СМО. На выход 
% t_array - массив массивов t(i)(N) формат
% P_array - массив матриц
%Входы mu - массив мю для каждого узла
%w - массив омега для каждого узла
% m - массив числа каналов для каждого узла
% N - число заявок в сети
% nodes - число узлов
function [t_array, P_array, l1_array] = mhcnCFR(mu,w, m, N, nodes )
    w_sum = sum(w);
    t_array = cell(1, nodes);
    l1_array = cell(1, nodes);
    P_array = cell(1, nodes);
    P = zeros(N+1, N+1); % создание матрицы из нулей
    P(0+1,0+1) = 1; %P(0,0)
    
    for i = 1:nodes
        mu_i = zeros(1,N);
        
        %расчет mu
        for n = 1:N
            if n < m(i)
                 mu_i(n) = n * mu(i);
            else
                
                 mu_i(n) = m(i) * mu(i); 
            end
        end
       
        t=zeros(1,N);
        l1 = zeros(1,N);
        for r = 1:N
            %шаг 1
           
        
            for n = 1:r
                   t(r) = t(r) + n/mu_i(n) * P(n-1+1, r-1+1);
            end
        
            %шаг 2
            l1(r)= r / (w_sum * t(r) / w(1));
            %шаг 3 
            sum_P = 0;
            for n = 1:r
             %неизвестно какое w писать 
               P(n+1, r+1) = w(i) * l1(r) * P(n-1+1, r-1+1)/(w(1) * mu_i(n));
               sum_P = sum_P + P(n+1,r+1);
            end
            P(0+1,r+1) = 1-sum_P;
        
        end
        P_array{i} = P;
        t_array{i} = t;
        l1_array{i} = l1;
    end
end