% experimental script setting every data entry localised to the previous
% entry.
% experiment for training model - failure, gave very low RMSE
function a = next_local_shift(dataset)
    dataset(:,22) = zeros(height(dataset),1);
    dataset(:,23) = ones(height(dataset),1);
    dataset(:,24) = zeros(height(dataset),1);
    for c = 2:(height(dataset))
            rot = fullRotation([dataset(c-1,2),dataset(c-1,4),dataset(c-1,3)], dataset(c,11));
            eyeFovVec = rot * [dataset(c,2);dataset(c,3);dataset(c,4)]; % LOCAL TO [0,1,0]
            dataset(c,22) = eyeFovVec(1,1);
            dataset(c,23) = eyeFovVec(2,1);
            dataset(c,24) = eyeFovVec(3,1);
    end
    a = dataset;
end