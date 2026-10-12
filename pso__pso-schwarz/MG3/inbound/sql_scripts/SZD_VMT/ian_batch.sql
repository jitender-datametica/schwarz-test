select * from
( 
SELECT 
system_id, 
ian, 
batch, 
item_description, 
division, 
incoterms, 
item_hs_code, 
valid_from, 
valid_to, 
update_timestamp, 
content_hash 
FROM public.ian_batch
union all
SELECT 
a.system_id, 
a.ian, 
a.batch, 
a.item_description, 
a.division, 
a.incoterms, 
a.item_hs_code, 
a.valid_to as valid_from, 
'7777-12-31' as valid_to, 
a.update_timestamp, 
a.content_hash 
FROM public.ian_batch a
inner join (
        select system_id, max(valid_from) valid_from
        FROM public.ian_batch
        group by 1) b
on a.system_id = b.system_id
and a.valid_from = b.valid_from
where valid_to is not null
) subquery
WHERE coalesce(update_timestamp, to_timestamp('1900-01-01 9:30:20','YYYY-MM-DD HH:MI:SS')) > to_timestamp('${SQL_DELTA_POSTGRES}','YYYY-MM-DD HH24:MI:SS.MS');
