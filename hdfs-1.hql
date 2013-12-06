DROP TABLE IF EXISTS hdfs_file_H;
CREATE EXTERNAL TABLE hdfs_file_H(type STRING, aid BIGINT, rid BIGINT, title STRING, ts STRING, uname STRING, uid STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ' ' STORED AS TEXTFILE LOCATION '/user/bd4-project1/enwiki-20080103-sample';

SELECT aid,rid,ts
FROM hdfs_file_H 
WHERE type='REVISION' 
AND ts >='${hiveconf:start_date}' 
AND ts <='${hiveconf:end_date}' 
ORDER BY aid,rid;
