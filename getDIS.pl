use List::MoreUtils qw(uniq);
use List::Util qw(min max sum);
mkdir("DIS");
open PAIR,"./Temp/pair/Pairs.bed";
open CELLDIS,">./DIS/DIS.bed";
@pairs=();
while(<PAIR>){
chomp($_);
@temp=split/\t/,$_;
$pair=$temp[4].":".$temp[5]."-".$temp[6]."_".$temp[3];
@geneinfo=split/\$/,$temp[3];
if($geneinfo[3]<$temp[5]){
$dis=$temp[5]-$geneinfo[3];
}elsif($geneinfo[3]>=$temp[5] && $geneinfo[3]<$temp[6]){
$dis=0;
}elsif($geneinfo[3]>$temp[6]){
$dis=$geneinfo[3]-$temp[6];
}
print CELLDIS $pair."\t".$dis."\n";

}
close PAIR;
close CELLDIS;