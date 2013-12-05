SELECT aid,rid,timey 
FROM hdfs_file_H Q1, (SELECT aid, MAX(ts) as timey FROM hdfs_file_H WHERE ts<='${hiveconf:time}' GROUP BY aid) Q2
WHERE 
Q1.aid = Q2.aid;
