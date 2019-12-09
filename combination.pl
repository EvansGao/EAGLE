open AA,"./Temp/pair/PairsStandard.bed";
%hashpair=();
@allpairs=();
while(<AA>){
chomp($_);
if($_ ne ""){
$hashpair{$_}="";
push @allpairs,$_;
}
}
close AA;

open EGC,"./EGC/EGC.bed";
while(<EGC>){
chomp($_);
@temp=split/\t/,$_;
if(exists $hashpair{$temp[0]}){
$hashpair{$temp[0]}.="\t".$temp[1];
}else{
$hashpair{$temp[0]}.="\t"."0";
}
}
close EGC;

open GS,"./GS/GS.bed";
while(<GS>){
chomp($_);
@temp=split/\t/,$_;
if(exists $hashpair{$temp[0]}){
$hashpair{$temp[0]}.="\t".$temp[1];
}else{
$hashpair{$temp[0]}.="\t"."0";
}
}
close GS;

open DIS,"./DIS/DIS.bed";
while(<DIS>){
chomp($_);
@temp=split/\t/,$_;
if(exists $hashpair{$temp[0]}){
$hashpair{$temp[0]}.="\t".$temp[1];
}else{
$hashpair{$temp[0]}.="\t"."0";
}
}
close DIS;

open EWS,"./EWS/EWS.bed";
while(<EWS>){
chomp($_);
@temp=split/\t/,$_;
if(exists $hashpair{$temp[0]}){
$hashpair{$temp[0]}.="\t".$temp[1];
}else{
$hashpair{$temp[0]}.="\t"."0";
}
}
close EWS;

open GWS,"./GWS/GWS.bed";
while(<GWS>){
chomp($_);
@temp=split/\t/,$_;
if(exists $hashpair{$temp[0]}){
$hashpair{$temp[0]}.="\t".$temp[1];
}else{
$hashpair{$temp[0]}.="\t"."0";
}
}
close GWS;

open WEEC,"./WEEC/WEEC.bed";
while(<WEEC>){
chomp($_);
@temp=split/\t/,$_;
if(exists $hashpair{$temp[0]}){
$hashpair{$temp[0]}.="\t".$temp[1];
}else{
$hashpair{$temp[0]}.="\t"."0";
}
}
close WEEC;

mkdir("Temp/res");
open ALL,">./Temp/res/pairres.bed";
foreach $pair (@allpairs){
print ALL $pair."\t".$hashpair{$pair}."\n";
}
close ALL;