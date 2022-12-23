function [linkList, diff] = getSOSLinkList(data)
    diff = abs(data);
    % set the main diagonal to 0
    diff(logical(eye(size(diff)))) = 0;
    % reverse regulatory direction
%     diff = diff'; 
    
    netsize = size(data, 1);
    linkList = zeros(netsize * netsize, 3);
    lineNum = 1;
    for i = 1 : netsize
        for j = 1 : netsize
            linkList(lineNum, 1) = i;
            linkList(lineNum, 2) = j;
            linkList(lineNum, 3) = diff(i, j);
            lineNum = lineNum + 1;
        end
    end
    linkList = sortrows(linkList, -3);
end