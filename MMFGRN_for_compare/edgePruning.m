function deleteList = edgePruning(alpha, PIRList)
    global data;
    
    regulatorPass = 0;
    targetPass = 0;
    deleteList = zeros(10000, 3);
    idx = 1;
    for i = 1 : size(PIRList, 1)
        regulator = PIRList(i, 1);
        target = PIRList(i, 2);
        if regulator == regulatorPass && target == targetPass
            continue;
        end
        condition = PIRList(i, 3);
        
        regLine = data(regulator, :);
        tgtLine = data(target, :);
        condLine = data(condition, :);
        
        regLine(target) = [];
        tgtLine(target) = [];
        condLine(target) = [];
        
        cmiv = cmi(regLine, tgtLine, condLine);
        if cmiv < alpha
            deleteList(idx, 1) = regulator;
            deleteList(idx, 2) = target;
            regulatorPass = regulator;
            targetPass = target;
            idx = idx + 1;
        end
    end
    deleteList = unique(deleteList, 'rows');% clear duplicates
end

% function deleteList = edgePruning(alpha, PIRList)
%     global data;
%     
%     deleteList = zeros(0, 3);
%     for i = 1 : size(PIRList, 1)
%         regulator = PIRList(i, 1);
%         target = PIRList(i, 2);
%         condition = PIRList(i, 3);
%         
%         regLine = data(regulator, :);
%         tgtLine = data(target, :);
%         condLine = data(condition, :);
%         
%         regLine(target) = [];
%         tgtLine(target) = [];
%         condLine(target) = [];
%         
%         cmiv = cmi(regLine, tgtLine, condLine);
%         if cmiv < alpha
% %             deleteList = [deleteList; regulator, target, condition];
%             deleteList = [deleteList; regulator, target];
%         end
%     end
%     deleteList = unique(deleteList, 'rows');% clear duplicates
% end