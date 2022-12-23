clear;
clc;
warning off;

global data
%% data loading
load('SOS_X.mat');
load('SOS_net.mat');
data = SOS_X;
[x, y] = find(SOS_net == 1);
real = [x, y];
netsize = size(data, 1);
score_matrix = zeros(netsize, netsize);

top = 0.1;
bottom = top * 2;
step = 0.1;
roundEnd = 1;
%% constructing of the preliminary ranking list
[linkList, diff] = getSOSLinkList(data);
downDeleteList = zeros(10000, 2);
downDeleteListIdx = 1;
fixedLowerEdgeList = [];

%% network structure refinement
while top < roundEnd
    tic;
    upperEdgeList = linkList(1 : netsize * netsize * top,1 : 2);
    lowerEdgeList = linkList(1 : netsize * netsize * bottom,1 : 2);

    % local topology optimization for the lower network
    if roundEnd - bottom < 0.0000001
        lowerEdgeList = fixedLowerEdgeList;
    else
        PIRList = getPIR(lowerEdgeList);            
        [c, ia, ib] = intersect(PIRList(:, 1 : 2), downDeleteList, 'rows');
        while ~isempty(ia)
             PIRList = setdiff(PIRList, PIRList(ia, :), 'rows');
             [c, ia, ib] = intersect(PIRList(:, 1 : 2), downDeleteList, 'rows');
        end
        deleteList = edgePruning(0.3, PIRList);
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
    
    length = size(finalEdgeList, 1);
    % re-score
    for i  = 1 : length
        score = score_matrix(finalEdgeList(i, 1), finalEdgeList(i, 2));
        score_matrix(finalEdgeList(i, 1), finalEdgeList(i, 2)) = score + 1;
    end    
    toc;

    fprintf('top=%f\n',top);
    fprintf('bottom=%f\n',bottom);
    % next iteration
    if roundEnd - bottom < 0.0000001
        top = top + step;
    else
        top = top + step;
        bottom = top * 2;
    end
end

score_matrix = score_matrix + diff;
get_link_list(score_matrix, 1 : netsize, [], 0, 'sos_1.txt');
% get_link_list(diff, 1 : netsize, [], 0, 'sos_0');
    