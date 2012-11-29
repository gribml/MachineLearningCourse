function [ c ] = createCase( x, varargin)
%CREATECASE Summary of this function goes here
%   Detailed explanation goes here
    c = CaseStr;
    c.activeAU = find(x);
    if(nargin > 1 )
        c.solution = varargin{1};
    end

end

