%create table for x,y,z positions of provided dataset

function a = spherical_coords_converter(dataset, height_px, width_px)
	headVec(:,1) = dataset(:,5); % set vars to appropriate columns (head x)
	headVec(:,2) = dataset(:,6); % (head y)
    eyeVec(:,1) = dataset(:,2); % (eye x)
	eyeVec(:,2) = dataset(:,3); % (eye y)
    gaze_table  = array2table(zeros(height(dataset),8), 'VariableNames', {'time', 'head_x', 'head_y', 'head_z', 'eye_x', 'eye_y', 'eye_z', 'head_angle'});
    gaze_table{:,'time'} = dataset(:,1);
    for c = 1:height(dataset)
        h_phi = ((height_px - headVec(c,2))/height_px)*pi; %convert to spherical coordinates for head x,y
        h_theta = (headVec(c,1)/width_px)*2*pi;
        e_phi = ((height_px - eyeVec(c,2))/height_px)*pi;%convert to spherical coordinates for eye x,y
        e_theta = (eyeVec(c,1)/width_px)*2*pi;
        %calc, x, y, z for radius of 1 for head location 
        gaze_table{c, 2} = -cos(h_theta)*sin(h_phi); %(head x)
        gaze_table{c, 3} = sin(h_theta)*sin(h_phi); %(head y)
        gaze_table{c, 4} = -cos(h_phi); %(head z)
        %calc, x, y, z for radius of 1 for eye location
        gaze_table{c, 5} = -cos(e_theta)*sin(e_phi); %(eye x)
        gaze_table{c, 6} = sin(e_theta)*sin(e_phi); %(eye y)
        gaze_table{c, 7} = -cos(e_phi); %(eye z)
        gaze_table{c, 8} = dataset(c,7); %(head angle)
    end
    a = gaze_table;
end
