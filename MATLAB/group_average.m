function a = group_average(dataset)
    dataset(:,18) = zeros(height(dataset),1);
    indx = 0;
    avg = 0;
    count = 0;
    for c = 1:(height(dataset)-1)
        if(dataset(c+1,1)==0)
            indx = 0;
            continue;
        end
        if(indx == 0) && (dataset(c,15)~= 0)
            indx = c;
            group = dataset(c,15);
            avg = dataset(c, 17) + avg;
            count = 1 + count;
        elseif(indx ~= 0) && (dataset(c,15)==group) && (dataset(c+1,15)==group)%
            avg = dataset(c, 17) + avg;
            count = 1 + count;
        elseif(indx ~= 0) && (dataset(c,15)==group) && (dataset(c+1,15)~=group)
            avg = dataset(c, 17) + avg;
            count = 1 + count;
            dataset(c, 18) = (avg/count);
            indx = 0;
            avg = 0;
            count = 0;
        end    
    end
    a = dataset;
end