use List::MoreUtils qw(uniq);
use List::Util qw(min max sum);
$genefile=$ARGV[0];
$species=$ARGV[1];

open FILE,$genefile;
%hashcellgeneTosig=();
while(<FILE>){
chomp($_);
@temp=split/\t/,$_;
if($temp[0]=~ /ENSG|ENSMUSG/){
$hashcellgeneTosig{$temp[0]}=$temp[1];
}
}
close FILE;

$genereffile="";
if($species eq "mouse"){
$genereffile="mouse_ensembl.txt";
}else{
$genereffile="human_ensembl.txt";
}

open GENE,"./geneinfo/".$genereffile;
open CELLGENE,">./Temp/gene/genesigPre.bed";
@genes=();
%hashgenetochr=();
%hashgenetoTSS=();
%hashgenetogenename=();
%hashgenetostrand=();
while(<GENE>){
chomp($_);
@temp=split/\t/,$_;
if(!exists $hashgenetogenename{$temp[0]} && exists $hashcellgeneTosig{$temp[0]} && !($temp[1]=~ /_/)){
$hashgenetogenename{$temp[0]}=$temp[6];
print CELLGENE "chr".$temp[1]."\t".$temp[2]."\t".$temp[3]."\t".$hashcellgeneTosig{$temp[0]}."\n";
push @genes,$temp[0];
$hashgenetochr{$temp[0]}="chr".$temp[1];
if($temp[5] eq "1"){
$hashgenetoTSS{$temp[0]}=$temp[2];
$hashgenetostrand{$temp[0]}="+";
}elsif($temp[5] eq "-1"){
$hashgenetoTSS{$temp[0]}=$temp[3];
$hashgenetostrand{$temp[0]}="-";
}
}
}
close GENE;
close CELLGENE;

system("bedtools sort -i ./Temp/gene/genesigPre.bed>./Temp/gene/genesig.bed");
unlink("./Temp/gene/genesigPre.bed");

open GENEREG,">./Temp/gene/genesinfopre.bed";
foreach $gene (@genes){
print GENEREG $hashgenetochr{$gene}."\t".max(1,$hashgenetoTSS{$gene}-1000000)."\t".($hashgenetoTSS{$gene}+1000000)."\t".$gene."\$".$hashgenetogenename{$gene}."\$".$hashgenetochr{$gene}."\$".$hashgenetoTSS{$gene}."\$".$hashgenetostrand{$gene}."\n";
}
close GENEREG;
system("bedtools sort -i ./Temp/gene/genesinfopre.bed>./Temp/gene/genesinfo.bed");
unlink("./Temp/gene/genesinfopre.bed");

