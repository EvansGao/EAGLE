use List::MoreUtils qw(uniq);
use List::Util qw(min max sum);
mkdir("GWS");
system("bedtools intersect -a cellEnhGeneWindow.bed -b ./Temp/gene/genesig.bed -wa -wb>cellEnhGeneWindowInGene.bed");
open WINDOWGENE,"cellEnhGeneWindowInGene.bed";
%hashWindowInGene=();
%hashpairtoLength=();
@pairs=();
while(<WINDOWGENE>){
chomp($_);
@temp=split/\t/,$_;
if(!exists $hashWindowInGene{$temp[3]}){
$hashWindowInGene{$temp[3]}=($temp[6]-$temp[5])*$temp[7];
$hashpairtoLength{$temp[3]}=$temp[2]-$temp[1];
push @pairs,$temp[3];
}else{
$hashWindowInGene{$temp[3]}+=($temp[6]-$temp[5])*$temp[7];
}
}
close WINDOWGENE;

open GWS,">GWS/GWS.bed";
	foreach $pair (@pairs){
		if(!exists $hashWindowInGene{$pair}){
		$hashWindowInGene{$pair}=0;
		}
		if(exists $hashpairtoLength{$pair}){
		print GWS $pair."\t".($hashWindowInGene{$pair}/$hashpairtoLength{$pair})."\n";
		}
	}
close GWS;
