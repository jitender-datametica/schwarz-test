select * from 
(
SELECT system_id, 
name, 
source_id, 
email, 
supplier_debitorennummer, 
valid_from, 
valid_to, 
update_timestamp, 
content_hash, 
deletion_id 
FROM public.supplier_2
union all
SELECT a.system_id, 
a.name, 
a.source_id, 
a.email, 
a.supplier_debitorennummer, 
a.valid_to as valid_from, 
'7777-12-31' as valid_to, 
a.update_timestamp, 
a.content_hash, 
a.deletion_id 
FROM public.supplier_2 a
	 inner join (
        select system_id, max(valid_from) valid_from
        FROM public.supplier_2
        group by 1) b
on a.system_id = b.system_id
and a.valid_from = b.valid_from
where valid_to is not null
) subquery
WHERE coalesce(update_timestamp, to_timestamp('1900-01-01 9:30:20','YYYY-MM_2-DD HH:MI:SS')) > to_timestamp('${SQL_DELTA_POSTGRES}','YYYY-MM_2-DD HH24:MI:SS.MS');
