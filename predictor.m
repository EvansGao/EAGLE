load('classificationEnsemble')
fileID=fopen("./Temp/res/pairres.bed");
candidatedata=textscan(fileID,'%s %f %f %f %f %f %f');
Alldata=[candidatedata{2:7}];
[lables,scores]=predict(classificationEnsemble,Alldata);
Results=[candidatedata,scores];
pairs = fopen("predictedResults.txt",'wt');
tempA=cellstr(Results{1,1});
tempB=[Results{8}];
Len=size(tempA,1);
for j = 1:Len
	if tempB(j,1)>=0.5
	fprintf(pairs,'%s\t',tempA{j,1});
	fprintf(pairs,'%f\n',tempB(j,1));
	end
end
fclose(pairs);
exit