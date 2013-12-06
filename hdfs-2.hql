SELECT aid, COUNT(rid), sort_array(collect_set(rid))
FROM hdfs_file_H 
WHERE type='REVISION' 
AND ts >='${hiveconf:start_date}' 
AND ts <='${hiveconf:end_date}' 
GROUP BY aid
ORDER BY aid;
