select  * from
(
select system_id, 
"name", 
source_id, 
valid_from, 
valid_to, 
update_timestamp, 
content_hash 
FROM public.booker
union all 
select a.system_id, 
a."name", 
a.source_id, 
a.valid_to as valid_from, 
'7777-12-31' as valid_to,
a.update_timestamp, 
a.content_hash 
FROM public.booker a
	inner join (
		select system_id, max(valid_from) valid_from
		FROM public.booker
		group by 1) b
on a.system_id = b.system_id
and a.valid_from = b.valid_from
where valid_to is not null
) subquery
where coalesce(update_timestamp, to_timestamp('1900-01-01 9:30:20','YYYY-MM_1-DD HH:MI:SS')) > to_timestamp('${SQL_DELTA_POSTGRES}','YYYY-MM_1-DD HH24:MI:SS.MS')
;
