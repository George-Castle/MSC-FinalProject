%performs full rotation of world coordinates to localise to positive y axis
%first rotation is around z axis, then x then y axis to get the roll value
function rot = fullRotation(headVec, angleHeadRads)
    rot1 = Zrotation(headVec); % Z rotation
    newHeadVec = rot1 * [headVec(1,1); headVec(1,3); headVec(1,2)]; % apply Z rotation
    rot2 = Xrotation(newHeadVec);% X rotation
    rot3 = Yrotation(angleHeadRads);% Y roll rotation
    rot = rot3 * rot2 * rot1; % return full  rotation matrix with all three combined

end