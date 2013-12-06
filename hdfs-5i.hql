DROP TABLE IF EXISTS hdfs_file_Hi;
CREATE EXTERNAL TABLE hdfs_file_Hi(ts STRING, aid BIGINT, rid BIGINT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION '/user/1002386c/index';

SELECT aid,rid,timey 
FROM hdfs_file_Hi Q1
JOIN
(SELECT aid as aid1, MAX(ts) as timey FROM hdfs_file_Hi WHERE ts<='${hiveconf:time}' GROUP BY aid) Q2
ON
Q1.aid = Q2.aid1
WHERE
Q1.ts = Q2.timey
ORDER by aid;
