use List::MoreUtils qw(uniq);
use List::Util qw(min max sum);
$enhfile=$ARGV[0];
$species=$ARGV[1];

$allenhs="";
if($species eq "mouse"){
$allenhs="allenhsmouse.bed";
}else{
$allenhs="allenhs.bed";
}

mkdir("./Temp/enhancer");

system("bedtools intersect -a ./enhancerinfo/$allenhs -b ./".$enhfile." -wa -wb>./Temp/enhancer/cellenhspre.bed");
	@tempenhs=();
	%hashtempenh=();
	open CELLENH,"./Temp/enhancer/cellenhspre.bed";
	while(<CELLENH>){
	chomp($_);
	@temp=split/\t/,$_;
	if(!exists $hashtempenh{$temp[0]."\t".$temp[1]."\t".$temp[2]}){
	$hashtempenh{$temp[0]."\t".$temp[1]."\t".$temp[2]}=$temp[7];
	push @tempenhs,$temp[0]."\t".$temp[1]."\t".$temp[2];
	}elsif(exists $hashtempenh{$temp[0]."\t".$temp[1]."\t".$temp[2]} && $hashtempenh{$temp[0]."\t".$temp[1]."\t".$temp[2]}<$temp[7]){
	$hashtempenh{$temp[0]."\t".$temp[1]."\t".$temp[2]}=$temp[7];
	}
	}
	close CELLENH;
	open CELLSTANDARD,">./Temp/enhancer/cellenhs.bed";
	foreach $enh (@tempenhs){
	print CELLSTANDARD $enh."\t".$hashtempenh{$enh}."\n";
	}
	close CELLSTANDARD;
