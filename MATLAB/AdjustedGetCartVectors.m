
% adjusted Ionis Agtzidis script to make rotation work
% GetCartVectors.m
%
% This function returns an nx3 arrays of cartesian vectors for the eye direction
% within the FOV of the headset, the eye direction in the world coordinates and
% the head direction in the world.
%

function [eyeFovVec, eyeHeadVec, headVec, angleHeadRads] = GetCartVectors(data, metadata, attributes)
    c_xName = 'x';
    c_yName = 'y';
    c_xHeadName = 'x_head';
    c_yHeadName = 'y_head';
    c_angleHeadName = 'angle_deg_head';

    xInd = GetAttPositionArff(attributes, c_xName);
    yInd = GetAttPositionArff(attributes, c_yName);
    xHeadInd = GetAttPositionArff(attributes, c_xHeadName);
    yHeadInd = GetAttPositionArff(attributes, c_yHeadName);
    angleHeadInd = GetAttPositionArff(attributes, c_angleHeadName);

    eyeFovVec = zeros(size(data,1),3);
    
    eyeHeadVec = zeros(size(data,1),3);
    headVec = zeros(size(data,1),3);

    for ind=1:size(data,1)
        [horHeadRads, verheadRads] = EquirectToSpherical(data(ind, xHeadInd), data(ind, yHeadInd), metadata.width_px, metadata.height_px);
        curHeadVec = SphericalToCart(horHeadRads, verheadRads);
        headVec(ind,:) = curHeadVec;

        angleHeadRads = data(ind, angleHeadInd) * pi / 180;

        rot = fullRotation(headVec, angleHeadRads);

        [horGazeRads, verGazeRads] = EquirectToSpherical(data(ind, xInd), data(ind, yInd), metadata.width_px, metadata.height_px);


        gazeVec = SphericalToCart(horGazeRads, verGazeRads);

        

        eyeHeadVec(ind,:) = gazeVec;


        eyeFovVec = rot * [eyeHeadVec(1,1);eyeHeadVec(1,3);eyeHeadVec(1,2)]; % LOCAL TO [0,1,0]
        eyeFovVec = eyeFovVec';
    end
end
