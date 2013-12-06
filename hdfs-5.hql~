SELECT aid,rid,timey 
FROM hdfs_file_H Q1
JOIN
(SELECT aid as aid1, MAX(ts) as timey FROM hdfs_file_H WHERE ts<='${hiveconf:time}' GROUP BY aid) Q2
ON
Q1.aid = Q2.aid1
WHERE
Q1.ts = Q2.timey
ORDER by aid
