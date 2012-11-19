function ANNScriptLite2Layers

% not used training functions
% 'trainbfdc', 'train', 'trainb', 'trainbu', 'trainru', 'trainr', 'trainrp',
% 'trainc', 'trains', 'trainrp', 'traingd', 'traingda'
% not used transfer functions
% 'compet', 'netinv', 'tribas', 'radbas', 'radbasn', 'satlin', 'satlins', 'poslin'
% not used performance functions
% 'sse', 'rse'

perfFun = 'mse';


lr = 0.1;

transFun = {'tansig', 'hardlim', 'logsig','purelin', 'radbasn', 'softmax' };

trainFun = { 'trainlm', 'trainbfg', 'trainbr', 'traincgb', 'traincgf', 'traincgp', ...
    'traingdm', 'traingdx', 'trainscg'}; 

load cleandata_students;

[x2, y2] = ANNdata(x, y);

nepocs = 15;
minneurons = 2;
neurIncr = 2;
maxneurons = 10;

matlabpool(2);
for tf = 1:length(transFun)
%     FID_single = fopen(sprintf('results/perf_results_single_%s.txt', transFun{tf}), 'w');
%     FID_multi = fopen(sprintf('results/perf_results_multi_%s.txt', transFun{tf}), 'w');
    single.transferFun = transFun{tf};
    multi.transferFun = transFun{tf};
    for tn = 1:length(trainFun)
        single.trainFun = trainFun{tn};
        multi.trainFun = trainFun{tn};
        for r = 1:length(lr)
            single.learningRate = lr(r);
            multi.learningRate = lr(r);
            sprintf('**********************************************************************')
            sprintf('prefFun=%s, lr=%d, tranFun=%s, trainFun=%s', perfFun, lr(r), transFun{tf}, trainFun{tn})
            for i=minneurons:neurIncr:maxneurons
                for j = minneurons:neurIncr:maxneurons
                    single.numNeurons = [i,j];
                    net = buildNetwork([i,j], nepocs, [0.667, 0.33, 0], x2, y2, perfFun, lr(r), transFun{tf}, trainFun{tn});
                    pred = testANN(net, x2);
                    [cm, rc, pr, f, cr] = confusion(pred, y);
                    fprintf(FID_single, 'for one 6-outputted NN: (%s, %f, %s, %s): %f', perfFun, lr(r), transFun{tf}, trainFun{tn});
                    sprintf('nneurons : [%d, %d], classification rate : %f', i, j, cr)   
                    single.confMtrx = cm;
                    single.F = f;
                    single.recall = rc;
                    single.precision = pr;
                    single.classRate = cr;

                    %Build 6 networks with binary output
                    l = size(y2,1);
                    binaryNets = cell( l, 1 );
                    for k=1:l
                        binaryNets{k} = buildNetwork( [i, j], nepocs, [0.667, 0.33, 0], x2, y2(k,:), perfFun, lr(r), transFun{tf}, trainFun{tn} );        
                    end
                    pred2 = testANN(binaryNets, x2);
                    [cm, rc, pr, f, cr] = confusion(pred2, y);
                    fprintf(FID_multi, 'for 6 1-outputted NN: (%s, %f, %s, %s): %f', perfFun, lr(r), transFun{tf}, trainFun{tn});
                    sprintf('nneurons : %d, classification rate : %f', i, cr)
                    multi.confMtrx = cm;
                    multi.numNeurons = [i.j];
                    multi.F = f;
                    multi.recall = rc;
                    multi.precision = pr;
                    multi.classRate = cr;
                    save(sprintf('2layer_results/perf_%s_%s_%f_%d.mat', transFun{tf}, trainFun{tn}, lr(r), i), 'single', 'multi');
                end
            end
        end
    end
%     fclose(FID_single);
%     fclose(FID_multi);
end
matlabpool close;