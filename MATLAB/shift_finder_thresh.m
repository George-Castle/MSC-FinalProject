%METHOD FOR CHARACTERISING SHIFTS BASED ON THRESHOLD HEAD VELOCITY OF 3°/s
function a = shift_finder_thresh(dataset)
    dataset(:,15) = zeros(height(dataset),1);
	dataset(:,16) = zeros(height(dataset),1);
    indx = 0;
    indy = 0;
    for c = 1:(height(dataset)-1)
        if(dataset(c,1)==0)
            continue;
        elseif (indx == 0) && (dataset(c,12)<3.0) && (dataset(c+1,12)>3.0)
            indx = c; % find where head initially rises above 3°/s and mark indx as start of shift
        elseif (indx ~= 0) && (indy == 0) && (dataset(c,12)>3.0) && (dataset(c+1,12)<3.0)
            indy = c+1; % find where head falls below 3°/s and mark indy as end of shift
            amp = 0;
            peak = dataset(indx, 12);
            for k = indx:indy
                if(peak < dataset(k,12))
                    peak = dataset(k,12); % find peak velocity of shift
                end
                amp = dataset(k,13) + amp;
                dataset(k,16) = amp;
                %amplitude total
            end
            % assign shift in to groups based on peak velocity
            if (peak < 20)
                group = 1;
            elseif (peak >= 20) && (peak < 60)
                group = 2;
            elseif (peak >= 60) && (peak < 120)
                group = 3;
            else
                group = 4;
            end
            halfway = floor((indy + indx)/2);
            if (halfway ==1)
                halfway = 2; % In case shift only consists of two entries
            end
            halfvec =  [dataset(halfway, 2);dataset(halfway, 3);dataset(halfway, 4)] - [dataset(indx, 2);dataset(indx, 3);dataset(indx, 4)]; % check halfway vector as well in case shift involves rotation beyond 180°
            vec =  [dataset(indy, 2);dataset(indy, 3);dataset(indy, 4)] - [dataset(indx, 2);dataset(indx, 3);dataset(indx, 4)]; %find vector from first head pos to last head pos
            rot = fullRotation([dataset(indx, 2),dataset(indx, 3),dataset(indx, 4)],dataset(indx, 11)); % calc local rotation matrix for first head pos
            localHalfVec = rot*halfvec;
            localVec = rot*vec; % localise shift vec
            if((localVec(1,1) < 0 && localHalfVec(1,1) < 0) || (localVec(1,1) > 0 && localHalfVec(1,1) < 0)) % if localised shift and half shift are left then make group negative
                    group = 0-group;
            end
            for k = indx:indy
                dataset(k,15) = group;
            end
            indx = 0;
            indy = 0;
        end 
    end
    a = dataset;
end