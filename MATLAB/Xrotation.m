% used to build rotation matrix to rotate clockwise around x axis
function rot = Xrotation(headVec)
    x2 = 0;
    y2 = 1;
    z2 = 0;
    x1 = headVec(1,1); % PASS CORRECT WAY = XYZ
    y1 = headVec(2,1); 
    z1 = headVec(3,1);
    xn = 1;
    yn = 0;
    zn = 0;
    
    dot = x1*x2 + y1*y2 + z1*z2;
    det = x1*y2*zn + x2*yn*z1 + xn*y1*z2 - z1*y2*xn - z2*yn*x1 - zn*y1*x2;
    angle = atan2(det, dot);
    % formula above as described in final report
    [rot] = Rodrigues([1,0,0], angle);

end
