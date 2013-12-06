SELECT aid, COUNT(rid) as numrevs 
FROM hdfs_file_H 
WHERE type='REVISION' 
AND ts >='${hiveconf:start_date}' 
AND ts <='${hiveconf:end_date}' 
GROUP BY aid
ORDER BY numrevs DESC,aid ASC
LIMIT ${hiveconf:numdisplay}
