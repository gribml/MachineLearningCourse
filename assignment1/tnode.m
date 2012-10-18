classdef tnode < handle
    
    properties ( SetAccess = private, GetAccess = public )
        sons;
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

        function n = numbersons( self )
            n = length( self.sons );
        end
    end
    
end