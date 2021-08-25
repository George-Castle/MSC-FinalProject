function [r,l,ur,ul,dr,dl] = quadrants(dataset)
    right = dataset(:,2)>=0;
    left  = dataset(:,2)<0;
    up_r = dataset(right,3)>=0;
    up_l = dataset(left,3)>=0;
    d_r = dataset(right,3)<0;
    d_l = dataset(left,3)<0;
    r = dataset(right,:);
    l = dataset(left,:);
    ur = dataset(up_r,:);
    ul = dataset(up_l,:);
    dr = dataset(d_r,:);
    dl = dataset(d_l,:);
end