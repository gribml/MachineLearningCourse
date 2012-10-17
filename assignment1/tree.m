classdef tree < tnode

    properties ( SetAccess = private, GetAccess = public )
        root;
        dad;
    end

    methods        
        function obj = tree( data )
            obj = obj@tnode( data );
            if ( nargin > 0 )
                obj.root = obj;
                obj.dad = obj;
            end
        end
    end
    
end