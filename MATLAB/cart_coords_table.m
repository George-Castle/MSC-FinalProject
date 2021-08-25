%create table for x,y,z head and gaze positions of provided dataset

function a = cart_coords_table(data, metadata, attributes)
    %initialise new rows in table 
    gaze_table  = array2table(zeros(height(data),11), 'VariableNames', {'time', 'head_x', 'head_y', 'head_z', 'world eye_x', 'world eye_y', 'world eye_z', 'local eye_x', 'local eye_y', 'local eye_z', 'head_roll_angle'});
    
    gaze_table{:,'time'} = data(:,1); %time value stays the same
    for c = 1:height(data) % for each entry in passed dataset
        %To get cartesian coords of gaze and head location as well as
        %localised gaze coordinates
        [eyeFovVec, eyeHeadVec, headVec, angleHeadRads] = GetCartVectors(data(c,:), metadata, attributes); 
        
        %set table values to returned coordinates
        gaze_table{c, 2} = headVec(1,1); %(head x)
        gaze_table{c, 3} = headVec(1,3); %(head y)
        gaze_table{c, 4} = headVec(1,2); %(head z)` 

        gaze_table{c, 5} = eyeHeadVec(1,1); %(eye x)
        gaze_table{c, 6} = eyeHeadVec(1,3); %(eye y)
        gaze_table{c, 7} = eyeHeadVec(1,2); %(eye z)
        
        gaze_table{c, 8} = eyeFovVec(1,1); %(local to head eye x)
        gaze_table{c, 9} = eyeFovVec(1,2); %(local to head eye y)
        gaze_table{c, 10} = eyeFovVec(1,3); %(local to head eye z)
        gaze_table{c, 11} = angleHeadRads; %  roll of head
    end
    a = gaze_table; % return new table with cartesian coords
end

