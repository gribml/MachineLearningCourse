%% Romain Brault
%% CID : 00761721

function [ error ] = rms_error( prediction, response )
    error = sqrt( mean( ( response - prediction )^.2 ) );
end

