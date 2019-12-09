$start = time;
use Getopt::Long;
if(@ARGV < 1){
    print "an Enhancer And Gene based Learning Ensembl mothod for prediction of enhancer-gene pairs\n";
    print " Usage:perl EAGLE.pl -E <Enhancer profile> -G <Gene Expression> -S <Species>\n";
    print " Example:perl EAGLE.pl -E inputexample/cell_enh.bed -G inputexample/cell_gene.txt\n";
    exit;
}

GetOptions('E=s'=>\$Enh, 'G=s'=>\$GeneExpr, 'S=s'=>\$Species);
mkdir("./Temp");

print "-normalizing the input enhancers......\n";	
#Enhancer input normalization
system("perl ./enhancerinfo/getEnhancer.pl ".$Enh." ".$Species);

print "-Extracting the 100 Mb regions upstream/downstream TSS of the input genes......\n";
#get the 100 Mb regions upstream/downstream TSS
system("perl ./geneinfo/GetRegionNearTSS.pl ".$GeneExpr." ".$Species);

print "-Calculating the correlations of input enhancers and genes......\n";
#get the enhancer-gene correlation(EGC)
system("perl ./getEGC.pl");

print "-Setting the feature: Gene Scores......\n";
#get the feature of gene score(GS)
system("perl ./getGS.pl ".$GeneExpr);

print "-Setting the feature: Distances between enhancer and gene......\n";
#get the feature of distance(DIS)
system("perl ./getDIS.pl");

print "-Setting the feature: Enhancer Window Signals......\n";
#get the feature of Enhancer window signal (EWS)
system("perl ./getEWS.pl");

print "-Setting the feature: Gene Window Signals......\n";
#get the feature of Gene window signal (GWS)
system("perl ./getGWS.pl");

print "-Setting the feature: Weights of Enhancer-Enhancer Correlations......\n";
#get the feature of Weight of enhancer-enhancer correlations
system("perl ./getWEEC.pl");

print "-Combining all the features......\n";
#combining all features
system("perl ./combination.pl");


print "Running the final predictor......\n";
#run matlab
if($Species eq "mouse"){
system("matlab -nosplash -nodesktop -minimize -r predictor_mouse");
}else{
system("matlab -nosplash -nodesktop -minimize -r predictor");
}
sleep(12);


system("rm -rf Temp");

##perl EAGLE.pl -E inputexample/cell_enh.bed -G inputexample/cell_gene.txt -S human
##for mouse:perl EAGLE.pl -E inputexample/mouse_cell_enh.bed -G inputexample/mouse_cell_gene.txt -S mouse
#	