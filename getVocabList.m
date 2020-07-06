function vocabList = getVocabList()
vlist = fopen('vocab.txt');
n = 1899; %Hard coded number of words in dict
vocabList = cell(n,1);
for i=1:n
    fscanf(vlist, '%d', 1);
    vocabList{i} = fscanf(vlist, '%s', 1);
end
fclose(vlist);
end
