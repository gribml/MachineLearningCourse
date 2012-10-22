classdef tree < tnode

    properties ( SetAccess = private, GetAccess = public )
        root;
        parent;
    end

    methods        
        function obj = tree( data )
            obj = obj@tnode( data );
            if ( nargin > 0 )
                obj.root = obj;
                obj.parent = obj;
            end
        end
    end
    
end