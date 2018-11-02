use Getopt::Long;
if(@ARGV < 1){
    print "an Enhancer And Gene based Learning Ensembl mothod for prediction of enhancer-gene pairs\n";
    print " Usage:perl EAGLE.pl -E <Enhancer profile> -G <Gene Expression>\n";
    exit;
}

GetOptions('E=s'=>\$Enh, 'G=s'=>\$GeneExpr);
mkdir("Temp");

#Enhancer input normalization
system("perl ./enhancerinfo/getEnhancer.pl ".$Enh);

#get the 100 Mb regions upstream/downstream TSS
system("perl geneinfo/GetRegionNearTSS.pl ".$GeneExpr);

#get the enhancer-gene correlation(EGC)
system("perl getEGC.pl");

#get the feature of gene score(GS)
system("perl getGS.pl ".$GeneExpr);

#get the feature of distance(DIS)
system("perl getDIS.pl");

#get the feature of Enhancer window signal (EWS)
system("perl getEWS.pl");

#get the feature of Enhancer window signal (GWS)
system("perl getGWS.pl");

#get the feature of Enhancer window signal (WEES)
system("perl getWEES.pl");

#get
#system("perl $PATH/Scripts/Preprocess.pl $PATH");

#system("rm -rf Temp");

#perl EAGLE.pl -E inputexample/GM12878_enh.bed -G inputexample/GM12878_gene.txt