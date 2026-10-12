create or replace view IDQ_PRODUCTION.IDQ_RESULTS.REF_DQ_LOADER_TABLES_COUNTRIES(
	TABLE_ID,
	TABLE_NAME,
	BRANCH_ID,
	SOURCE_SYSTEM_TYPE_ID,
	SOURCE_COUNTRY_ID,
	TARGET_COUNTRY_ID_LIST,
	COUNTRY_ID,
	SOURCE_SYSTEM_TYPE
) as
select 
    t.id, t.table_name, t.branch_id, t.source_system_type_id, to_varchar(v.source_country_id), to_varchar(v.target_country_id_list), value, sst.name
  from  
    IDQ_RESULTS.REF_DQ_STATUS_LOADER_SOURCE_TABLE t,
    IDQ_RESULTS.REF_SOURCE_SYSTEM_TYPE sst,
    IDQ_RESULTS.REF_DQ_STATUS_LOADER_SST_COUNTRY_ADDITIONAL_MAP v, LATERAL SPLIT_TO_TABLE(v.target_country_id_list, ',')
  where 
    to_varchar(t.country_id_list) = to_varchar(v.source_country_id) 
    and t.source_system_type_id = v.source_system_type_id
    and sst.id = t.source_system_type_id
    and sst.id = v.source_system_type_id
UNION
select
  v2.id, v2.table_name, v2.branch_id, v2.source_system_type_id, to_varchar(v2.country_id_list), to_varchar(v2.country_id_list), value, sst.name
from 
    IDQ_RESULTS.REF_SOURCE_SYSTEM_TYPE sst,
    IDQ_RESULTS.REF_DQ_STATUS_LOADER_SOURCE_TABLE v2, LATERAL SPLIT_TO_TABLE(v2.country_id_list, ',')
where 
   not exists  (select 1 from IDQ_RESULTS.REF_DQ_STATUS_LOADER_SST_COUNTRY_ADDITIONAL_MAP where source_system_type_id = v2.source_system_type_id and 
   to_varchar(source_country_id) = to_varchar(v2.country_id_list)) 
   and sst.id = v2.source_system_type_id;