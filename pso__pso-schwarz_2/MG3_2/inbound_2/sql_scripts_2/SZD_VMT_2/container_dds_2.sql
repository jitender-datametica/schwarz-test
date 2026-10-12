SELECT 
container_relation_id,
"type" as container_dds_type, 
status_2, 
cost_level, 
free_time, 
violated_days, 
valid_from, 
valid_to, 
update_timestamp, 
content_hash 
FROM container_dds
WHERE coalesce(update_timestamp, to_timestamp('1900-01-01 9:30:20','YYYY-MM_2-DD HH:MI:SS')) > to_timestamp('${SQL_DELTA_POSTGRES}','YYYY-MM_2-DD HH24:MI:SS.MS');
