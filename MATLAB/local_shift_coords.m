%adds local shift coords to data set in columns 19, 20 and 21
function a = local_shift_coords(dataset)
    dataset(:,19) = zeros(height(dataset),1);
    dataset(:,20) = ones(height(dataset),1);
    dataset(:,21) = zeros(height(dataset),1);
    indx = 0;
    for c = 1:(height(dataset))
        if(indx == 0) && (dataset(c,15)~= 0) % if not part of shift don't localise just set to positive y axis
            indx = c;
            group = dataset(c,15);
            dataset(indx,19) = 0;
            dataset(indx,20) = 1;
            dataset(indx,21) = 0;
            rot = fullRotation([dataset(indx,2),dataset(indx,4),dataset(indx,3)], dataset(indx,11)); % get rotation for next entry if its part of a shift
        elseif(indx ~= 0) && (dataset(c,15)==group)% if part of shift localise to first shift entry
            eyeFovVec = rot * [dataset(c,2);dataset(c,3);dataset(c,4)]; % LOCAL TO [0,1,0]
            eyeFovVec = eyeFovVec';
            dataset(c,19) = eyeFovVec(1,1);
            dataset(c,20) = eyeFovVec(1,2);
            dataset(c,21) = eyeFovVec(1,3);
        elseif(indx ~= 0) && (dataset(c,15)~=group) % if end of shift reset counter
            indx = 0; 
        end    
    end
    a = dataset;
end