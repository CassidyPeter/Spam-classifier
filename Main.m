load('spamTrain.mat');
load('spamTest.mat');
model = fitcsvm(Xtrain,ytrain);
trainingPred = predict(model, Xtrain);
fprintf('Training Accuracy: %f\n', mean(double(trainingPred == ytrain)) * 100);
testPred = predict(model, Xtest);
fprintf('Test Accuracy: %f\n', mean(double(testPred == ytest)) * 100);

%Test cases
sample1 = readFile('spamSample1.txt');
sample2 = readFile('spamSample2.txt');
sample3 = readFile('spamSample3.txt');
sample4 = readFile('nonSpamEmail.txt');
sample1pred = predict(model, emailFeatures(processEmail(sample1))') %spam
sample2pred = predict(model, emailFeatures(processEmail(sample2))') %spam
sample3pred = predict(model, emailFeatures(processEmail(sample3))') %spam
sample4pred = predict(model, emailFeatures(processEmail(sample4))') %not-spam (ham)

%Top predictors of spam
[weight, idx] = sort(model.Beta, 'descend');
vocabList = getVocabList();
for i=1:20
  if i==1
    fprintf('Top predictors of spam: \n');
  end
  fprintf('%-15s (%f) \n', vocabList{idx(i)}, weight(i));
end

