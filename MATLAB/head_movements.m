function a = head_movements(dataset)
dataset.head_move = zeros(height(dataset), 1);
    for c = 1:height(dataset)
        for i = c:height(dataset)
            theta = 2*(asin(sqrt(((dataset{i,2}-dataset{c,2})^2)+((dataset{i,3}-dataset{c,3})^2)+((dataset{i,4}-dataset{c,4})^2))/2));
            if(c ~= i) && ((theta/(dataset{i,1} - dataset{c,1})) > (0.349066/1000000.0)) % compare if head move speed is greater than 20 degrees/second
                for x = c:i
                    dataset{x, 8} = 1;
                end
                break;
            end
        end
        disp(theta);
    end
a = dataset;
end