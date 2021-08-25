%CONSIDERS ALL ENTRIES THAT ARE IN A SHIFT
function [lp, rp, lm, rm] = avg_left_right(dataset)
   right_eyes(1,:) = zeros(1,1);
   left_eyes(1,:) = zeros(1,1);
   total = 0;
   left = 0;
   right = 0;
   for c = 1:(height(dataset))
        if(dataset(c,15) ~= 0)
            total = total + 1;
            if (dataset(c,8) < 0)
                left = left + 1;
                left_eyes =[left_eyes;dataset(c,17)];
            elseif (dataset(c,8) > 0)
                right = right + 1;
                right_eyes =[right_eyes;dataset(c,17)];
            end
        end
   end
   right_eyes(1,:) = [];
   left_eyes(1,:) = [];
   
   lm = mean(left_eyes);
   rm = mean(right_eyes);
   
   lp = (left/total)*100;
   rp = (right/total)*100;
end