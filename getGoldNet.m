function real = getGoldNet(DS)
    goldfiles = {'gold/DREAM3GoldStandard_InSilicoSize10_Ecoli1.txt'; 'gold/DREAM3GoldStandard_InSilicoSize10_Ecoli2.txt';
        'gold/DREAM3GoldStandard_InSilicoSize10_Yeast1.txt'; 'gold/DREAM3GoldStandard_InSilicoSize10_Yeast2.txt';
        'gold/DREAM3GoldStandard_InSilicoSize10_Yeast3.txt'; 
        'gold/DREAM3GoldStandard_InSilicoSize50_Ecoli1.txt';
        'gold/DREAM3GoldStandard_InSilicoSize50_Ecoli2.txt'; 'gold/DREAM3GoldStandard_InSilicoSize50_Yeast1.txt';
        'gold/DREAM3GoldStandard_InSilicoSize50_Yeast2.txt'; 'gold/DREAM3GoldStandard_InSilicoSize50_Yeast3.txt';
        'gold/DREAM3GoldStandard_InSilicoSize100_Ecoli1.txt'; 'gold/DREAM3GoldStandard_InSilicoSize100_Ecoli2.txt';
        'gold/DREAM3GoldStandard_InSilicoSize100_Yeast1.txt'; 'gold/DREAM3GoldStandard_InSilicoSize100_Yeast2.txt';
        'gold/DREAM3GoldStandard_InSilicoSize100_Yeast3.txt'; 'DREAM4_InSilicoNetworks_GoldStandard/Size 100/DREAM4_GoldStandard_InSilico_Size100_1.tsv';
        'DREAM4_InSilicoNetworks_GoldStandard/Size 100/DREAM4_GoldStandard_InSilico_Size100_2.tsv'; 'DREAM4_InSilicoNetworks_GoldStandard/Size 100/DREAM4_GoldStandard_InSilico_Size100_3.tsv';
        'DREAM4_InSilicoNetworks_GoldStandard/Size 100/DREAM4_GoldStandard_InSilico_Size100_4.tsv'; 'DREAM4_InSilicoNetworks_GoldStandard/Size 100/DREAM4_GoldStandard_InSilico_Size100_5.tsv';
        'DREAM4_InSilicoNetworks_GoldStandard/Size 10/DREAM4_GoldStandard_InSilico_Size10_1.tsv';
        'DREAM4_InSilicoNetworks_GoldStandard/Size 10/DREAM4_GoldStandard_InSilico_Size10_2.tsv';
        'DREAM4_InSilicoNetworks_GoldStandard/Size 10/DREAM4_GoldStandard_InSilico_Size10_3.tsv';
        'DREAM4_InSilicoNetworks_GoldStandard/Size 10/DREAM4_GoldStandard_InSilico_Size10_4.tsv';
        'DREAM4_InSilicoNetworks_GoldStandard/Size 10/DREAM4_GoldStandard_InSilico_Size10_5.tsv';};
    goldfile = cell2mat(goldfiles(DS));
    C=importdata(goldfile);
    goldNetSize = size(find(C.data == 1),1); % get the number of edges of the standard network
    realCell = C.textdata(1:goldNetSize,1:2);
    real = zeros(size(realCell, 1), size(realCell, 2));
    % remove the character G from the element
    for i = 1 : size(real, 1)
        for j = 1 : size(real, 2)
            realCell(i, j) = strrep(realCell(i, j),'G','');
            real(i, j) = str2double(realCell(i,j));
        end
    end
end
