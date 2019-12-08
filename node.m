classdef node
    properties
        x = 0;
        y = 0;
        heading = 0;
        prev;
        neighbors = [];
    end
    
    methods
        function obj = node(x,y,varargin)
            obj.x = x;
            obj.y = y;
            if nargin == 3
                obj.heading = varargin{1};
            elseif nargin == 4
                obj.prev = varargin{2};
            end
        end
        
        function pos = position(obj)
            x = obj.x;
            y = obj.y;
            pos = [x,y];
        end
        
        function conf = config(obj)
            x = obj.x;
            y = obj.y;
            h = obj.heading;
            conf = [x y h];
        end
        
        function l = dist(n1,n2)
            xdiff = n2.x - n1.x;
            ydiff = n2.y - n1.y;
            l = sqrt(xdiff^2 + ydiff^2);
        end
        
    end
end