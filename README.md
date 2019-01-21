# EAGLE: an algorithm that utilizes small number of genomic features to predict tissue/cell type specific enhancer-gene interactions
EAGLE used all six features only derived from the enhancers and gene expression datasets, without providing more information like histone modification, methylation or other enhancer-gene (EG) detection datasets. With a high accuracy thirteen times larger than employing the closest genes, EAGLE was applied to identify 7,680,203 and 7,437,255 EG interactions involving 31,375 and 43,724 genes, 138,547 and 177,062 enhancers across 89 and 110 tissue/cell types in mouse and human, respectively. The predicted datasets are available in an interactive website http://www.enhanceratlas.org.

# Usage
perl EAGLE.pl -E <Enhancer> -G <Expression>
Example for prediction of EG interaction: perl EAGLE.pl -E inputexample/cell_enh.bed -G inputexample/cell_gene.txt
Essential Options
-E: A tab-delineate file indicate the enhancer positions and signals with format as "<chr>\t<start>\t<end>\t<signal>"
-G: A tab-delineate file displayed the expression value of ensembl genes with format as "<Ensembl>\t<Value>"
  
# Softwares
To run EAGLE, following softwares are required:<br />
Perl v5.16.3<br />
Matlab R2017b<br />
