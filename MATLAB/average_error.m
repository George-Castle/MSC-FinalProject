function a = average_error(dataset)
    dataset(:,12) = zeros(height(dataset),1);
    for c = 1:(height(dataset)-20)
        if(dataset(c+1,1)==0)
            continue;
        end
        if (dataset(c+1,1) - dataset(c,1)> 200000) && (dataset(c+1,1) - dataset(c,1)< 1500000) % change the max so that jumps in left and right dataset dont influence results
            for i = 1:20
                if(dataset(c+i,8) < 3.0)% used to be 9 not 8
                    dataset(c+i,12) = dataset(c+i, 11);
                    break;
                end
            end
            %dataset(c+1,12) = (dataset(c+1,11)+dataset(c+2,11)+dataset(c+3,11)+dataset(c+4,11)+dataset(c+5,11))/5.0;%1;
        end
        
    end
    a = dataset;
end