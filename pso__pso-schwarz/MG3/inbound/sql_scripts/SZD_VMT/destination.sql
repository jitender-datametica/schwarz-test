select * from
( 
SELECT 
system_id, 
lot_relation_id, 
country_code, 
country, 
delivery_week, 
shifted_delivery_week, 
shipping_mark, 
nominated_total_cartons, 
booked_total_cartons, 
booked_pieces_per_carton, 
net_weight, 
gross_weight, 
length, 
width, 
height, 
nominated_pieces_per_carton, 
valid_from, 
valid_to, 
update_timestamp, 
content_hash 
FROM public.destination
union all
SELECT 
a.system_id, 
a.lot_relation_id, 
a.country_code, 
a.country, 
a.delivery_week, 
a.shifted_delivery_week, 
a.shipping_mark, 
a.nominated_total_cartons, 
a.booked_total_cartons, 
a.booked_pieces_per_carton, 
a.net_weight, 
a.gross_weight, 
a.length, 
a.width, 
a.height, 
a.nominated_pieces_per_carton, 
a.valid_to as valid_from, 
'7777-12-31' as valid_to, 
a.update_timestamp, 
a.content_hash 
FROM public.destination a
        inner join (
		select system_id, max(valid_from) valid_from
		FROM public.destination
		group by 1) b
on a.system_id = b.system_id
and a.valid_from = b.valid_from
where valid_to is not null
) subquery
WHERE coalesce(update_timestamp, to_timestamp('1900-01-01 9:30:20','YYYY-MM-DD HH:MI:SS')) > to_timestamp('${SQL_DELTA_POSTGRES}','YYYY-MM-DD HH24:MI:SS.MS');
