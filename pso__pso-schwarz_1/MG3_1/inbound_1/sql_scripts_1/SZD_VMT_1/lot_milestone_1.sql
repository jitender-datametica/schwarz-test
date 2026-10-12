SELECT lot_relation_id, 
name, 
business_date, 
result as lot_milestone_result, 
result_evaluation, 
done_date, 
due_date, 
update_timestamp, 
event_timestamp, 
content_hash, 
result_date 
FROM public.lot_milestone
WHERE coalesce(update_timestamp, to_timestamp('1900-01-01 9:30:20','YYYY-MM_1-DD HH:MI:SS')) > to_timestamp('${SQL_DELTA_POSTGRES}','YYYY-MM_1-DD HH24:MI:SS.MS');
