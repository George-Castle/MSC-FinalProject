% returns rotation matrix for rotating around Y axis
function rot = Yrotation(angleHeadRads)
    [rot] = Rodrigues([0,1,0], -angleHeadRads); % NEGATIVE TO CORRECT HEAD ANGLE ROTATION
end
