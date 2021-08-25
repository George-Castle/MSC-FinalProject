
function a = gaze_predictor(Time,X,Y,Z)
    data = array2table(zeros(1,21));
    data.Properties.VariableNames = {'Time','Head_World_X', 'Head_World_Y','Head_World_Z', 'Eye_World_X','Eye_World_Y','Eye_World_Z', 'Eye_Local_X', 'Eye_Local_Y', 'Eye_Local_Z', 'Head_Velocity', 'Head_Amplitude', 'Eye_Amplitude', 'Peak_Velocity_Group', 'Cumulative_Shift_Amplitude', 'Head_Gaze_Distance', 'Shift_Average_Head_Gaze_Distance','Local_Shift_Coord_X','Local_Shift_Coord_Y','Local_Shift_Coord_Z'};
    data{1, 1} = Time;
    data{1, 2} = X;
    data{1, 3} = Y;
    data{1, 4} = Z;
    velo =  velocity_calc(cart{:,:});
    shifts = shift_finder(velo);
    classy = eye_head_error(shifts);
    shift_error = group_average(classy);
    local = local_shift_coords(shift_error);
    dataset =[dataset;local];
    X_pred = load('BaggedTreesX.mat');
    Y_pred = load('BaggedTreesY.mat')
    Z_pred = load('BaggedTreesZ.mat')
        
    end
    dataset(1,:) = [];
    a = dataset;
end