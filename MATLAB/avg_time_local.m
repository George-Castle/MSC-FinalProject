%AVG TIME TAKEN FOR EYES TO MOVE ABOVE 5° AFTER A SHIFT
function [avg_time,count_t] = avg_time_local(dataset)
    idx = dataset{:,18} > 0;
    time = 0;
    count = 0;
    for c = 1:(height(dataset)-200)
        if(idx(c,1) == 1)
            for i = c:(c+200)
               theta = rad2deg(abs(2*(asin(sqrt(((dataset{c,5}-dataset{i,5})^2)+((dataset{c,6}-dataset{i,6})^2)+((dataset{c,7}-dataset{i,7})^2))/2)))); 
               
               if (theta > 12.0)
                    disp(theta);
                    if(dataset{i,1} > dataset{c,1}) %Means that they are from two different shifts, if so skip
                        time = time + (dataset{i,1} - dataset{c,1});
                        count = count + 1;
                        disp(time);
                        break;
                    else
                        break;
                    end
               end
               if(i == (c+199)) % if beyond 200 entries add the time and move to next
                   if(dataset{i,1} > dataset{c,1}) %Means that they are from the same shift, if not skip
                        time = time + (dataset{i,1} - dataset{c,1});
                        count = count + 1;
                        disp(time);
                        break;
                    else
                        break;
                    end
               end
            end
        end
    end
    avg_time = time;
    count_t = count;
end