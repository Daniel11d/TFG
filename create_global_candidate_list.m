function global_candidate_list = create_global_candidate_list(remaining_nodes, clusters, weights, distances, num_clusters, U)
    global_candidate_list = [];
    
    for i = remaining_nodes
        for k = 1:num_clusters
            current_cluster_weight = sum(weights(clusters{k}));
            candidate_weight = weights(i);
            if current_cluster_weight + candidate_weight <= U(k)
               
                benefit = sum(distances(i, clusters{k}));
                global_candidate_list = [global_candidate_list; i, k, benefit];
            end
        end
    end
    
    if isempty(global_candidate_list)
        disp('La llista global de candidats està buida.');
    end
end
