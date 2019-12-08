function DPC = DubinPathCost(p1,p2,r)
    [path,type] = dubins_curve(p1, p2, r, 0, 1);
    DPC = pathCost(path);
end