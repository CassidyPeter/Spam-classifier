%=======================================================================
%Script builds dataset of spam/non-spam emails in a training/test split
%=======================================================================
%Data collected from SpamAssassin Public Corpus
%Warning: Script takes up to 6 hours to run

if (exist('spamTrain.mat')==2) & (exist('spamTest.mat')==2)
    fprintf('Dataset already generated (and present in directory), exiting script..... \n');
    return
else

    n = 1899; %Length of vocab list

    %Locate raw data
    spamdir = '/Users/petercassidy/Documents/MATLAB/Spam_classifier/Spam_data/spam';
    hamdir = '/Users/petercassidy/Documents/MATLAB/Spam_classifier/Spam_data/easy_ham';
    spamfiledir = dir(fullfile(spamdir, '*.txt'));
    hamfiledir = dir(fullfile(hamdir, '*.txt'));

    %Predefine arrays
    spamlength = length(spamfiledir);
    hamlength = length(hamfiledir);

    spamX = zeros(spamlength, n);
    spamy = zeros(spamlength, 1);

    hamX = zeros(hamlength, n);
    hamy = zeros(hamlength, 1);

    %Process spam & ham emails and create feature vectors 
    for i = 1:numel(spamfiledir)
        file_name = fullfile(spamdir, spamfiledir(i).name);
        spamX(i, :) = emailFeatures(processEmail(readFile(file_name)))';
        spamy(i, :) = 1;
        fprintf('%d out of %d \n ', i, spamlength);
    end

    for i = 1:numel(hamfiledir)
        file_name = fullfile(hamdir, hamfiledir(i).name);
        hamX(i, :) = emailFeatures(processEmail(readFile(file_name)))';
        hamy(i, :) = 0;
        fprintf('%d out of %d \n ', i, hamlength);
    end

    %Concatonate arrays
    X = [spamX ; hamX];
    y = [spamy ; hamy];

    %Randomise & split data into training and test set 80/20
    [m,k] = size(X);
    PTrain = 0.8;
    idx = randperm(m);
    Xtrain = X(idx(1:round(PTrain*m)),:);
    ytrain = y(idx(1:round(PTrain*m)),:);
    Xtest = X(idx(round(PTrain*m)+1:end),:);
    ytest = y(idx(round(PTrain*m)+1:end),:);

    %Save dataset as .mat
    save('spamTrain.mat', 'Xtrain', 'ytrain');
    save('spamTest.mat', 'Xtest', 'ytest');
end

