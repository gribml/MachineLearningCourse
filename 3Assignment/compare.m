perfFun = 'mse';

lr = [0.1, 0.2, 0.3];

transFun = {'tansig', 'hardlim', 'logsig','purelin', 'radbasn', 'softmax' };

trainFun = { 'trainlm', 'trainbfg', 'trainbr', 'traincgb', 'traincgf', 'traincgp', ...
    'traingdm', 'traingdx', 'trainscg'}; 

nepocs = 15;
minneurons = 3;
neurIncr = 3;
nneurons = 15;
for tn = 1:length(trainFun)
    
    multiNew.classRate = 0;
    singleNew.classRate = 0;
    multiNew.trainFun = trainFun(tn);
    singleNew.trainFun = trainFun(tn);
    multiMaxCr = 0;
    singleMaxCr = 0;
    
    for r = 1:length(lr)
        for tf = 1:length(transFun)  
            for i=minneurons:neurIncr:nneurons 
                
               str = sprintf('forLoad/perf_%s_%s_%f_%d.mat', transFun{tf}, trainFun{tn}, lr(r), i);
               load(str);
               if( multi.classRate > multiMaxCr)
                   
                   multiMaxCr = multi.classRate;
                   multiNew.noNeurons = i;
                   multiNew.classRate = multi.classRate;
                   multiNew.learningRate = multi.learningRate;
                   multiNew.confMtrx = multi.confMtrx;
                   multiNew.recall = multi.recall;
                   multiNew.precision = multi.precision;
                   multiNew.transferFun = multi.transferFun;
               end
               if( single.classRate > singleMaxCr)
                   
                   singleMaxCr = single.classRate;
                   singleNew.noNeurons = i;
                   singleNew.classRate = single.classRate;
                   singleNew.learningRate = single.learningRate;
                   singleNew.confMtrx = single.confMtrx;
                   singleNew.recall = single.recall;
                   singleNew.precision = single.precision;
                   singleNew.transferFun = single.transferFun;
               end
            end
            clear multi;
            clear single;
        end
    end
    save(sprintf('bestResults/%s.mat', trainFun{tn}), 'singleNew', 'multiNew');
    clear multiNew;
    clear singleNew;
end


