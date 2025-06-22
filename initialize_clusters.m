function [clusters, available_nodes] = initialize_clusters(num_clusters, num_nodes, weights, L, U)
    clusters = cell(1, num_clusters);
    available_nodes = 1:num_nodes;
    for k = 1:num_clusters
        selected_node = available_nodes(randi(length(available_nodes)));
        clusters{k} = selected_node;
        available_nodes = setdiff(available_nodes, selected_node);
    end
end
