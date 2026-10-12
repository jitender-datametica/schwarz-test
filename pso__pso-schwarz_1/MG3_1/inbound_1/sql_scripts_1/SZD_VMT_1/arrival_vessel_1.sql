select * from
(
select system_id, 
uuid, 
booked_name, 
arrival_vessel_voyage, 
arrival_vessel_loop, 
valid_from, 
valid_to, 
update_timestamp, 
content_hash
FROM public.arrival_vessel
union all 
select a.system_id, 
a.uuid, 
a.booked_name, 
a.arrival_vessel_voyage, 
a.arrival_vessel_loop, 
a.valid_to as valid_from, 
'7777-12-31' as valid_to,
a.update_timestamp, 
a.content_hash 
from public.arrival_vessel a
	inner join (
		select system_id, max(valid_from) valid_from
		FROM public.arrival_vessel
		group by 1) b
on a.system_id = b.system_id
and a.valid_from = b.valid_from
where valid_to is not null
) subquery
where coalesce(update_timestamp, to_timestamp('1900-01-01 9:30:20','YYYY-MM_1-DD HH:MI:SS')) > to_timestamp('${SQL_DELTA_POSTGRES}','YYYY-MM_1-DD HH24:MI:SS.MS');
