function ANNScriptLite

% not used training functions
% 'trainbfdc', 'train', 'trainb', 'trainbu', 'trainru', 'trainr', 'trainrp',
% 'trainc', 'trains', 'trainrp', 'traingd', 'traingda'
% not used transfer functions
% 'compet', 'netinv', 'tribas', 'radbas', 'radbasn', 'satlin', 'satlins', 'poslin'
% not used performance functions
% 'sse', 'rse'

perfFun = 'mse';


lr = 0.1;

transFun = {'tansig', 'logsig','purelin', 'radbasn', 'softmax' };

trainFun = { 'trainlm', 'trainbfg', 'trainbr', 'traincgb', 'traingdm', 'traingdx', 'trainscg'};

load cleandata_students;

[x2, y2] = ANNdata(x, y);

nepocs = 15;
minneurons = 3;
neurIncr = 3;
maxneurons = 12;

%matlabpool(2);
for tf = 1:length(transFun)
%    FID_single = fopen(sprintf('results/perf_results_single_%s.txt', transFun{tf}), 'w');
%    FID_multi = fopen(sprintf('results/perf_results_multi_%s.txt', transFun{tf}), 'w');
    single.transferFun = transFun{tf};
    multi.transferFun = transFun{tf};
    single.learningRate = lr;
    multi.learningRate = lr;
	for tn = 1:length(trainFun)
        single.trainFun = trainFun{tn};
        multi.trainFun = trainFun{tn};
        sprintf('**********************************************************************')
        sprintf('prefFun=%s, lr=%d, tranFun=%s, trainFun=%s', perfFun, lr, transFun{tf}, trainFun{tn})
        for i=minneurons:neurIncr:maxneurons
            for j = 0:neurIncr:maxneurons
                % split data 67% training 33% testing
                shuff = randperm(length(y));
                trainmask = shuff(1:floor(2*end/3));
                valmask = shuff(ceil(2*end/3):end);
                
                % train and test the single output neural network
                single.numNeurons = [i,j];
                net = buildNetwork(i, nepocs, [0.75, 0.25, 0], x2(:,trainmask), y2(:,trainmask), perfFun, lr, transFun{tf}, trainFun{tn});
                pred = testANN(net, x2(:,valmask));
                [cm, rc, pr, f, cr] = confusion(pred, y(valmask));
%                fprintf(FID_single, 'for one 6-outputted NN: /n(%s, %f, %s, %s): %f', perfFun, lr(r), transFun{tf}, trainFun{tn});
                sprintf('num neurons : %d, classification rate : %f', i, cr)   
                single.confMtrx = cm;
                single.F = f;
                single.recall = rc;
                single.precision = pr;
                single.classRate = cr;

                %Build 6 networks with binary output
                l = size(y2,1);
                binaryNets = cell( l, 1 );
                for k=1:l
                    binaryNets{k} = buildNetwork( i, nepocs, [0.75, 0.25, 0], x2(:,trainmask), y2(k,trainmask), perfFun, lr, transFun{tf}, trainFun{tn} );
                end
                pred2 = testANN(binaryNets, x2(:,valmask));
                [cm, rc, pr, f, cr] = confusion(pred2, y(valmask));
%                fprintf(FID_multi, 'for 6 1-outputted NN: /n(%s, %f, %s, %s): %f', perfFun, lr(r), transFun{tf}, trainFun{tn});
                sprintf('num neurons : %d, classification rate : %f', i, cr)
                multi.confMtrx = cm;
                multi.numNeurons = [i,j];
                multi.recall = rc;
                multi.F = f;
                multi.precision = pr;
                multi.classRate = cr;
                save(sprintf('results/perf_%s_%s_%d-%d.mat', transFun{tf}, trainFun{tn}, i, j), 'single', 'multi');
            end
        end
	end
%    fclose(FID_single);
%    fclose(FID_multi);
end
%matlabpool close;