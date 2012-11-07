function predictions = testANN( net, examples )
    l = length( net );
    if ( l == 1 )
        predictions = sim( net, examples );
        predictions = NNout2labels( predictions );
    else
        t_predictions = cell( l, 1 );
        for i=1:l
            t_predictions{ i } = sim( net{ i }, examples );
        end
        t_predictions = cell2mat( t_predictions );
        predictions = t_predictions;
    end
end

