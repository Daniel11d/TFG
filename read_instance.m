function [num_nodes, num_clusters, cluster_type, L, U, weights, distances] = read_instance(file_path)
    
    fid = fopen(file_path, 'r');
    first_line = fgetl(fid);
    data = strsplit(first_line, ' ');
    
    num_nodes = str2double(data{1});
    num_clusters = str2double(data{2});
    cluster_type = data{3};
    
  
    L = zeros(1, num_clusters);
    U = zeros(1, num_clusters);
    for i = 1:num_clusters
        L(i) = str2double(data{3 + 2*i - 1});
        U(i) = str2double(data{3 + 2*i});
    end
    

    weights = zeros(1, num_nodes);
    W_index = find(strcmp(data, 'W')) + 1;
    for i = 1:num_nodes
        weights(i) = str2double(data{W_index + i - 1});
    end
    

    distances = zeros(num_nodes, num_nodes);
    while ~feof(fid)
        line = fgetl(fid);
        if isempty(line), continue; end
        edge_data = str2double(strsplit(line, ' '));
        % AJUSTEM INDEXS PERQUÈ MATLAB TREBALLA A PARTIR DEL 1
        distances(edge_data(1) + 1, edge_data(2) + 1) = edge_data(3);
        distances(edge_data(2) + 1, edge_data(1) + 1) = edge_data(3); 
    end
    
    fclose(fid);
end