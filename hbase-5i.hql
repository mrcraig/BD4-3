ADD JAR hadoop-snapshot/lib/zookeeper-3.4.5-cdh4.4.0.jar;
ADD JAR hadoop-snapshot/lib/hbase-0.94.6-cdh4.4.0-security.jar;
ADD JAR hadoop-snapshot/lib/hive-hbase-handler-0.10.0-cdh4.4.0.jar;
ADD JAR UDF.jar;

CREATE TEMPORARY FUNCTION get_aid as 'com.UDF.AIDUDF';
CREATE TEMPORARY FUNCTION get_rid as 'com.UDF.RIDUDF';
CREATE TEMPORARY FUNCTION get_ts as 'com.UDF.TSUDF';


SELECT aidy,rid,timex
FROM  (SELECT get_aid(key) as aidy, get_rid(key) as rid, get_ts(ts) as timex FROM hbase_table_H) Q1
JOIN
(SELECT get_aid(key) as aid1, MAX(get_ts(ts)) as timey FROM hbase_table_H WHERE get_ts(ts)<='${hiveconf:time}' GROUP BY get_aid(key)) Q2
ON
Q1.aidy = Q2.aid1
WHERE
Q1.timex = Q2.timey
ORDER by aidy;