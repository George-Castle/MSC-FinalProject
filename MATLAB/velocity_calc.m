% adds velocity and amplitude values to each entry in dataset
function a = velocity_calc(dataset)
    dataset(:,12) = zeros(height(dataset),1);
    dataset(:,13) = zeros(height(dataset),1);
    dataset(:,14) = zeros(height(dataset),1);
    %for every entry in passed dataset
    for c = 1:(height(dataset))
        % prevent two different datasets having their velocity calculated due to first entry being next to last entry
        % also prevent velocity calculated for first entry in datatset
        if(dataset(c,1) == 0)||(c == 1) % if time == 0
            dataset(c,12) = 0;
            dataset(c,13) = 0;
            dataset(c,14) = 0;
            continue; 
        end
        
        i = c-1; % to get index of previous entry
        
        % calculate distance in degrees between last head position and
        % current head position
        theta = abs(2*(asin(sqrt(((dataset(c,2)-dataset(i,2))^2)+((dataset(c,3)-dataset(i,3))^2)+((dataset(c,4)-dataset(i,4))^2))/2)));
        % calculate distance in degrees between last eye position and
        % current eye position
        theta2 = abs(2*(asin(sqrt(((dataset(c,5)-dataset(i,5))^2)+((dataset(c,6)-dataset(i,6))^2)+((dataset(c,7)-dataset(i,7))^2))/2)));
        
        if (theta ~= 0) % if head has moved since last entry allocate values
            dataset(c,12) = rad2deg(theta)/((dataset(c,1)-dataset(i,1))/1000000); % head velocity
            dataset(c,13) = rad2deg(theta); % head amplitude
            dataset(c,14) = rad2deg(theta2); % eye amplitude
        end
    end
    a = dataset; %return new dataset
end