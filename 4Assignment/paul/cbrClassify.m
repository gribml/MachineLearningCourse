function out = cbrClassify(input, caseBase)
	% step 1: 
	activeInput = find(input==1);
	clusters = zeros(caseBase.numClasses);
	cases_list = caseBase.empty();
	best_cases = caseBase.empty();
	solutions = caseBase.empty();

	for i=1:caseBase.numClasses
		index = caseBase.class{1}.activations;
		
	end
end