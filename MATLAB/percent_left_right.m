% finds the percentage time that the eyes are to the right or left of the
% head at the end of a shift and the mean distance that the eyes were from
% the head target
% ONLY CONSIDERS FIXATIONS AT END OF SHIFT WHEN HEAD IS STILL
function [lp, rp, lm, rm] = percent_left_right(dataset)
   right_eyes(1,:) = zeros(1,1);
   left_eyes(1,:) = zeros(1,1);
   total = 0;
   left = 0;
   right = 0;
   for c = 1:(height(dataset))
        if(dataset(c,18) > 0)
            total = total + 1;
            if (dataset(c,8) < 0)
                left = left + 1;
                left_eyes =[left_eyes;dataset(c,18)];
            elseif (dataset(c,8) > 0)
                right = right + 1;
                right_eyes =[right_eyes;dataset(c,18)];
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