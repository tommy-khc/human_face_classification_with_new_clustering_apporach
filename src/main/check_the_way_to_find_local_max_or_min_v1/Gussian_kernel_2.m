GK = zeros(100);
%find sigma
sample = zeros(100,1);
for n=1:100
        sample(n,1) = (norm(New_no_match(n,:),2))^2;
end
sigma = std(sample);
%sigma = 1;
for n=1:100
    for m=1:100
        %should be no_match not New_no_match
        O = (norm(New_no_match(n,:)-New_no_match(m,:),2))^2;
        GK(n,m)= exp(-O^2/(sigma^2));
    end
end
New_no_match=GK;