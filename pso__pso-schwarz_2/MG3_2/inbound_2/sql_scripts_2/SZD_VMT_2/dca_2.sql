select * from 
(
SELECT system_id, 
name, 
valid_from, 
valid_to, 
update_timestamp, 
content_hash, 
deletion_id 
FROM public.dca
union all
SELECT a.system_id, 
a.name, 
a.valid_to as valid_from, 
'7777-12-31' as valid_to, 
a.update_timestamp, 
a.content_hash, 
a.deletion_id 
FROM public.dca a
	 inner join (
        select system_id, max(valid_from) valid_from
        FROM public.dca
        group by 1) b
on a.system_id = b.system_id
and a.valid_from = b.valid_from
where valid_to is not null
) subquery
WHERE coalesce(update_timestamp, to_timestamp('1900-01-01 9:30:20','YYYY-MM_2-DD HH:MI:SS')) > to_timestamp('${SQL_DELTA_POSTGRES}','YYYY-MM_2-DD HH24:MI:SS.MS');
