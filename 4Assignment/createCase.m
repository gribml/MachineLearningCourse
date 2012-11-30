function [ c ] = createCase( x, varargin)
%CREATECASE returns a new CaseStr with activeAU variable instantiated

    c = CaseStr;
    c.activeAU = find(x);
    if(nargin > 1 )
        c.solution = varargin{1};
    end

end

