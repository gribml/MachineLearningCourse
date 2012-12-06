function predictions = testANN( net, examples )
    l = length( net );
    examples = transpose( examples );
    if ( l == 1 )
        predictions = sim( net, examples );
        predictions = NNout2labels( predictions );
    else
        t_predictions = zeros( l, length( examples ) );
        for i=1:l
            t_predictions(i, :) = sim( net{ i }, examples );
        end
        predictions = NNout2labels( t_predictions );
    end
end

