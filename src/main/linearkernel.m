LK = zeros(100);
c = 100;
for n=1:100
    for m=1:100
        LK(n,m) = dot(no_match(n,:),no_match(m,:))+c;
    end
end
New_no_match=LK;