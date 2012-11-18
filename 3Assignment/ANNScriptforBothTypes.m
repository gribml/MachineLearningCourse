%perfFun = {'mae', 'mse', 'sse'};
perfFun = 'mse';

lr = 0.01:0.05:0.2;

transFun = {'tansig', 'hardlim', 'hardlims', 'logisg', 'netinv', 'poslin', ...
    'purelin', 'radbas', 'radbasn', 'satlin', 'satlins', 'softmax', ...
    'tribas', 'compet', };

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

FID = fopen('perf_results.txt', 'w');
for r = 1:length(lr)
    for tf = 1:length(transFun)
        for tn = 1:length(trainFun)
            sprintf('**********************************************************************')
            sprintf('prefFun=%s, lr=%d, tranFun=%s, trainFun=%s', perfFun, lr(r), transFun{tf}, trainFun{tn})
            for i=minneurons:2:nneurons
                net = buildNetwork(i, nepocs, [0.667, 0.33, 0], x2, y2, perfFun, lr(r), transFun{tf}, trainFun{tn});
                pred = testANN(net, x2);
                %Build 6 networks with binary output
                 l = size(y2,1);
                 binaryNets = cell( l, 1 );
                 for k=1:l
                    binaryNets{k} = buildNetwork( i, 50, [0.667, 0.33, 0], x2, y2(i,:), perfFun{p}, lr(r), transFun{tf}, trainFun{tn} );        
                 end
                 
                [cm, rc, pr, f, cr] = confusion(pred, y);
                fprintf(FID, 'for one 6-outputted NN: /n(%s, %f, %s, %s): %f', perfFun, lr(r), transFun{tf}, trainFun{tn});
                sprintf('nneurons : %d, classification rate : %f', i, cr)   
                
                pred2 = testANN(binaryNets, x2);
                [cm, rc, pr, f, cr] = confusion(pred2, y);
                fprintf(FID, 'for 6 1-outputted NN: /n(%s, %f, %s, %s): %f', perfFun, lr(r), transFun{tf}, trainFun{tn});
                sprintf('nneurons : %d, classification rate : %f', i, cr)   
               
            end
        end
    end
end
fclose(FID);