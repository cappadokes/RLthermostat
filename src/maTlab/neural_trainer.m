%========================================================================
%|National Technical University of Athens                               |
%|School of Electrical & Computer Engineering                           |
%|Microprocessors & Digital Systems Lab                                 |
%|----------------------------------------------------------------------|
%|"Realization of an Energy Management System for Commercial Buildings" |
%|Undergraduate Thesis                                                  |
%========================================================================

function [new_net, tr, A, B] = neural_trainer(episode_num, TB, old_net, g)

%disp(['Training a new agent on a base of ' num2str(size(TB,2)) ' experiences.']);

[patterns, targets, A, B] = data_extraction(TB, old_net, g);
    
    layers = [13 7 4];
    %Create a new network object. We will use the Levenberg-Marquardt training algorithm.
    new_net = feedforwardnet(layers, 'trainrp');

    new_net = configure(new_net, patterns, targets);

    %Default transfer function for output layer is purelin.
    new_net.layers{1+length(layers)}.transferFcn = 'logsig';
    new_net.trainParam.epochs = 2000;

    %We want a standardized input. We also want no post-processing of the
    %output, because we do a scaling of our own.
    new_net.outputs{1+length(layers)}.processFcns = {'removeconstantrows'};
    new_net.inputs{1}.processFcns{1,2} = 'mapstd';
    
[new_net, tr] = train(new_net, patterns, targets);

end