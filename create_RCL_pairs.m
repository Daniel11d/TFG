function RCL = create_RCL_pairs(candidate_list, alpha)
   
    if isempty(candidate_list)
        RCL = [];
        return;
    end

    max_benefit = max(candidate_list(:,3));
    threshold = alpha * max_benefit;
    
    RCL = candidate_list(candidate_list(:,3) >= threshold, :);
end
