f3 = [1; 1; 1; 1;
      1; 1; 1; 1;
      1; 1; 1; 1;
      1; 1; 1; 1;
      0; 0; 0; 0; 0; 0]; 

lb = zeros(22,1);
ub = [Inf; Inf; Inf; Inf; 
      Inf; Inf; Inf; Inf; 
      Inf; Inf; Inf; Inf; 
      Inf; Inf; Inf; Inf;
      1; 1; 1; 1; 1]; 

res3 = intlinprog(f3, 22, A3, b3, Aeq, beq, lb, ub)