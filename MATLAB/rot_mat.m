%returns a rotation matrix to localise world coordinates to the positive y
%axis
function rot = rot_mat(headVec, angleHeadRads)
    x2 = 0;
    y2 = 0;
    z2 = -1;
    x1 = headVec(1,1);
    y1 = headVec(3,1); % technical paper swapped y and z
    z1 = headVec(2,1);
    ear = cross([x1;y1;z1], [0;0;-1]);% around the y becuase the technical paper swapped y and z
    ear = ear/norm(ear);
    xn = ear(1,1);
    yn = ear(2,1);
    zn = ear(3,1);
    dot = x1*x2 + y1*y2 + z1*z2;
    det = x1*y2*zn + x2*yn*z1 + xn*y1*z2 - z1*y2*xn - z2*yn*x1 - zn*y1*x2;
    angle = atan2(det, dot);
    [mat] = Rodrigues(ear, angle);
    
    xn = 0;
    yn = 0;
    zn = -1;
    dot = x1*x2 + y1*y2 + z1*z2;
    det = x1*y2*zn + x2*yn*z1 + xn*y1*z2 - z1*y2*xn - z2*yn*x1 - zn*y1*x2;
    angle = atan2(det, dot);
    [mat2] = Rodrigues([0;0;-1], angleHeadRads);
   
    rot = mat;

end
