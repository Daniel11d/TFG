function [clusters, total_benefit] = improve_solution_vnd(clusters, weights, distances, L, U)

    improvement = true;

    while improvement
        improvement = false;

        %Veïnat N_0
        for k = 1:length(clusters)
            for i_idx = 1:length(clusters{k})
                i = clusters{k}(i_idx);

                for s = 1:length(clusters)
                    if s == k
                        continue;
                    end

                    
                    Wk = sum(weights(clusters{k}));
                    Ws = sum(weights(clusters{s}));

                    if (Wk - weights(i) >= L(k)) && (Ws + weights(i) <= U(s))

                        new_clusters = clusters;
                        new_clusters{k}(i_idx) = [];
                        new_clusters{s}(end+1) = i;

                        new_benefit = calculate_total_benefit(new_clusters, distances);

                        old_benefit = calculate_total_benefit(clusters, distances);

                        if new_benefit > old_benefit
                            clusters = new_clusters;
                            improvement = true;
                            break;
                        end
                    end
                end
                if improvement
                    break;
                end
            end
            if improvement
                break;
            end
        end

        %Veïnat N_3
        if ~improvement
            for k = 1:length(clusters)
                for s = k+1:length(clusters)
                    for i_idx = 1:length(clusters{k})
                        i = clusters{k}(i_idx);
                        for j_idx = 1:length(clusters{s})
                            j = clusters{s}(j_idx);

                            Wi_k = sum(weights(clusters{k}));
                            Wj_s = sum(weights(clusters{s}));

                            new_Wk = Wi_k - weights(i) + weights(j);
                            new_Ws = Wj_s - weights(j) + weights(i);

                            if (new_Wk >= L(k) && new_Wk <= U(k)) && ...
                               (new_Ws >= L(s) && new_Ws <= U(s))

                                new_clusters = clusters;
                                new_clusters{k}(i_idx) = j;
                                new_clusters{s}(j_idx) = i;

                                new_benefit = calculate_total_benefit(new_clusters, distances);
                                old_benefit = calculate_total_benefit(clusters, distances);

                                if new_benefit > old_benefit
                                    clusters = new_clusters;
                                    improvement = true;
                                    break;
                                end
                            end
                        end
                        if improvement
                            break;
                        end
                    end
                    if improvement
                        break;
                    end
                end
                if improvement
                    break;
                end
            end
        end
    end

    % Recalcular benefici total al final
    total_benefit = calculate_total_benefit(clusters, distances);
end
