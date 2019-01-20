# EAGLE: an algorithm that utilizes small number of genomic features to predict tissue/cell type specific enhancer-gene interactions
EAGLE used all six features only derived from the enhancers and gene expression datasets, without providing more information like histone modification, methylation or other enhancer/promoter-related detection datasets. With a high accuracy thirteen times larger than employing the closest genes, EAGLE could correctly identify the individual enhancer-gene interactions across 110 and 89 tissue/cell types in human and mouse, respectively. 

# Usage
perl EAGLE.pl -E enhancer_file -G gene_expression_file

