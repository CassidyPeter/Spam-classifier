function word_indices = processEmail(email_contents)
vocabList = getVocabList();

word_indices = [];

%----------Preprocessing----------
email_contents = lower(email_contents);
%Remove all HTML content by searching for <> tags
email_contents = regexprep(email_contents, '<[^<>]+>', ' ');
%Convert one or more concurrent numbers to 'number'
email_contents = regexprep(email_contents, '[0-9]+', 'number');
%Look for address starting with http:// or https://
email_contents = regexprep(email_contents, '(http|https)://[^\s]*', 'httpaddr');
%Look for email addresses containing @
email_contents = regexprep(email_contents, '[^\s]+@[^\s]+', 'emailaddr');
%Handle currency
email_contents = regexprep(email_contents, '[£]+', 'pound');
email_contents = regexprep(email_contents, '[$]+', 'dollar');
email_contents = regexprep(email_contents, '[€]+', 'euro');

%------------Processing------------
l=0; %Word counter for output printing later
fprintf('\n------ Processed Email ------\n\n');

while ~isempty(email_contents)
    
    %Tokenise using punctuation + whitespace delimiters (using char with ascii for '')
    [str, email_contents] = strtok(email_contents, [' @$/#.-:&*+=[]?!(){},''">_<;%' char(10) char(13)]);
    
    %Remove anything not a-z A-Z 0-9 (alphanumeric)
    str = regexprep(str, '[^a-zA-Z0-9]', '');
    
    %Stem the word with text analytics toolbox
    str = normalizeWords(str);
    
    if length(str) < 1
        continue;
    end
    
    %Look up word in vocab list dict and add to word_indices if found
    for i=1:length(vocabList)
        if strcmp(str, vocabList{i}) == 1
            word_indices = [word_indices ; i];
        end
    end
    
    %Printing to stop output lines being too long
    if (l + length(str) + 1) > 78
        fprintf('\n');
        l=0;
    end
    fprintf('%s ', str);
    l = l + length(str) + 1;
end
fprintf('\n\n---------------------------\n');
end

    
    