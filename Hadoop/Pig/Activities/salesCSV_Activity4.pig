-- Load the CSV file
salesTable = LOAD 'hdfs:///user/0039DD744/sales.csv' USING PigStorage(',') AS (Product:chararray,Price:chararray,Payment_Type:chararray,Name:chararray,City:chararray,State:chararray,Country:chararray);
-- Group data using the country column
GroupByCountry = GROUP salesTable BY Country;
-- Generate result format
CountByCountry = FOREACH GroupByCountry GENERATE CONCAT((chararray)$0, CONCAT(':', (chararray)COUNT($1)));
-- To remove old output folder
rmf hdfs:///user/0039DD744/activity4_result;
-- Save result in HDFS folder
STORE CountByCountry INTO 'hdfs:///user/0039DD744/activity4_result' USING PigStorage(',');
