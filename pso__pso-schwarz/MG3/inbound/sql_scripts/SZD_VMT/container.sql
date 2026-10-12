select * from
( 
SELECT 
system_id, 
"number", 
seal_number, 
iso_type, 
contains_spare_units, 
contains_spare_parts, 
has_gas_filling, 
export_state_p1, 
export_date_p1, 
export_state_p2, 
export_date_p2, 
export_state_p3, 
export_date_p3, 
export_state_p4, 
export_date_p4, 
teu, 
valid_from, 
valid_to, 
update_timestamp, 
content_hash 
FROM public.container
union all
SELECT 
a.system_id, 
a."number", 
a.seal_number, 
a.iso_type, 
a.contains_spare_units, 
a.contains_spare_parts, 
a.has_gas_filling, 
a.export_state_p1, 
a.export_date_p1, 
a.export_state_p2, 
a.export_date_p2, 
a.export_state_p3, 
a.export_date_p3, 
a.export_state_p4, 
a.export_date_p4, 
a.teu, 
a.valid_to as valid_from, 
'7777-12-31' as valid_to, 
a.update_timestamp, 
a.content_hash 
FROM public.container a
        inner join (
		select system_id, max(valid_from) valid_from
		FROM public.container
		group by 1) b
on a.system_id = b.system_id
and a.valid_from = b.valid_from
where valid_to is not null
) subquery
WHERE coalesce(update_timestamp, to_timestamp('1900-01-01 9:30:20','YYYY-MM-DD HH:MI:SS')) > to_timestamp('${SQL_DELTA_POSTGRES}','YYYY-MM-DD HH24:MI:SS.MS');
