function data = getDataSet(DS)
    files = {'data10/InSilicoSize10-Ecoli1-null-mutants.tsv'; 'data10/InSilicoSize10-Ecoli2-null-mutants.tsv';
        'data10/InSilicoSize10-Yeast1-null-mutants.tsv'; 'data10/InSilicoSize10-Yeast2-null-mutants.tsv';
        'data10/InSilicoSize10-Yeast3-null-mutants.tsv'; 
        'data50/InSilicoSize50-Ecoli1-null-mutants.tsv';
        'data50/InSilicoSize50-Ecoli2-null-mutants.tsv'; 'data50/InSilicoSize50-Yeast1-null-mutants.tsv';
        'data50/InSilicoSize50-Yeast2-null-mutants.tsv'; 'data50/InSilicoSize50-Yeast3-null-mutants.tsv';
        'data100/InSilicoSize100-Ecoli1-null-mutants.tsv'; 'data100/InSilicoSize100-Ecoli2-null-mutants.tsv';
        'data100/InSilicoSize100-Yeast1-null-mutants.tsv'; 'data100/InSilicoSize100-Yeast2-null-mutants.tsv';
        'data100/InSilicoSize100-Yeast3-null-mutants.tsv'; 'DREAM4_InSilico_Size100/insilico_size100_1/insilico_size100_1_knockouts.tsv';
        'DREAM4_InSilico_Size100/insilico_size100_2/insilico_size100_2_knockouts.tsv'; 'DREAM4_InSilico_Size100/insilico_size100_3/insilico_size100_3_knockouts.tsv';
        'DREAM4_InSilico_Size100/insilico_size100_4/insilico_size100_4_knockouts.tsv'; 'DREAM4_InSilico_Size100/insilico_size100_5/insilico_size100_5_knockouts.tsv';
        'DREAM4_InSilico_Size10/insilico_size10_1/insilico_size10_1_knockouts.tsv';
        'DREAM4_InSilico_Size10/insilico_size10_2/insilico_size10_2_knockouts.tsv';
        'DREAM4_InSilico_Size10/insilico_size10_3/insilico_size10_3_knockouts.tsv';
        'DREAM4_InSilico_Size10/insilico_size10_4/insilico_size10_4_knockouts.tsv';
        'DREAM4_InSilico_Size10/insilico_size10_5/insilico_size10_5_knockouts.tsv';};
    file = cell2mat(files(DS));
    A = importdata(file);
    data = A.data';
end
