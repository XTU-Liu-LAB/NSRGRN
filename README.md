# NSRGRN: A network structure refinement method for gene regulatory network inference

## Description

The method, NSRGRN, was created and tested using  MATLAB®  2016b. Please refer to our manuscript termed “NSRGRN: A network structure refinement method for gene regulaotry network inference” for more detailed information about this algorithm.

## The describe of the files

main.m and main_sos.m are the running script of NSRGRN.

getLinkList.m gets the preliminary ranking list of gene regulations.

getSOSLinkList.m gets the preliminary ranking list of gene regulations.

get_link_list.m gets the final ranking list of gene regulations.

getDataSet.m is a function for getting the specific dataset in DREAM3 or DREAM4 challenges.

getGlodNet.m is a function for getting the corresponding standard network of the current dataset.

getPIR.m is a function for finding the potentially indirect regulation in the feedforward loop.

getBalanceConcentration.m calculates the balance concentration of all genes under a specific network.

edgePruning.m verifies the potentially indirect regulation using CMID.

cmi.m is a function for calculating the CMI.  This code is derived from a paper termed "[Inferring gene regulatory networks from gene expression data by path consistency algorithm based on conditional mutual information](https://www.researchgate.net/publication/220262053_Inferring_gene_regulatory_networks_from_gene_expression_data_by_path_consistency_algorithm_based_on_conditional_mutual_information)" by Zhang et al., 2012. 

## The describe of the folders

The folder "comparing_method " contains the prediction results of six comparing methods (PCA-CMI, NIMEFI, MMFGRN, PLSNET, GENIE3 and dynGENIE3). This folder also contains the code and prediction results of the NSR algorithm when acting as a post-processing step.

The folder "data10 " contains datasets of 10-gene networks in DREAM3.

The folder "data50 " contains datasets of 50-gene networks in DREAM3.

The folder "data100 " contains datasets of 100-gene networks in DREAM3.

The folder "gold" contains the standard networks of all datasets in DREAM3.

The folder "DREAM4_InSilico_Size10" contains datasets of 10-gene networks in DREAM4.

The folder "DREAM4_InSilico_Size100" contains datasets of 100-gene networks in DREAM4.

The folder "DREAM4_InSilicoNetworks_GoldStandard" contains the standard networks of all datasets in DREAM4.

The folder "detailed_information" contains  the detailed information about DREAM3 and DREAM4 challenges.

## Datasets

You can find the entire dataset of DREAM3 in [here](https://dreamchallenges.org/dream-3-in-silico-network-challenge/) and the entire dataset of DREAM4 in [here](https://dreamchallenges.org/dream-4-in-silico-network-challenge/).
