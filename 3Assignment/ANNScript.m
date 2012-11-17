function ANNScript

% mae, mse, sse
perfFn = ['mae', 'mse', 'sse'];
lr = 0:0.001:1;
transFun = ['compet', 'hardlim', 'hardlims', 'logisg', 'netinv', 'poslin', ...
    'purelin', 'radbas', 'radbasn', 'satlin', 'satlins', 'softmax', ...
    'tansig', 'tribas'];
trainFn = ['train', 'trainb', 'trainbfg', 'trainbfdc', 'trainbr', 'trainbu', ...
    'trainc', 'traincgb', 'traincgf', 'traincgp', 'traingd', 'traingda', ...
    'traingdm', 'traingdx', 'trainlm', 'trainoss', 'trainr', 'trainrp', ...
    'trainru', 'trains', 'trainscg'];

load cleandata_students;

[x2, y2] = ANNdata(x, y);

for p=perfFn
    for rate = lr
        for transfer = transFun
            for train = trainFn
                for i=1:20
                    net = buildNetwork(i, 50, [0.667, 0.33, 0], x2, y2, p, ...
                    rate, transfer, train);
                    
                end
            end
        end
    end
end
