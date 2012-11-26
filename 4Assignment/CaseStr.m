classdef CaseStr < handle
    properties
       x_indices;
       solution;
       timesRetrieved = 0;
       N;
    end
   
   methods
       function  obj = get(self)
           obj.xindices = self.x_indices;
           obj.y = self.solution;
           obj.timesRetrieved = 0;
           obj.N = self.N;
       end
       
       function au = AURepresentation(self)
           au = zeros(self.N);
           au(self.x_indices) = 1;
       end
       
   end
   
end

