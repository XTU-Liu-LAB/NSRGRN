clear;
clc;
warning off;

DS = 1;
result = [];
global data netsize

while DS <= 25
    %% data loading
    data = getDataSet(DS);
    if DS <= 15
        data(:,1) = [];
    end
    netsize = size(data, 1); 
    score_matrix = zeros(netsize, netsize);

    tic;
    if DS <= 5 || DS >= 21 % size 10
        top = 0.1;
        bottom = top * 2;
        step = 0.1;
        roundEnd = 1;
    end
    if DS > 5 && DS <= 10 % size 50
        top = 0.01;
        bottom = top * 2;
        step = 0.01;
        roundEnd = 1;
    end
    if DS > 10 && DS <= 20 % size 100
        top = 0.01;
        bottom = top * 2;
        step = 0.01;
        roundEnd = 0.5;
    end
    downDeleteList = zeros(10000, 2);
    downDeleteListIdx = 1;
    %% data processing
    [linkList, diff] = getdynGENIE3Net(DS);
    fixedLowerEdgeList = [];

    while top < roundEnd
        tic;
        upperEdgeList = linkList(1 : netsize * netsize * top, 1 : 2);
        lowerEdgeList = linkList(1 : netsize * netsize * bottom, 1 : 2);

        %% edge pruning for the lower network
        if roundEnd - bottom < 0.0000001
            lowerEdgeList = fixedLowerEdgeList;
        else
            PIRList = getPIR(lowerEdgeList);            
            [c, ia, ib] = intersect(PIRList(:, 1 : 2), downDeleteList, 'rows');
            while ~isempty(ia)
                 PIRList = setdiff(PIRList, PIRList(ia, :), 'rows');
                 [c, ia, ib] = intersect(PIRList(:, 1 : 2), downDeleteList, 'rows');
            end
            deleteList = edgePruning(0.05, PIRList);
            for j = 1 : size(deleteList)
                downDeleteList(downDeleteListIdx, 1) = deleteList(j, 1);
                downDeleteList(downDeleteListIdx, 2) = deleteList(j, 2);
                downDeleteListIdx = downDeleteListIdx + 1;
            end
            lowerEdgeList = setdiff(lowerEdgeList(:, 1:2), downDeleteList, 'rows');
            fixedLowerEdgeList = lowerEdgeList;
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % pick the common edges in both upper and lower net
        finalEdgeList = intersect(upperEdgeList, lowerEdgeList, 'rows');
%         finalEdgeList = lowerEdgeList;
        
        length = size(finalEdgeList, 1);
        for i  = 1 : length
            score = score_matrix(finalEdgeList(i, 1), finalEdgeList(i, 2));
            score_matrix(finalEdgeList(i, 1), finalEdgeList(i, 2)) = score + 1;
        end    
        toc;
        
        fprintf('top=%f\n',top);
        fprintf('bottom=%f\n',bottom);
        if roundEnd - bottom < 0.0000001
            top = top + step;
        else
            top = top + step;
            bottom = top * 2;
        end
    end
    toc;
    score_matrix = score_matrix + diff;
    fileNameOf1 = char('Result/' + string(DS) + '_' + string(1) + '.txt');
    fileNameOf0 = char('Result/' + string(DS) + '_' + string(0) + '.txt');
    get_link_list(score_matrix, 1 : netsize, [], 0, fileNameOf1);
    get_link_list(diff, 1 : netsize, [], 0, fileNameOf0);
    
    DS = DS + 1;
end