%CH_local_max, not curvature
for times = 1:5
    [row column] = size(eva_CH{1, times}.CriterionValues); %run clustering_ORL_v2
    sol_CH{times} = zeros(1,column);
    CH_max_result{times} = islocalmax(eva_CH{1, times}.CriterionValues);
        for x = 1:column
            if CH_max_result{times}(1,x) == 1
                sol_CH{1,times}(1,x) = x;
            end
        end
end

%DB_cruvature_local_max
for times = 1:5
    [row column] = size(eva_CH{1, times}.CriterionValues); %run clustering_ORL_v2
    sol_DB{times} = zeros(column-4,1);
    DB_cruv{times} = zeros(column-4,1);
end
%patse the result into DB_cruve
for times = 1:5
    DB_knee_min_result{times} = islocalmax(DB_cruv{times});
    for x = 1:column-4
            if DB_knee_min_result{times}(x,1) == 1
                sol_DB{1,times}(x,1) = x+2;
            end
    end
end

%find the common solution between CH and DB by excel