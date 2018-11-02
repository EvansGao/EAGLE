use List::MoreUtils qw(uniq);
use List::Util qw(min max sum);
mkdir("EWS");
system("bedtools intersect -a ./Temp/gene/genesinfo.bed -b ./Temp/enhancer/cellenhs.bed -wa -wb>cellEnhGeneSigPre.bed");
open ENHGENE,"cellEnhGeneSigPre.bed";
open WINDOW,">cellEnhGeneWindowpre.bed";
@pairs=();
%hashpairtoLength=();
while(<ENHGENE>){
chomp($_);
@temp=split/\t/,$_;
$pair=$temp[4].":".$temp[5]."-".$temp[6]."_".$temp[3];
push @pairs,$pair;
$TSS=$temp[3]-1000000;
	if($TSS<$temp[5]){
	print WINDOW $temp[4]."\t".$TSS."\t".$temp[5]."\t".$pair."\n";
	$hashpairtoLength{$pair}=$temp[5]-$hashgenetoTSS{$temp[3]};
	$hashpairtoLength{$pair}=$temp[5]-$TSS;
	}elsif($TSS>$temp[6]){
	print WINDOW $temp[4]."\t".$temp[6]."\t".$TSS."\t".$pair."\n";
	$hashpairtoLength{$pair}=$TSS-$temp[6];
	}
}
close ENHGENE;
unlink("cellEnhGeneSigPre.bed");
close WINDOW;
system("bedtools sort -i cellEnhGeneWindowpre.bed>cellEnhGeneWindow.bed");
system("bedtools intersect -a cellEnhGeneWindow.bed -b ./Temp/enhancer/cellenhs.bed -wa -wb>cellEnhGeneWindowInEnh.bed");
open WINDOWENH,"cellEnhGeneWindowInEnh.bed";
%hashWindowInEnh=();
while(<WINDOWENH>){
chomp($_);
@temp=split/\t/,$_;
if(!exists $hashWindowInEnh{$temp[3]}){
$hashWindowInEnh{$temp[3]}=($temp[6]-$temp[5])*$temp[7];
}else{
$hashWindowInEnh{$temp[3]}+=($temp[6]-$temp[5])*$temp[7];
}
}
close WINDOWENH;




open FILE,$genefile;
%hashcellgeneTosig=();
while(<FILE>){
chomp($_);
@temp=split/\t/,$_;
if($temp[0]=~ /ENSG/){
$hashcellgeneTosig{$temp[0]}=$temp[1];
}
}
close FILE;
system("bedtools intersect -a allcellenhsmerge2500.bed -b /data8/gts/mouse/allcells/".$cell."/".$cell."NOCTCF.bed -wa -wb>allcellenhspre_".$cell.".bed");


system("bedtools intersect -a ./Temp/gene/genesinfo.bed -b ./Temp/enhancer/cellenhs.bed -wa -wb>./Temp/PairsPre.bed");
open GS,"./Temp/PairsPre.bed";
open CELLGS,">./GS/GS.bed";
@pairs=();
while(<GS>){
chomp($_);
@temp=split/\t/,$_;
$pair=$temp[4].":".$temp[5]."-".$temp[6]."_".$temp[3];
@genescoreinfo=split/\$/,$temp[3];
print CELLGS $pair."\t".$hashcellgeneTosig{$genescoreinfo[0]}."\n";

}
close GS;
close CELLGS;
