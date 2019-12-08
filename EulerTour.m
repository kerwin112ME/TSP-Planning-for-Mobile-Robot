classdef EulerTour < handle
    properties
        tour = []
        edges
    end
    
    methods
        function setEdges(obj,edges)
            obj.edges = edges;
        end
        
        function findEulerTour(obj,src)
            while(1)
                % check if there is still an outgoing edge
                if(isempty(find(obj.edges == src)))
                    break;
                end
                
                [outgoing,~] = find(obj.edges == src);
                ind = outgoing(1); % the edge index in edges
                edge = obj.edges(ind,:);
                nextV = edge(find(edge~=src)); % go to next vertex
                % remove the edge 
                if ind ~= size(obj.edges,1)
                    obj.edges = vertcat(obj.edges(1:ind-1,:),obj.edges(ind+1:end,:));
                else
                    obj.edges = obj.edges(1:end-1,:);
                end
                findEulerTour(obj,nextV);
                
            end
            obj.tour = horzcat(obj.tour,src);
        end
        
    end
end