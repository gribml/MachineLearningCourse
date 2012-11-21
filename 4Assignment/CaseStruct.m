classdef CASE < thandle
   properties
       x_indices;
       y_indices;
       timesRetrieved;
       N;
   methods
       function CASE(x, y, N)
           obj.x = x_indices;
           obj.y = y_indices;
           obj.timesRetrieved = 0;
           obj.N = N;
       end
       
       function au = AURepresentation(self)
           au = zeros(self.N);
           au(self.x) = 1;
       end
end