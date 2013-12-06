ADD JAR hadoop-snapshot/lib/zookeeper-3.4.5-cdh4.4.0.jar;
ADD JAR hadoop-snapshot/lib/hbase-0.94.6-cdh4.4.0-security.jar;
ADD JAR hadoop-snapshot/lib/hive-hbase-handler-0.10.0-cdh4.4.0.jar;
ADD JAR UDF.jar;

CREATE TEMPORARY FUNCTION get_aid as 'com.UDF.AIDUDF';
CREATE TEMPORARY FUNCTION get_rid as 'com.UDF.RIDUDF';
CREATE TEMPORARY FUNCTION get_ts as 'com.UDF.TSUDF';

SELECT get_aid(key) as aid, COUNT(get_rid(key)) as numrevs 
FROM hbase_table_H 
WHERE 
get_ts(ts) >='${hiveconf:start_date}' 
AND get_ts(ts) <='${hiveconf:end_date}' 
GROUP BY get_aid(key)
ORDER BY numrevs DESC, aid ASC
LIMIT ${hiveconf:numdisplay}
