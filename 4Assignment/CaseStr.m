classdef CaseStr < handle
	properties
        activeAU;
        solution;
        timesRetrieved = 0;
        cbrIndex;
    end
    
    properties(GetAccess = 'private', SetAccess = 'private')
        N = 45;
    end
    
	methods
        
        function obj = CaseStr(AU, sol)
            if ( nargin >= 1 )
                obj.activeAU = find(AU==1);
                obj.N = length(AU);
                obj.timesRetrieved = 0;
            end
            
            if ( nargin == 2 )
                obj.solution = sol;
            end
        end
        
        function au = AURepresentation(self)
            au = zeros(1, self.N);
            au(1,self.activeAU) = 1;
        end
        
        function retrieved(self)
            self.timesRetrieved = self.timesRetrieved + 1;
        end
        
        function result = isEmpty(self)
            if isempty(self.activeAU) && isempty(self.solution)
                result = 1;
            else
                result = 0;
            end
        end
    end
end

