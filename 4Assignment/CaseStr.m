classdef CaseStr < handle
    properties
       activeAU;
       solution;
       timesRetrieved = 0;
    end
     methods
       function au = AURepresentation(self)
           au = zeros(1,45);
           au(1,self.activeAU) = 1;
       end
       
   end
   
end

