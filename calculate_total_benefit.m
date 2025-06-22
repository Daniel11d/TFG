function benefit = calculate_total_benefit(clusters, distances)
    benefit = 0;
    for k = 1:length(clusters)
        nodes = clusters{k};
        for i = 1:length(nodes)
            for j = i+1:length(nodes)
                benefit = benefit + distances(nodes(i), nodes(j));
            end
        end
    end
end