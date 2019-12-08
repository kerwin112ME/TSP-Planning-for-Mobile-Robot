function cost = pathCost(path)
    s = size(path,1);
    cost = 0;
    for i = 1:s-1
        p1 = path(i,1:2);
        p2 = path(i+1,1:2);
        cost = cost + sqrt((p2(1)-p1(1))^2 + (p2(2)-p1(2))^2);
    end
end
    