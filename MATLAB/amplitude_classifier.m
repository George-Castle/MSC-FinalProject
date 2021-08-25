% old script for classifying data set entries in to old velocity groups
% not used for final dataset
function a = amplitude_classifier(dataset)
    TF = islocalmin(dataset);
    indx = 0;
    indy = 0;
    dataset(:,9) = zeros(height(dataset),1);
    dataset(:,10) = zeros(height(dataset),1);
    for c = 1:height(dataset)
        if (dataset(c,1) == 0)
            indx = 0;
        end
        if (indx == 0) && (TF(c,8) == 1)
            indx = c;
        elseif (indy == 0) && (TF(c,8) == 1)
            indy = c;
        else
            continue;
        end
        if (indx ~= 0) && (indy~= 0)
            theta = abs(2*(asin(sqrt(((dataset(indx,2)-dataset(indy,2))^2)+((dataset(indx,3)-dataset(indy,3))^2)+((dataset(indx,4)-dataset(indy,4))^2))/2)));
            time = dataset(indy,1)-dataset(indx,1);
            for i = indx:indy
                dataset(i,9) = rad2deg(theta)/(time/1000000.0);
                if ((theta/time) < (0.349066/1000000.0)) % if less than 20 degrees per second
                    dataset(i,10) = 1;
                elseif((theta/time) > (0.872665/1000000.0)) % if greater than 50 degrees per second
                    dataset(i,10) = 3;
                else
                    dataset(i,10) = 2; % if greater than 20 and less than 50 degrees/s
                end
            end
            indx = indy;
            indy = 0;
        end
    end
    a = dataset;
end