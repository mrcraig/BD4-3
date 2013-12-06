ADD JAR hadoop-snapshot/lib/zookeeper-3.4.5-cdh4.4.0.jar;
ADD JAR hadoop-snapshot/lib/hbase-0.94.6-cdh4.4.0-security.jar;
ADD JAR hadoop-snapshot/lib/hive-hbase-handler-0.10.0-cdh4.4.0.jar;
ADD JAR UDFIndex.jar;

CREATE TEMPORARY FUNCTION get_aid as 'com.UDF.AIDUDF';
CREATE TEMPORARY FUNCTION get_rid as 'com.UDF.RIDUDF';
CREATE TEMPORARY FUNCTION get_ts as 'com.UDF.TSUDF';

DROP TABLE IF EXISTS hbase_table_Hi;
CREATE EXTERNAL TABLE hbase_table_Hi(key BINARY, artid BINARY, revid BINARY) STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler' WITH SERDEPROPERTIES ("hbase.columns.mapping" = ":key,q1:in_artid,q1:in_revid") TBLPROPERTIES ("hbase.table.name" = "1002386c");


SELECT aidy,rid,timex
FROM  (SELECT get_aid(artid) as aidy, get_rid(revid) as rid, get_ts(key) as timex FROM hbase_table_Hi) Q1
JOIN
(SELECT get_aid(artid) as aid1, MAX(get_ts(key)) as timey FROM hbase_table_Hi WHERE get_ts(key)<='${hiveconf:time}' GROUP BY get_aid(artid)) Q2
ON
Q1.aidy = Q2.aid1
WHERE
Q1.timex = Q2.timey
ORDER by aidy;
