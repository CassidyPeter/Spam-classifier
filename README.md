# Spam-classifier
A spam classifier using SVM, written in MATLAB as part of Andrew Ng's Machine Learning Course

Repository contents:

 - buildDataset.m - Takes 5796 raw emails consisting of spam and non-spam (ham) {32% spam ratio} from SpamAssassin's PublicCorpus, processes them, and then converts them into a feature vector based on occurrence of top spam predictive words. Dataset is then randomised and split into training set and test set 80/20.
 - readFile.m - Takes .txt file and reads it into a character vector inc. white space.
 - processEmail.m - Pre-processes the individual emails by removing HTML content and converting non-words (numbers, web addresses, email addresses, currencies, etc) to descriptive words. Emails are then processed: tokenized using whitespace & punctuation, non-alphanumeric characters removed, words stemmed, and then compared to a list of top spam predictive words to produce a vector of word indices.
 - emailFeatures.m - Takes vector of word indices and produces feature vector.
 - Main.m - Loads dataset previously created in buildDataset.m, then trains Support Vector Machine model using Xtrain (feature vectors for each email) and ytrain (class labels vector, 0=ham 1=spam). Model is then tested by predicting labels for Xtest and ytest, and outputs a test accuracy. Difficult test cases are classified using the trained model)
 
 - vocab.txt - List of top spam predictive words, refined from finding highest weights of the model. Original vocab list consisted of high frequency words occuring in spam dataset.
 - spamTrain.mat - Training dataset compiled in buildDataset.m, containing Xtrain and ytrain.
 - spamTest.mat - Testing dataset compiled in buildDataset.m, containing Xtest and ytest.
