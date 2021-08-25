% ONLY CONSIDERS FIXATIONS AT END OF SHIFT WHEN HEAD IS STILL
function a = fixation_finder(dataset)
   dataset(:,15) = zeros(height(dataset),1);
   for c = 1:(height(dataset))
        if(dataset(c,10) < 0.5)
            i = c + 1;
            while((rad2deg(abs(2*(asin(sqrt(((dataset(c,5)-dataset(i,5))^2)+((dataset(c,6)-dataset(i,6))^2)+((dataset(c,7)-dataset(i,7))^2))/2))))) < 0.5)
                if(i < height(dataset))
                    i = i + 1;
                end
            end
            if((dataset(i,10) - dataset(c,10)) > 80000)
                for x = c:i
                    if((dataset(x,2) > dataset(c,5)))
                        dataset(x,15) = 0-dataset(x,13);
                    else
                        dataset(x,15) = dataset(x,13);
                    end
                end
            end
        end 
   end
   a  = dataset;
end