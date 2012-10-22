classdef tnode < handle
    
    properties ( SetAccess = private, GetAccess = public )
        children;
        data;
    end
    
    methods
        function obj = tnode( data )
            obj;
            if ( nargin > 0 )
                obj.data = data;
            end
        end
        
        function data = get.data( self )
            data = self.data;
        end

        function n = nChildren( self )
            n = length( self.children );
        end
    end
    
end