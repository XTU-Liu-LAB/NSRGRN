function bc = getBalanceConcentration(data)
    global  netsize;
    bc = zeros(netsize, netsize);
    for i = 1 : netsize
        for j = 1 :netsize
            if i ~= j
                % Obtain the expression value of the target gene to be determined
                tgtLine = data(j,:);
                if i > j
                    tgtLine(i)=[];
                    tgtLine(j)=[];
                else
                    tgtLine(j)=[];
                    tgtLine(i)=[];
                end
                [Idx,C,sumD,D] = kmeans(tgtLine',1,'distance', 'cityblock','Replicates',1,'Start','sample');
%                 [Idx,C,sumD,D] = kmeans(tgtLine',1);
                bc(j, i) = C;
            end
        end
    end     
end