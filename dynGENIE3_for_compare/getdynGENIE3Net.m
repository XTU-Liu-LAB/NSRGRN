function [dynGENIE3List, dynGENIE3Net] = getdynGENIE3Net(DS)
    global netsize;
    goldfiles = {
        'RankList/ranklist1.txt'; 'RankList/ranklist2.txt'; 'RankList/ranklist3.txt'; 'RankList/ranklist4.txt'; 'RankList/ranklist5.txt';......
        'RankList/ranklist6.txt'; 'RankList/ranklist7.txt'; 'RankList/ranklist8.txt'; 'RankList/ranklist9.txt'; 'RankList/ranklist10.txt';......
        'RankList/ranklist11.txt'; 'RankList/ranklist12.txt'; 'RankList/ranklist13.txt'; 'RankList/ranklist14.txt'; 'RankList/ranklist15.txt';......
        'RankList/ranklist16.txt'; 'RankList/ranklist17.txt'; 'RankList/ranklist18.txt'; 'RankList/ranklist19.txt'; 'RankList/ranklist20.txt';......
        'RankList/ranklist21.txt'; 'RankList/ranklist22.txt'; 'RankList/ranklist23.txt'; 'RankList/ranklist24.txt'; 'RankList/ranklist25.txt';
        'RankList/ranklist_sos.txt';};
    goldfile = cell2mat(goldfiles(DS));
    C=importdata(goldfile);
    dynGENIE3Net = zeros(netsize, netsize);
    dynGENIE3List = zeros(size(C.textdata, 1), size(C.textdata, 2));
    % remove the character G from the element
    for i = 1 : size(C.textdata, 1)
        for j = 1 : size(C.textdata, 2)
            C.textdata(i, j) = strrep(C.textdata(i, j),'G','');
            dynGENIE3List(i, j) = str2double(C.textdata(i,j));
        end
    end
    dynGENIE3List(:, 3) = mapminmax(C.data', 0, 0.9999)';
    length = size(dynGENIE3List, 1);
    for n = 1 : length
        dynGENIE3Net(dynGENIE3List(n, 1), dynGENIE3List(n, 2)) = dynGENIE3List(n, 3);
    end
    for i = 1 : netsize
        dynGENIE3List = [dynGENIE3List; i, i, 0];
    end
end