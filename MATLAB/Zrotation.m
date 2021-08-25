% performs rotation around Z axis
function rot = Zrotation(headVec)
    x2 = 1;
    y2 = 0;
    z2 = 0;
    % get ear vector
    ear = cross([headVec(1,1); headVec(1,3); headVec(1,2)], [0;0;1]); % technical paper swapped y and z
    ear = ear/norm(ear);
    x1 = ear(1,1);
    y1 = ear(2,1); 
    z1 = ear(3,1);
    xn = 0;
    yn = 0;
    zn = 1;
    
    dot = x1*x2 + y1*y2 + z1*z2;
    det = x1*y2*zn + x2*yn*z1 + xn*y1*z2 - z1*y2*xn - z2*yn*x1 - zn*y1*x2;
    angle = atan2(det, dot);
    % same formula as from report
    [rot] = Rodrigues([0,0,1], angle);

end
