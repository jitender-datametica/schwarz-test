SELECT system_id, 
container_relation_id, 
gtin_relation_id, 
shipped_quantity, 
valid_from, 
valid_to, 
update_timestamp, 
content_hash 
FROM public.shipped_country_blocks
WHERE coalesce(update_timestamp, to_timestamp('1900-01-01 9:30:20','YYYY-MM-DD HH:MI:SS')) > to_timestamp('${SQL_DELTA_POSTGRES}','YYYY-MM-DD HH24:MI:SS.MS');
