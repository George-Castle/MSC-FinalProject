%returns mean error value for each amplitude group
function [a1,a2,a3,a4,a5,a6,m] = amplitude_groups(dataset)
    group1(1,:) = zeros(1,21);
    group2(1,:) = zeros(1,21);
    group3(1,:) = zeros(1,21);
    group4(1,:) = zeros(1,21);
    group5(1,:) = zeros(1,21);
    group6(1,:) = zeros(1,21);
    m1(1,:) = zeros(1,1);
    m2(1,:) = zeros(1,1);
    m3(1,:) = zeros(1,1);
    m4(1,:) = zeros(1,1);
    m5(1,:) = zeros(1,1);
    m6(1,:) = zeros(1,1);
    idx2 = dataset(:, 18) > 0;
    dataset = dataset(idx2,:);
    for c = 1:(height(dataset))
        if(dataset(c,16) < 10)
            group1 =[group1;dataset(c,:)];
            m1 =[m1;dataset(c,18)];
        elseif(dataset(c,16) >= 10) && (dataset(c,16) < 30)
            group2 =[group2;dataset(c,:)];
            m2 =[m2;dataset(c,18)];
        elseif(dataset(c,16) >= 30) && (dataset(c,16) < 50)
            group3 =[group3;dataset(c,:)];
            m3 =[m3;dataset(c,18)];
        elseif(dataset(c,16) >= 50) && (dataset(c,16) < 70)
            group4 =[group4;dataset(c,:)];
            m4 =[m4;dataset(c,18)];
        elseif(dataset(c,16) >= 70) && (dataset(c,16) < 90)
            group5 =[group5;dataset(c,:)];
            m5 =[m5;dataset(c,18)];
        elseif(dataset(c,16) >= 90)
            group6 =[group6;dataset(c,:)];
            m6 =[m6;dataset(c,18)];
        end    
    end
    group1(1,:) = [];
    group2(1,:) = [];
    group3(1,:) = [];
    group4(1,:) = [];
    group5(1,:) = [];
    group6(1,:) = [];
    m1(1,:) = [];
    m2(1,:) = [];
    m3(1,:) = [];
    m4(1,:) = [];
    m5(1,:) = [];
    m6(1,:) = [];
    a1 = group1;
    a2 = group2;
    a3 = group3;
    a4 = group4;
    a5 = group5;
    a6 = group6;
    m = [mean(m1), mean(m2), mean(m3), mean(m4), mean(m5), mean(m6)];
end