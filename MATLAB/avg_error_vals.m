%HEAD-GAZE ERROR AVERAGE FOR PEAK VELOCITY AND AMPLITUDE GROUPS
function [amp, peak] = avg_error_vals(dataset)
    idx = dataset{:,18} > 0;
    last_entry = dataset(idx,:);
        %PEAK VELO GROUP 1
    idx = last_entry{:,15} == 1;
    group1 = last_entry(idx,:);
    avg_end1 = mean(group1{:,17});
    avg1 = mean(group1{:,18});
        %PEAK VELO GROUP 2
    idx = last_entry{:,15} == 2;
    group2 = last_entry(idx,:);
    avg_end2 = mean(group2{:,17});
    avg2 = mean(group2{:,18});
        %PEAK VELO GROUP 3
    idx = last_entry{:,15} == 3;
    group3 = last_entry(idx,:);
    avg_end3 = mean(group3{:,17});
    avg3 = mean(group3{:,18});
        %PEAK VELO GROUP 4
    idx = last_entry{:,15} == 4;
    group4 = last_entry(idx,:);
    avg_end4 = mean(group4{:,17});
    avg4 = mean(group4{:,18});
    
    amp1 = dataset(1,:);
    amp2 = dataset(1,:);
    amp3 = dataset(1,:);
    amp4 = dataset(1,:);
    amp5 = dataset(1,:);
    amp6 = dataset(1,:);
    for c = 1:(height(last_entry))
        if(last_entry{c,16}<=10.0)
            amp1 = [amp1;last_entry(c,:)];
        elseif(last_entry{c,16}>10.0 && last_entry{c,16}<=30.0)
            amp2 = [amp2;last_entry(c,:)];
        elseif(last_entry{c,16}>30.0 && last_entry{c,16}<=50.0)
            amp3 = [amp3;last_entry(c,:)];
        elseif(last_entry{c,16}>50.0 && last_entry{c,16}<=70.0)
            amp4 = [amp4;last_entry(c,:)];
        elseif(last_entry{c,16}>70.0 && last_entry{c,16}<=90.0)
            amp5 = [amp5;last_entry(c,:)];
        else
            amp6 = [amp6;last_entry(c,:)];
        end
            
    end
    amp1(1,:) = [];
    amp2(1,:) = [];
    amp3(1,:) = [];
    amp4(1,:) = [];
    amp5(1,:) = [];
    amp6(1,:) = [];
        %AMP GROUP 1
    amp_end1 = mean(amp1{:,17});
    amp_avg1 = mean(amp1{:,18});
        %AMP GROUP 2
    amp_end2 = mean(amp2{:,17});
    amp_avg2 = mean(amp2{:,18});
        %AMP GROUP 3
    amp_end3 = mean(amp3{:,17});
    amp_avg3 = mean(amp3{:,18});
        %AMP GROUP 4
    amp_end4 = mean(amp4{:,17});
    amp_avg4 = mean(amp4{:,18});
        %AMP GROUP 5
    amp_end5 = mean(amp5{:,17});
    amp_avg5 = mean(amp5{:,18});
        %AMP GROUP 6
    amp_end6 = mean(amp6{:,17});
    amp_avg6 = mean(amp6{:,18});
    amp = [amp_end1,amp_avg1;amp_end2,amp_avg2;amp_end3,amp_avg3;amp_end4,amp_avg4;amp_end5,amp_avg5;amp_end6,amp_avg6];
    peak = [avg_end1,avg1;avg_end2,avg2;avg_end3,avg3;avg_end4,avg4];
end