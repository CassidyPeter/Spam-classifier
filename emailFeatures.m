function x = emailFeatures(word_indices)
%Takes in a word_indices vector and produces a feature vector from the
%word_indices list
n = 1899;
x = zeros(n,1);
x(word_indices) = 1;
end
