-- Load input file from HDFS (like create table with table name as line create table line())
inputFile = LOAD 'hdfs:///user/preeti/input.txt' AS (line:chararray);
-- Tokeize each word in the file (Map)(TOKENIZE create individual string, FLATTEN created a tuple of string for each line)
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Combine the words from the above stage creates columns by default as $0,$1...
grpd = GROUP words BY word;
-- Count the occurence of each word (Reduce)
cntd = FOREACH grpd GENERATE $0 as word, COUNT($1) as wordCount;
-- Remove folder for re-execution
rmf hdfs:///user/preeti/pigOutput1;
-- Store the result in HDFS(pigOutput1 folder is created)
STORE cntd INTO 'hdfs:///user/preeti/pigOutput1';