function [ error ] = classify_error( prediction, response )
    error = mean( response ~= prediction );
end
