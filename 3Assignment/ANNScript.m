%perfFun = {'mae', 'mse', 'sse'};
perfFun = 'mse';

lr = 0.01:0.05:0.2;

transFun =  {'logsig', 'netinv', 'poslin', ...
    'purelin', 'radbas', 'radbasn', 'satlin', 'satlins', 'softmax', ...
    'tribas', 'compet', };
transFun_done = {'tansig', 'hardlim', 'hardlims',};

trainFun = { 'trainlm', 'trainbfg', 'trainbr', 'trainc', 'traincgb', 'traincgf', 'traincgp', 'traingd', 'traingda', ...
    'traingdm', 'traingdx', 'trainlm', 'trainoss', 'trainr', 'trainrp', ...
     'trains', 'trainscg'};
% not working functions
% 'trainbfdc', 'train', 'trainb', 'trainbu', 'trainru',

load cleandata_students;

[x2, y2] = ANNdata(x, y);

nepocs = 20;
minneurons = 1;
nneurons = 15;

%FID = fopen('perf_results2.txt', 'w');
% matlabpool(2);
for r = 1:length(lr)
    FID = fopen(sprintf('perf_results_%f.txt', lr(r)), 'w');
    for tf = 1:length(transFun)
        for tn = 1:length(trainFun)
            fprintf(FID, '\n\n**********************************************************************')
            sprintf('prefFun=%s, lr=%d, tranFun=%s, trainFun=%s', perfFun, lr(r), transFun{tf}, trainFun{tn})
            fprintf(FID, '(%s, %f, %s, %s): %f\n', perfFun, lr(r), transFun{tf}, trainFun{tn});
            for i=minneurons:2:nneurons
                net = buildNetwork(i, nepocs, [0.667, 0.33, 0], x2, y2, perfFun, lr(r), transFun{tf}, trainFun{tn});
                pred = testANN(net, x2);
                [cm, rc, pr, f, cr] = confusion(pred, y);
                fprintf(FID, 'nneurons : %d, classification rate : %f\n', i, cr)
            end
        end
    end
    fclose(FID);
end
% matlabpool close;

