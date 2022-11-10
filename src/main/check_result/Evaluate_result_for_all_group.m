%open evaluate_result.m first
% This fucntion evaluates the performance of a classification model by
% calculating the common performance measures: Accuracy, Sensitivity,
% Specificity, Precision, Recall, F-Measure, G-mean.
% Input: ACTUALL = Column matrix with actual class labels of the training
% examples
% PREDICTEDD = Column matrix with predicted class labels by the
% classification model
% Output: EVALL = Row matrix with all the performance measures
function EVALL = Evaluate_result_for_all_group(ACTUALL,PREDICTEDD)
no_of_groups = max(ACTUALL);
E = zeros(no_of_groups,5);
for group_no = 1:no_of_groups
    E(group_no,:) = Evaluate_result(ACTUALL ,PREDICTEDD, group_no );
end
%average
EVALL = mean(E);
end