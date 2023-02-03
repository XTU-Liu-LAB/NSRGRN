% PIR : potentially indirect relation
function PIR = getPIR(edgeList)
    PIR = zeros(10000, 3);
    idx = 1;
    for i = 1: size(edgeList, 1)
        currentRegulator = edgeList(i, 1);
        currentTarget = edgeList(i, 2);

        % find all targets of the current regulator
        indexes = edgeList(:,1) == currentRegulator;
        edges = edgeList(indexes, :);
        targetsOfCurrentRegulator = edges(:, 2);
        % find all targets of the current target
        indexes = edgeList(:,1) == currentTarget;
        edges = edgeList(indexes, :);
        targetsOfCurrentTarget = edges(:, 2);
        
        % get the potentially redundant indirect relations
        coTargets = intersect(targetsOfCurrentRegulator, targetsOfCurrentTarget, 'rows');
        if ~isempty(coTargets)
            for j = 1 : size(coTargets)
                PIR(idx, 1) = currentRegulator;
                PIR(idx, 2) = coTargets(j);
                PIR(idx, 3) = currentTarget;
                idx = idx + 1;
            end
        end
    end
end

% % PIR : potentially indirect relation
% function PIR = getPIR(edgeList)
%     PIR = zeros(0, 3);
%     for i = 1: size(edgeList, 1)
%         edge = edgeList(i, :);
%         currentRegulator = edge(1);
%         currentTarget = edge(2);
% 
%         % find all targets of the current regulator
%         indexes = edgeList(:,1) == currentRegulator;
%         edges = edgeList(indexes, :);
%         targetsOfCurrentRegulator = edges(:, 2);
%         % find all targets of the current target
%         indexes = edgeList(:,1) == currentTarget;
%         edges = edgeList(indexes, :);
%         targetsOfCurrentTarget = edges(:, 2);
%         
%         % get the potentially redundant indirect relations
%         coTargets = intersect(targetsOfCurrentRegulator, targetsOfCurrentTarget, 'rows');
%         if ~isempty(coTargets)
%             for j = 1 : size(coTargets)
%                 PIR = [PIR; currentRegulator, coTargets(j), currentTarget];
%             end
%         end
%     end
% end