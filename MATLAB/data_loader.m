% Function for preparing the data for analysis

function a = data_loader(folder) % pass data folder location
    dataset(1,:) = zeros(1,21);% make a dataset large enough to hold all created columns
    sad = transpose( dir(fullfile( folder, '*.arff' )  ) ); % location of data files
    for file = sad % for all files in the data folder
        disp( file.name ); % display the file name being loaded
        FileName = (file.name);
        % load arff files using function provided with database
        [data, metadata, attributes, ~, ~] = LoadArff(strcat(strcat(folder,'\'),FileName)); 
        
        %remove any data with 'confidence' value lower than 1
        idx = data(:,4)==1;
        clean = data(idx,:);
        
        % Get cartesian coorsinates from provided lat/long coords
        cart = cart_coords_table(clean, metadata, attributes);
        
        %sphere = spherical_coords_converter(clean, height, width); OLD
        %METHOD FOR CONVERTING TO SPHERICAL COORDS (DIDNT DO LOCAL)
        
        %Get velocity of last head movement for each entry and head and eye
        %amplitudes for last movement
        velo =  velocity_calc(cart{:,:});
        
        % For finding minima using smoothed velocity profile
        shifts = shift_finder(velo);
        
        % For finding minima using velocity threshold
        %shifts = shift_finder_thresh(velo);
        
        % old script classifying shifts based on velocity groups eg > 20°/s < 50°/s
        %classified = amplitude_classifier(velo);
        
        % calculate degree distance between head and gaze location for each
        % entry
        classy = eye_head_error(shifts);
        
        % calculate average head gaze distance for each shift 
        shift_error = group_average(classy);
        
        % localise shifts to first shift coord as (0,1,0)
        local = local_shift_coords(shift_error);
        
        %add converted dataset to total data table
        dataset =[dataset;local];
        
    end
    dataset(1,:) = []; %remove initialisation row of zeros
    a = dataset; % return converted dataset
end