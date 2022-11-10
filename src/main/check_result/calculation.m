%Check the quality of the result(e.g. accuracy)
%confusion martix
%find the accuracy... by EVAL function
%% EVAL = [Accuracy Recall Specificity Precision F1_Score];
EVAL_each_sample = cell(4,1);
EVAL_each_sample_in_matrix_form = zeros(4,5);
for times = 1:4
    EVAL_each_sample_in_matrix_form (times,:) = Evaluate_result_for_all_group(Ture_confusion_test_3{times,1},Result_confusion_test_3{times,1});
    EVAL{times,1} = EVAL_each_sample_in_matrix_form (times,:);
end
EVAL_over_all_mean = mean(EVAL_each_sample_in_matrix_form);