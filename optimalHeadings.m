function angleSet = optimalHeadings(nodes,angles,tour,r)
    % nodes: 10 locations
    % angles: heading discretization 
    % tour: TSP tour
    % r: minimum turning radius
    
    tourSize = size(tour,2);
    angSize = size(angles,2);
    DP_table = cell(angSize,tourSize-1);
    
    % initialize the last column of DP_table
    for i = 1:angSize
        nodes{tour(end-1)}.heading = angles(i);
        temp = zeros(1,angSize);
        for j = 1:angSize
            nodes{tour(end)}.heading = angles(j);
            temp(j) = DubinPathCost(nodes{tour(end-1)}.config,nodes{tour(end)}.config,r);
        end
        [m,ind] = min(temp);
        DP_table{i,end} = [m,ind];
    end
    
    for j = tourSize-2:-1:1
        for i = 1:angSize
            nodes{tour(j)}.heading = angles(i);
            temp = cell2mat(DP_table(:,j+1));
            for k = 1:angSize
                nodes{tour(j+1)}.heading = angles(k);
                temp(k,1) = temp(k,1) + DubinPathCost(nodes{tour(j)}.config,nodes{tour(j+1)}.config,r);
            end
            [m,ind] = min(temp(:,1));
            DP_table{i,j} = [m,ind];
        end
    end
    
    angleSet = zeros(1,tourSize);
    costVec2 = cell2mat(DP_table(:,2));
    
    minI = 0;
    minCost = 10000;
    lastAng = 0;
    for ind = 1:size(costVec2,1)
        cur = 2;
        i = ind;
        while(cur <= size(DP_table,2))
            costVec = cell2mat(DP_table(:,cur));
            nextAng = costVec(i,2);
            i = nextAng;
            cur = cur+1;
        end
        
        nodes{tour(1)}.heading = angles(i);
        nodes{tour(2)}.heading = angles(ind);
        dist = DubinPathCost(nodes{tour(1)}.config,nodes{tour(2)}.config,r);
        if(costVec2(ind,1)+dist < minCost)
            minI = ind;
            lastAng = i;
            minCost = costVec2(ind,1)+dist;
        end
    end
        
    %[m i] = min(costVec(:,1));
    %angleSet(1) = angles(i);
    %disp(sprintf('total cost: %.2f',m));
    
    angleSet(1) = angles(lastAng);
    i = minI;
    disp(sprintf('total cost: %.2f',minCost));
    
    cur = 2;
    while(cur <= size(DP_table,2))
        angleSet(cur) = angles(costVec(i,2));
        costVec = cell2mat(DP_table(:,cur));
        [m i] = min(costVec(:,1));
        cur = cur + 1;
    end
    angleSet(cur) = angles(costVec(i,2));
    
end
            
            
            
            
            
            
            
            
            
            
            
            