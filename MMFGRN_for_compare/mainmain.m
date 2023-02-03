clear;
clc;
warning off;

DS = 21;
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
        roundEnd = 0.8;
    end
    downDeleteList = zeros(10000, 2);
    downDeleteListIdx = 1;
    %% data processing
    [linkList, diff] = getPMFGRNNet(DS);
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
            deleteList = edgePruning(0.5, PIRList);
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
%             score = score_matrix(finalEdgeList(i, 1), finalEdgeList(i, 2));
%             score_matrix(finalEdgeList(i, 1), finalEdgeList(i, 2)) = score + 1;
            score = score_matrix(finalEdgeList(i, 1), finalEdgeList(i, 2));
            diff_score = diff(finalEdgeList(i, 2), finalEdgeList(i, 1));
            score_matrix(finalEdgeList(i, 1), finalEdgeList(i, 2)) = score + diff_score;
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

% clear;
% clc;
% warning off;
% 
% DS = 20;
% result = [];
% global data netsize
% 
% while DS <= 20
%     %% data loading
%     data = getDataSet(DS);
%     if DS <= 15
%         data(:,1) = [];
%     end
%     netsize = size(data, 1); 
%     score_matrix = zeros(netsize, netsize);
% 
%     tic;
%     if DS <= 5 || DS >= 21 % size 10
%         top = 0.1;
%         bottom = top * 2;
%         step = 0.1;
%         roundEnd = 1;
%     end
%     if DS > 5 && DS <= 10 % size 50
%         top = 0.01;
%         bottom = top * 2;
%         step = 0.01;
%         roundEnd = 1;    
%     end
%     if DS > 10 && DS <= 20 % size 100
%         top = 0.01;
%         bottom = top * 2;
%         step = 0.01;
%         roundEnd = 0.5;    
%     end
%     upDeleteList = [];
%     downDeleteList = [];
%     %% data processing
%     [linkList, diff] = getPMFGRNNet(DS);
%     fixedLowerEdgeList = [];
% 
%     while top < roundEnd
%         tic;
%         upperEdgeList = linkList(1 : netsize * netsize * top, 1 : 2);
%         lowerEdgeList = linkList(1 : netsize * netsize * bottom, 1 : 2);
% 
%         %% edge pruning for the upper network
%         PIRList = getPIR(upperEdgeList);
%         if ~isempty(upDeleteList)
%             [c, ia, ib] = intersect(PIRList(:, 1 : 2), upDeleteList, 'rows');
%             while ~isempty(ia)
%                  PIRList = setdiff(PIRList, PIRList(ia, :), 'rows');
%                  [c, ia, ib] = intersect(PIRList(:, 1 : 2), upDeleteList, 'rows');
%             end
%         end        
%         deleteList = edgePruning(0.05, PIRList);
%         upDeleteList = [upDeleteList; deleteList];
%         if ~isempty(deleteList) && ~isempty(upperEdgeList)
%             upperEdgeList = setdiff(upperEdgeList(:, 1:2), upDeleteList, 'rows');
%         end
%         %% edge pruning for the lower network
%         if roundEnd - bottom < 0.0000001
%             lowerEdgeList = fixedLowerEdgeList;
%         else
%             PIRList = getPIR(lowerEdgeList);
%             if ~isempty(downDeleteList)
%                 [c, ia, ib] = intersect(PIRList(:, 1 : 2), downDeleteList, 'rows');
%                 while ~isempty(ia)
%                      PIRList = setdiff(PIRList, PIRList(ia, :), 'rows');
%                      [c, ia, ib] = intersect(PIRList(:, 1 : 2), downDeleteList, 'rows');
%                 end
%             end
%             deleteList = edgePruning(0.005, PIRList);
%             downDeleteList = [downDeleteList; deleteList];
%             if ~isempty(lowerEdgeList) && ~isempty(deleteList)
%                 lowerEdgeList = setdiff(lowerEdgeList(:, 1:2), downDeleteList, 'rows');
%             end
%             fixedLowerEdgeList = lowerEdgeList;
%         end
% 
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         % pick out the edges that exist in the upper net but do not
%         % exist in the lower net
%         deleteList = setdiff(upperEdgeList, lowerEdgeList, 'rows');
%         finalEdgeList = setdiff(upperEdgeList(:, 1:2), deleteList, 'rows');
% %         finalEdgeList = upperEdgeList;
%         
%         length = size(finalEdgeList, 1);
%         for i  = 1 : length
%             score = score_matrix(finalEdgeList(i, 1), finalEdgeList(i, 2));
%             score_matrix(finalEdgeList(i, 1), finalEdgeList(i, 2)) = score + 1;
%         end    
%         toc;
%         
%         fprintf('top=%f\n',top);
%         fprintf('bottom=%f\n',bottom);
%         if roundEnd - bottom < 0.0000001
%             top = top + step;
%         else
%             top = top + step;
%             bottom = top * 2;
%         end
%     end
%     toc;
%     score_matrix = score_matrix + diff;
%     fileNameOf1 = char('Result/' + string(DS) + '_' + string(1) + '.txt');
%     fileNameOf0 = char('Result/' + string(DS) + '_' + string(0) + '.txt');
%     get_link_list(score_matrix, 1 : netsize, [], 0, fileNameOf1);
%     get_link_list(diff, 1 : netsize, [], 0, fileNameOf0);
%     
%     DS = DS + 1;
% end


% clear;
% clc;
% warning off;
% 
% DS = 12;
% result = [];
% global data netsize
% 
% while DS <= 15
%     %% data loading
%     data = getDataSet(DS);
%     if DS <= 15
%         data(:,1) = [];
%     end
%     netsize = size(data, 1);
%     score_matrix = zeros(netsize, netsize);
% 
%     tic;
%     top = 0.001;
%     bottom = top * 2;
%     [linkList, diff] = getPMFGRNNet(DS);
%     fixedLowerEdgeList = [];
%     
%     while top < 0.5
%         tic;
%         %% data processing
%         upperEdgeList = linkList(1 : netsize * netsize * top,1 : 2);
%         lowerEdgeList = linkList(1 : netsize * netsize * bottom,1 : 2);
% 
%         %% edge pruning for the upper network
%         PIRList = getPIR(upperEdgeList);      
%         deleteList = edgePruning(0.05, PIRList);
%         if ~isempty(deleteList) && ~isempty(upperEdgeList)
%             upperEdgeList = setdiff(upperEdgeList(:, 1:2), deleteList, 'rows');
%         end
%         %% edge pruning for the lower network
%         if 0.5 - bottom < 0.0000001
%             lowerEdgeList = fixedLowerEdgeList;
%         else
%             PIRList = getPIR(lowerEdgeList);
%             deleteList = edgePruning(0.005, PIRList);
%             if ~isempty(lowerEdgeList) && ~isempty(deleteList)
%                 lowerEdgeList = setdiff(lowerEdgeList(:, 1:2), deleteList, 'rows');
%             end
%             fixedLowerEdgeList = lowerEdgeList;
%         end
% 
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         % pick out the edges that exist in the upper net but do not
%         % exist in the lower net
%         deleteList = setdiff(upperEdgeList, lowerEdgeList, 'rows');
%         finalEdgeList = setdiff(upperEdgeList(:, 1:2), deleteList, 'rows');
%         
%         length = size(finalEdgeList, 1);
%         for i  = 1 : length
%             score = score_matrix(finalEdgeList(i, 1), finalEdgeList(i, 2));
%             score_matrix(finalEdgeList(i, 1), finalEdgeList(i, 2)) = score + 1;
%         end    
%         toc;
%         
%         fprintf('top=%f\n',top);
%         fprintf('bottom=%f\n',bottom);
%         if 0.5 - bottom < 0.0000001
%             top = top + 0.001;
%         else
%             top = top + 0.001;
%             bottom = top * 2;
%         end
%     end
%     toc;
%     score_matrix = score_matrix + diff;
%     fileNameOf11 = char('Result/mmfgrn' + string(DS) + '_' + string(11) + '.txt');
%     fileNameOf0 = char('Result/mmfgrn' + string(DS) + '_' + string(0) + '.txt');
%     get_link_list(score_matrix, 1 : netsize, [], 0, fileNameOf11);
%     get_link_list(diff, 1 : netsize, [], 0, fileNameOf0);
%     
%     DS = DS + 1;
% end