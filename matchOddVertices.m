function match = matchOddVertices(edges,nodes)
    N = size(nodes,2);
    oddNodes = [];
    match = [];
    
    for i=1:N
        if (rem(sum(edges(:) == i),2) ~= 0)
            oddNodes = horzcat(oddNodes,i);
        end
    end
    
    while(~isempty(oddNodes))
        minL = 10000;
        minI = 2;
        for i=2:size(oddNodes,2)
            pos1 = nodes{oddNodes(1)}.position;
            pos2 = nodes{oddNodes(i)}.position;
            L = sqrt((pos2(1)-pos1(1))^2 + (pos2(2)-pos1(2))^2);
            if(minL > L)
                minI = i;
                minL = L;
            end
        end
        match = vertcat(match,[oddNodes(1),oddNodes(minI)]);
        oddNodes = oddNodes(oddNodes ~= oddNodes(minI));
        oddNodes = oddNodes(2:end);
    end
    
end
            
             
                
                
        