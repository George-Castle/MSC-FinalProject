%TCP SERVER THAT RETURNS GAZE PREDICTION VALUES TO UNITY
%Load pre-trained Bagged Tree models for
%predicting coordinates if not already loaded
%load('BaggedTreesX.mat') 
%load('BaggedTreesY.mat')
%load('BaggedTreesZ.mat')

% initialise row for model input data
table = array2table(zeros(1,21));
table.Properties.VariableNames = {'Time','Head_World_X', 'Head_World_Y','Head_World_Z', 'Eye_World_X','Eye_World_Y','Eye_World_Z', 'Eye_Local_X', 'Eye_Local_Y', 'Eye_Local_Z', 'Head_Roll_Angle','Head_Velocity', 'Head_Amplitude', 'Eye_Amplitude', 'Peak_Velocity_Group', 'Cumulative_Shift_Amplitude', 'Head_Gaze_Distance', 'Shift_Average_Head_Gaze_Distance','Local_Shift_Coord_X','Local_Shift_Coord_Y','Local_Shift_Coord_Z'};

%set up TCP server and client for sending and receiving position data from
%unity
tcpipClient = tcpip('127.0.0.1',8052);
server = tcpserver("127.0.0.1",30000);
set(tcpipClient,'Timeout',3);
set(server,"Timeout",200);

% set up variables for receiving bytes from unity
time = 1:4;
x = 5:8;
y = 9:12;
z = 13:16;
rotat = 17:20;
data = read(server,20,"char");
T = uint8(data(1,time)) ;                      %// cast them to "uint8" if they are not already
Time1 = (typecast( T , 'single')) ; % convert each value from bytes
A = uint8(data(1,x)) ;                      %// 
X = typecast( A , 'single') ;
B = uint8(data(1,y)) ;                      %// 
Y = typecast( B , 'single') ;
C = uint8(data(1,z)) ;                      %// 
Z = typecast( C , 'single') ;
velo1 = 0.0;

while true %server is Connected - keep receiving data whilst server is sending it
    data = read(server,20,"char"); % translate data from bytes to float
    T = uint8(data(1,time)) ;                      %// 
    Time = typecast( T , 'single') ;
    A = uint8(data(1,x)) ;                      %// 
    Afloat = typecast( A , 'single') ;
    B = uint8(data(1,y)) ;                      %// 
    Bfloat = typecast( B , 'single') ;
    C = uint8(data(1,z)) ;                      %// 
    Cfloat = typecast( C , 'single') ;
    R = uint8(data(1,rotat)) ;                      %// 
    rotation = typecast( R , 'single') ;
    if((Time - Time1) > 3.5) % due to server lag only update every 3.5 seconds otherwise backlog made for late gaze predicitions
        %calculate amplitude and velocity
        theta = rad2deg(abs(2*(asin(sqrt(((X-Afloat)^2)+((Y-Bfloat)^2)+((Z-Cfloat)^2))/2)))); % amplitude in °
        velo = theta/(Time - Time1); % velocity in °/s

        if (velo >= 3.0 && velo1 < 3.0) % if start of a head shift (head speed above 3°/s)
            Shift_X = Afloat; % set start of shift values
            Shift_Y = Bfloat;
            Shift_Z = Cfloat;
            Shift_rot = rotation;
            local_X = 0;
            local_Y = 1;
            local_Z = 0;
        elseif(velo >= 3.0 && velo1 > 3.0) % if both current and last entry still faster than 3°/s (still in current shift)
            rot = fullRotation([Shift_X,Shift_Z,Shift_Y], Shift_rot); % make current shift local to first entry 
            eyeFovVec = rot * [Afloat;Bfloat;Cfloat]; % LOCAL TO [0,1,0]
            eyeFovVec = eyeFovVec';
            local_X = eyeFovVec(1,1);
            local_Y = eyeFovVec(1,2);
            local_Z = eyeFovVec(1,3);    
        else %if(velo < 5.0 && velo1 > 5.0) % end of shift
            local_X = 0;
            local_Y = 1;
            local_Z = 0;
        end
        table{1, 1} = Time * 1000000; % change seconds to microseconds
        table{1, 11} = rotation;
        table{1, 12} = velo;
        table{1, 13} = theta;
        table{1, 19} = local_X;
        table{1, 20} = local_Y;
        table{1, 21} = local_Z;
        Gaze_X = BaggedTreesX.predictFcn(table(1,:)); % get X gaze predicition
        Gaze_Y = BaggedTreesY.predictFcn(table(1,:)); % get Y gaze predicition
        Gaze_Z = BaggedTreesZ.predictFcn(table(1,:)); % get Z gaze predicition
        %send back predicted gaze loaction to Unity
        fopen(tcpipClient);
        % pass the matrix "move" into the client (unity)
        disp([Time,Gaze_X,Gaze_Y,Gaze_Z]);
        fwrite(tcpipClient,[num2str(Gaze_X), ' ',num2str(Gaze_Y), ' ',num2str(Gaze_Z)]);
        % close the client
        fclose(tcpipClient);
        X = Afloat; % set X,Y,Z values for difference calculations with next unity input
        Y = Bfloat;
        Z = Cfloat;
        velo1 = velo;
        Time1 = Time;
    end
end



