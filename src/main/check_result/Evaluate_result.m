function EVAL = Evaluate_result(ACTUAL,PREDICTED,GROUP)
confusion_martixx = confusionmat(ACTUAL,PREDICTED);
TP = confusion_martixx(GROUP,GROUP);
TP_FP = sum(confusion_martixx(:,GROUP));
FP = TP_FP-TP;
TP_FN = sum(confusion_martixx(GROUP,:));
FN = TP_FN-TP;
Tot_N = sum(sum(confusion_martixx));
TN = Tot_N-TP_FP-TP_FN+TP;
Precision = TP/TP_FP;
Accuracy = (TP+TN)/Tot_N;
Recall = TP/(TP_FN);
Specificity = TN/(FP+TN);
F1_Score = 2/((1/Precision)+(1/Recall));
EVAL = [Accuracy Recall Specificity Precision F1_Score];
end