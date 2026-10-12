select * from 
(
SELECT system_id, 
short_name, 
nominated_fpol_price_group, 
name, 
country_2, 
city, 
valid_from, 
valid_to, 
update_timestamp, 
content_hash, 
deletion_id 
FROM public.fpol
union all
SELECT a.system_id, 
a.short_name, 
a.nominated_fpol_price_group, 
a.name, 
a.country_2, 
a.city, 
a.valid_to as valid_from, 
'7777-12-31' as valid_to, 
a.update_timestamp, 
a.content_hash, 
a.deletion_id 
FROM public.fpol a
	 inner join (
        select system_id, max(valid_from) valid_from
        FROM public.fpol
        group by 1) b
on a.system_id = b.system_id
and a.valid_from = b.valid_from
where valid_to is not null
) subquery
WHERE coalesce(update_timestamp, to_timestamp('1900-01-01 9:30:20','YYYY-MM_2-DD HH:MI:SS')) > to_timestamp('${SQL_DELTA_POSTGRES}','YYYY-MM_2-DD HH24:MI:SS.MS');
