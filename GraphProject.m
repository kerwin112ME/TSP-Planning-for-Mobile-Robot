% MEEN 612 Mobile Robot Project
clear
clc
%% Graph Construction
Xrange = [0 100]; % map's x range
Yrange = [0 100]; % map's y range
r = 0.1*min(Xrange(2)-Xrange(1),Yrange(2)-Yrange(1)); % minimum turning radius

nodes = cell(1,10); % nodes of ten locations
for i = 1:10
    nodes{i} = node((Xrange(2)-Xrange(1))*rand,(Yrange(2)-Yrange(1))*rand);
end

cost = zeros(10,10); % distances of each nodes
for i = 1:10
    for j =1:10
        cost(i,j) = nodes{i}.dist(nodes{j});
    end
end

plotNodes(nodes)
%% Part 1 Dubin's path between two points
% there are 6 types of dubin's curve, only one will have minimum cost
% LSL = 1;
% LSR = 2;
% RSL = 3;
% RSR = 4;
% RLR = 5;
% LRL = 6;
p1 = 1;
p2 = 2;
nodes{p1}.heading = 3*pi/2;
nodes{p2}.heading = 4*pi/3;

[path,type] = dubins_curve(nodes{p1}.config, nodes{p2}.config, r, 0, 0);
disp(sprintf('type: %d',type));

%% part 2_1 MST
storeEdges = []; % edges used in MST
current = []; % nodes added into the MST
remain = 1:10; % remain index
root = 1;
current = horzcat(current,root);
MSTCost = 0; % Total cost of the MST

remain = remain(remain ~= root);
while(~isempty(remain))
    [m I] = minmat(cost(current,remain));
    minCurInd = current(I(1));
    minTarInd = remain(I(2)); 
    storeEdges = vertcat(storeEdges,[minCurInd minTarInd]); % add the min edge to the storeEdges
    nodes{minTarInd}.prev = minCurInd; % update nodes.prev
    current = horzcat(current,minTarInd); % update current
    remain = remain(remain ~= minTarInd); % update remain
end


figure
plotNodes(nodes)
title('Minimum Spanning Tree','fontsize',14)
hold on
for i = 1:9
    src = storeEdges(i,1);
    tar = storeEdges(i,2);
    edge = vertcat(nodes{src}.position,nodes{tar}.position)';
    plot(edge(1,:),edge(2,:),'b')
    MSTCost = MSTCost + cost(storeEdges(i,1),storeEdges(i,2));
end

%% Part 2_2 TSP Doubling Tree Heuristic
for i=1:9
    src = storeEdges(i,1);
    tar = storeEdges(i,2);
    nodes{src}.neighbors = horzcat(nodes{src}.neighbors,tar);
    %nodes{tar}.neighbors = horzcat(nodes{tar}.neighbors,src);
end

root = 1;
TSP = DFS_nodes;
TSP.setNodes(nodes);
TSP.DFS(1);
tour = horzcat(TSP.tour,root); % The TSP Tour
closedTour = TSP.tourAll;
 
%% Part 2_3 TSP adding heading angle
angles = linspace(0,2*pi,40);
stations = size(closedTour,2);
angleSet = optimalHeadings(nodes,angles,closedTour,r);

figure
plotNodes(nodes)
title('TSP route','fontsize',14)
hold on
for seg = 1:stations-1
    nodes{closedTour(seg)}.heading = angleSet(seg);
    nodes{closedTour(seg+1)}.heading = angleSet(seg+1);
    [path,type] = dubins_curve(nodes{closedTour(seg)}.config, nodes{closedTour(seg+1)}.config, r, 0, 1);
    plot(path(:,1), path(:,2),'b');
end
axis auto

%% Part 2_4 Christofide's Algorithm
match = matchOddVertices(storeEdges,nodes);
storeEdges = vertcat(storeEdges,match);

ET = EulerTour;
ET.setEdges(storeEdges);
ET.findEulerTour(1);


checkExist = zeros(1,10);
i = 1;
while(i <= size(ET.tour,2))
    if(checkExist(ET.tour(i)))
        ET.tour = horzcat(ET.tour(1:i-1),ET.tour(i+1:end));
    else
        checkExist(ET.tour(i)) = 1;
        i = i + 1;
    end
end
ET.tour = horzcat(ET.tour,1);

% plan trajectory
angles = linspace(0,2*pi,40);
stations = size(ET.tour,2);
angleSet = optimalHeadings(nodes,angles,ET.tour,r);

figure
plotNodes(nodes)
title('TSP with Christofide''s Heuristic','fontsize',14)
hold on
for seg = 1:stations-1
    nodes{ET.tour(seg)}.heading = angleSet(seg);
    nodes{ET.tour(seg+1)}.heading = angleSet(seg+1);
    [path,type] = dubins_curve(nodes{ET.tour(seg)}.config, nodes{ET.tour(seg+1)}.config, r, 0, 1);
    plot(path(:,1), path(:,2),'b');
end
axis auto

fprintf("try 1");
















