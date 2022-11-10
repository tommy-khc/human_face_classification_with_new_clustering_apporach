idxx = cell(4,1);
for times = 1:4
    s = rand(:,1+((times-1)*10):10+((times-1)*10)); 
    s_f = [ s(:,1)*10-9 s(:,1)*10-8 s(:,1)*10-7 s(:,1)*10-6 s(:,1)*10-5 s(:,1)*10-4 s(:,1)*10-3 s(:,1)*10-2 s(:,1)*10-1 s(:,1)*10 ];
    for a = 2:10
        s_f = [ s_f s(:,a)*10-9 s(:,a)*10-8 s(:,a)*10-7 s(:,a)*10-6 s(:,a)*10-5 s(:,a)*10-4 s(:,a)*10-3 s(:,a)*10-2 s(:,a)*10-1 s(:,a)*10 ];
    end

    %present in martix
    %tic;
    d = cell(100,1);
    c = 1;
    for n = s_f
        formatSpec = "/Users/Tomy_Chan/Documents/OneDrive - HKUST Connect/Yr4/Spring/MATH4983F/MATH4983F/DATA/att_faces_renamed/%d.pgm";
        str = char(sprintf(formatSpec,n));
        %disp(str);
        M = imread(str);
        [f,d{c}] = vl_sift(im2single(M));
        c = c+1;
    end
    
    %matching
    no_match = zeros(100);
    for n=1:100
        for m=1:100
            [matches scores] = vl_ubcmatch(d{n}, d{m});
            no_match(n,m)= size(scores,2);
        end
    end
    %toc;
    
    %modify no_match(symmertic and normailized)
    %tic;
    New_no_match = zeros(100);
    for n=1:100
        for m=1:100
            New_no_match(n,m)=no_match(n,m)/no_match(n,n);
        end
    end
    %toc;
    
    %Gussian
    GK = zeros(100);
    %find sigma
    sample = zeros(100,1);
    for n=1:100
        sample(n,1) = norm(New_no_match(n,:),2);
    end
    sigma = std(sample);
    %sigma = 1;
    for n=1:100
        for m=1:100
        %should be no_match not New_no_match
            O = norm(no_match(n,:)-no_match(m,:),2);
            GK(n,m)= exp(-O^2/(sigma^2));
        end
    end
    New_no_match=GK;
    
    %clustering_pam
    %tic;
    idx = kmedoids(New_no_match,10,'Algorithm','pam');
    idxx{times} = idx;
end
Result_confusion_test_3 = idxx;