% For characterising shifts by finding velocity minima using smoothed velocity profile
function a = shift_finder(dataset)
    dataset(:,15) = zeros(height(dataset),1);
	dataset(:,16) = zeros(height(dataset),1);
    indx = 0;
    indy = 0;
    % smooth head velocity profile using a gaussian filter
    B = smoothdata(dataset(:,12), 'gaussian'); 
    
    % find local minima of smoothed veocity profile to find when head is
    % stationary and a shift has ended or begun
    C = islocalmin(B); 
    for c = 1:(height(C))
        if(C(c,1)==0) % if not start of shift continue
            continue;
        elseif (C(c,1)==1) && (indx == 0) % if start of shift retain index
            indx = c;
            continue;
        elseif (C(c,1)==1) && (indx ~= 0) && (indy == 0) % find end of shift
            indy = c; % retain index
            amp = 0;
            peak = dataset(indx, 12);
            for k = indx:indy % from start to finish of shift
                if(peak < dataset(k,12))
                    peak = dataset(k,12); % find peak velocity of shift
                end
                amp = dataset(k,13) + amp; % accumulate head amiplitude
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
            % find half point of shift to check if left or right
            halfway = floor((indy + indx)/2);
            if (halfway ==1)
                halfway = 2; % In case shift only consists of two entries
            end
            halfvec =  [dataset(halfway, 2);dataset(halfway, 3);dataset(halfway, 4)] - [dataset(indx, 2);dataset(indx, 3);dataset(indx, 4)]; % check halfway vector as well in case shift involves rotation beyond 180°
            vec =  [dataset(indy, 2);dataset(indy, 3);dataset(indy, 4)] - [dataset(indx, 2);dataset(indx, 3);dataset(indx, 4)]; %find vector from first head pos to last head pos
            rot = fullRotation([dataset(indx, 2),dataset(indx, 3),dataset(indx, 4)],dataset(indx, 11)); % calc local rotation matrix for first head position
            localHalfVec = rot*halfvec;
            localVec = rot*vec; % localise shift vec
            if((localVec(1,1) < 0 && localHalfVec(1,1) < 0) || (localVec(1,1) > 0 && localHalfVec(1,1) < 0)) % if localised shift is left then make group negative to indicate shift left 
                    group = 0-group;
            end
            for k = indx:indy
                dataset(k,15) = group; % assign group label
            end
            indx = indy;
            indy = 0; % reset indecies 
        end  
        
    end

    a = dataset; %return updates dataset
end
