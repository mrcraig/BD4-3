DROP TABLE IF EXISTS hdfs_file_Hi;
CREATE EXTERNAL TABLE hdfs_file_Hi(ts STRING, aid BIGINT, rid BIGINT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION '/user/1002386c/index';

SELECT aid, COUNT(rid) as numrevs 
FROM hdfs_file_Hi 
WHERE ts >='${hiveconf:start_date}' 
AND ts <='${hiveconf:end_date}' 
GROUP BY aid
HAVING numrevs>='${hiveconf:numrevs}'
ORDER BY aid;
