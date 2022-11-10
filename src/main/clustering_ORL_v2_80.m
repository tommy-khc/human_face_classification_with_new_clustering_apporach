% best(SIFT,D_mod_min,pam)
tic;
clear all;
%install SIFT
run /Users/Tomy_Chan/Downloads/vlfeat-0.9.21/toolbox/vl_setup;

rand = randperm(40);
idxx = cell(5,1);
for times = 1:5
    s = rand(:,1+((times-1)*8):8+((times-1)*8)); 
    s_f = [ s(:,1)*10-9 s(:,1)*10-8 s(:,1)*10-7 s(:,1)*10-6 s(:,1)*10-5 s(:,1)*10-4 s(:,1)*10-3 s(:,1)*10-2 s(:,1)*10-1 s(:,1)*10 ];
    for a = 2:8
        s_f = [ s_f s(:,a)*10-9 s(:,a)*10-8 s(:,a)*10-7 s(:,a)*10-6 s(:,a)*10-5 s(:,a)*10-4 s(:,a)*10-3 s(:,a)*10-2 s(:,a)*10-1 s(:,a)*10 ];
    end

    %present in martix
    %tic;
    d = cell(80,1);
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
    no_match = zeros(80);
    for n=1:80
        for m=1:80
            [matches scores] = vl_ubcmatch(d{n}, d{m});
            no_match(n,m)= size(scores,2);
        end
    end
    %toc;

    %modify no_match(symmertic and normailized)
    %tic;
    New_no_match = zeros(80);
    for n=1:80
        for m=1:80
            New_no_match(n,m)=2*min(no_match(n,m),no_match(m,n))/(no_match(n,n)+no_match(m,m));
        end
    end
    %toc;
    
    %txt for R
    formatSpec_txt = "New_no_match_v2_test5_80_%d.txt";
    str_txt = char(sprintf(formatSpec_txt,times));
    dlmwrite(str_txt,New_no_match,'precision','%10.50f');
    
    %clustering vadliation
    clust = zeros(size(New_no_match,1),80);
    for i=1:80
        clust(:,i) = kmedoids(New_no_match,i,'Algorithm','pam');
        pause(2);
    end
    
    %txt for R
    formatSpec_Clust_txt = "clust_v2_test5_80_%d.txt";
    str_Clust_txt = char(sprintf(formatSpec_Clust_txt,times));
    dlmwrite(str_Clust_txt,clust);
    
    %CalinskiHarabasz
    eva_CH{times} = evalclusters(New_no_match,clust,'CalinskiHarabasz');
    
    %clustering_pam
    %tic;
    idx = kmedoids(New_no_match,8,'Algorithm','pam');
    idxx{times} = idx;
    %idxxx = idx;
    %toc;

    %labling
    %%get real_result from workspace

    %Rename
    %cd '/Users/Tomy_Chan/Documents/OneDrive - HKUST Connect/Yr4/Spring/MATH4983F/MATH4983F/Result/result_2/Result_att_faces_renamed';
    %dirData = dir('*.pgm');         %# Get the selected file data
    %fileNames = {dirData.name};     %# Create a cell array of file names
    %[idxx,idxx]=sort(cellfun(@(x) str2num(char(regexp(x,'\d*','match'))),fileNames));
    %fileNames=fileNames(idxx);
    %y=1;
    %x=1;
    %for iFile = 1:numel(fileNames)                 %# Loop over the file names
    %    newName = sprintf('g%d_%d.pgm',idx(y),x);  %# Make the new name
    %    movefile(fileNames{iFile},newName); %# Rename the file
    %    y=y+1;
    %    x=x+1;
    %end
end
toc;