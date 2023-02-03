function [PMFGRNList, PMFGRNNet] = getPMFGRNNet(DS)
    global netsize;
    goldfiles = {
        'RankList/ranklist1.txt'; 'RankList/ranklist2.txt'; 'RankList/ranklist3.txt'; 'RankList/ranklist4.txt'; 'RankList/ranklist5.txt';......
        'RankList/ranklist6.txt'; 'RankList/ranklist7.txt'; 'RankList/ranklist8.txt'; 'RankList/ranklist9.txt'; 'RankList/ranklist10.txt';......
        'RankList/ranklist11.txt'; 'RankList/ranklist12.txt'; 'RankList/ranklist13.txt'; 'RankList/ranklist14.txt'; 'RankList/ranklist15.txt';......
        'RankList/ranklist16.txt'; 'RankList/ranklist17.txt'; 'RankList/ranklist18.txt'; 'RankList/ranklist19.txt'; 'RankList/ranklist20.txt';......
        'RankList/ranklist21.txt'; 'RankList/ranklist22.txt'; 'RankList/ranklist23.txt'; 'RankList/ranklist24.txt'; 'RankList/ranklist25.txt';};
    goldfile = cell2mat(goldfiles(DS));
    C=importdata(goldfile);
    PMFGRNNet = zeros(netsize, netsize);
    PMFGRNList = zeros(size(C.textdata, 1), size(C.textdata, 2));
    % remove the character G from the element
    for i = 1 : size(C.textdata, 1)
        for j = 1 : size(C.textdata, 2)
            C.textdata(i, j) = strrep(C.textdata(i, j),'G','');
            PMFGRNList(i, j) = str2double(C.textdata(i,j));
        end
    end
    PMFGRNList(:, 3) = mapminmax(C.data', 0.01, 0.9999)';
    length = size(PMFGRNList, 1);
    for n = 1 : length
        PMFGRNNet(PMFGRNList(n, 1), PMFGRNList(n, 2)) = PMFGRNList(n, 3);
    end
    for i = 1 : netsize
        PMFGRNList = [PMFGRNList; i, i, 0];
    end
    PMFGRNList = sortrows(PMFGRNList, -3);
end