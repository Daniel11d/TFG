function [clusters, total_benefit] = grasp_capacitated_clustering(file_path, alpha)
    [num_nodes, num_clusters, cluster_type, L, U, weights, distances] = read_instance(file_path);

    [clusters, available_nodes] = initialize_clusters(num_clusters, num_nodes, weights, L, U);

    for k = 1:num_clusters
        while sum(weights(clusters{k})) < L(k)
            current_cluster = clusters{k};
            candidate_list = create_candidate_list(current_cluster, weights, distances, num_nodes, k, L, U, available_nodes);

            RCL = create_RCL(candidate_list, alpha);

            selected_node = RCL(randi(length(RCL)));

            clusters{k}(end + 1) = selected_node;

            available_nodes = setdiff(available_nodes, selected_node);
        end
    end

remaining_nodes = available_nodes;

while ~isempty(remaining_nodes)
    
    global_candidate_list = create_global_candidate_list(remaining_nodes, clusters, weights, distances, num_clusters, U);

    
    if isempty(global_candidate_list)
        % Si la llsta global està buida -> assignació forçada
        for i = remaining_nodes
            best_cluster = 1;
            best_benefit = -inf;
            for k = 1:num_clusters
                benefit = sum(distances(i, clusters{k}));
                if benefit > best_benefit
                    best_benefit = benefit;
                    best_cluster = k;
                end
            end
            clusters{best_cluster}(end + 1) = i;
            disp(['Node ', num2str(i), ' assignat forçadament al clúster ', num2str(best_cluster), ...
                  ' amb benefici total de ', num2str(best_benefit), '.']);
        end
        break;  
    end

    
    RCL = create_RCL_pairs(global_candidate_list, alpha);

    if isempty(RCL)
        RCL = global_candidate_list; 
    end

    
    selected_candidate = RCL(randi(size(RCL,1)), :);

    selected_node = selected_candidate(1);   
    selected_cluster = selected_candidate(2); 

    
    clusters{selected_cluster}(end + 1) = selected_node;

    remaining_nodes = setdiff(remaining_nodes, selected_node);

end



[clusters, total_benefit] = improve_solution_vnd(clusters, weights, distances, L, U);

end