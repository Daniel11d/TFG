function RCL = create_RCL(candidate_list, alpha)
   
    if isempty(candidate_list)
        RCL = []; 
        return;
    end
    
    % Beneficis dels candidats
    benefits = candidate_list(:, 3);
    
    % màxim
    I_max = max(benefits);
    
    % Filtrar 
    RCL = candidate_list(benefits >= alpha * I_max, 1);
end