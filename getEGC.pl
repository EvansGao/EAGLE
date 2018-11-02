use List::MoreUtils qw(uniq);
use List::Util qw(min max sum);
use List::MoreUtils qw(uniq);
mkdir("EGC");
mkdir("Temp/pair");
system("bedtools intersect -a ./Temp/gene/genesinfo.bed -b ./Temp/enhancer/cellenhs.bed -wa -wb>./Temp/pair/Pairs.bed");
open CORR,"AllgenesenhspairsScore.bed";
%hashpaircorrelation=();
while(<CORR>){
chomp($_);
@temp=split/\t/,$_;
if($temp[0] ne ""){
$hashpaircorrelation{$temp[0]}=$temp[1];
}
}
close CORR;
open PAIR,"./Temp/pair/Pairs.bed";
open CELLEGC,">./EGC/EGC.bed";
@pairs=();
while(<PAIR>){
chomp($_);
@temp=split/\t/,$_;
$pair=$temp[4].":".$temp[5]."-".$temp[6]."_".$temp[3];
@genescoreinfo=split/\$/,$temp[3];
if(exists $hashpaircorrelation{$pair}){
print CELLEGC $pair."\t".$hashpaircorrelation{$pair}."\n";
}else{
print CELLEGC $pair."\t"."-1"."\n";
}


}
close PAIR;
close CELLEGC;

