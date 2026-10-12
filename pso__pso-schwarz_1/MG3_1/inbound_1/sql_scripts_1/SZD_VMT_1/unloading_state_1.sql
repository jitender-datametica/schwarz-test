SELECT 
system_id,
lot_relation_id,
container_relation_id,
loaded_cartons,
unloaded_cartons,
damaged_cartons,
sample_cartons,
event_timestamp,
deletion_id,
content_hash
FROM public.unloading_state
WHERE coalesce(event_timestamp, to_timestamp('1900-01-01 9:30:20','YYYY-MM_1-DD HH:MI:SS')) > to_timestamp('${SQL_DELTA_POSTGRES}','YYYY-MM_1-DD HH24:MI:SS.MS');
