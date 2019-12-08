classdef DFS_nodes < handle
    properties
        nodes
        tour = []
        tourAll = []
    end
    
    methods
        function setNodes(obj,nodes)
            obj.nodes = nodes;
        end
            
        function DFS(obj,root)
            s = size(obj.nodes{root}.neighbors,2); 
            obj.tour = horzcat(obj.tour,root);
            obj.tourAll = horzcat(obj.tourAll,root);
            for i = 1:s
                DFS(obj,obj.nodes{root}.neighbors(i));
                obj.tourAll = horzcat(obj.tourAll,root);
            end
        end
        
    end
end