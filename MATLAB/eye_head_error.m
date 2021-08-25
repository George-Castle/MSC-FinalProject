function a = eye_head_error(dataset)
    dataset(:,17) = zeros(height(dataset),1);
    for c = 1:height(dataset)
        theta = rad2deg(abs(2*(asin(sqrt(((dataset(c,2)-dataset(c,5))^2)+((dataset(c,3)-dataset(c,6))^2)+((dataset(c,4)-dataset(c,7))^2))/2))));
        dataset(c,17) = theta;
    end
    a = dataset;
end