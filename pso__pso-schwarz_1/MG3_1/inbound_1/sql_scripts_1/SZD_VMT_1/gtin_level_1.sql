select * from 
(
SELECT system_id, 
destination_relation_id, 
lot_relation_id, 
country_code, 
uuid, 
gtin, 
type as gtin_level_type, 
shipped_cartons, 
pieces_per_carton, 
length, 
width, 
height, 
net_weight, 
gross_weight, 
valid_from, 
valid_to, 
update_timestamp, 
content_hash, 
variant_position 
FROM public.gtin_level
union all
SELECT a.system_id, 
a.destination_relation_id, 
a.lot_relation_id, 
a.country_code, 
a.uuid, 
a.gtin, 
a.type as gtin_level_type, 
a.shipped_cartons, 
a.pieces_per_carton, 
a.length, 
a.width, 
a.height, 
a.net_weight, 
a.gross_weight, 
a.valid_to as valid_from, 
'7777-12-31' as valid_to, 
a.update_timestamp, 
a.content_hash, 
a.variant_position 
FROM public.gtin_level a
	 inner join (
        select system_id, max(valid_from) valid_from
        FROM public.gtin_level
        group by 1) b
on a.system_id = b.system_id
and a.valid_from = b.valid_from
where valid_to is not null
) subquery
WHERE coalesce(update_timestamp, to_timestamp('1900-01-01 9:30:20','YYYY-MM_1-DD HH:MI:SS')) > to_timestamp('${SQL_DELTA_POSTGRES}','YYYY-MM_1-DD HH24:MI:SS.MS');
