function candidate_list = create_candidate_list(current_cluster, weights, distances, num_nodes, k, L, U, available_nodes)
    candidate_list = [];
    for idx = 1:length(available_nodes)
        i = available_nodes(idx);
        
        if sum(weights(current_cluster)) + weights(i) <= U(k)
            benefit = sum(distances(i, current_cluster)); 
            candidate_list = [candidate_list; i, k, benefit];
        end
    end
end
