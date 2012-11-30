function [case] = retrieve(CBR, newCase)
	%% returns the case which fits best with the data
	case = CaseStr;

	% first find all clusters which are the closest to newCase
	d = zeros(numel(CBR.base));
	for i=1:numel(CBR.base)
		d(i) = similarity1(CBR,base{i}.meanVec, newCase);
	end

	% now step through all cases in the cluster to find the best case
	m = min(d);
	m = find(d==m);
	for k = 1:length(m)
		for j=1:CBR.base{min(d)}.count
			
		end
	end
end