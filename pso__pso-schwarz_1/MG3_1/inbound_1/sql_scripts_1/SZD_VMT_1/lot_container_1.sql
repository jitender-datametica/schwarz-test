SELECT lot_relation_id, 
container_relation_id, 
valid_from, 
valid_to, 
update_timestamp, 
content_hash 
FROM public.lot_container
WHERE coalesce(update_timestamp, to_timestamp('1900-01-01 9:30:20','YYYY-MM_1-DD HH:MI:SS')) > to_timestamp('${SQL_DELTA_POSTGRES}','YYYY-MM_1-DD HH24:MI:SS.MS');
