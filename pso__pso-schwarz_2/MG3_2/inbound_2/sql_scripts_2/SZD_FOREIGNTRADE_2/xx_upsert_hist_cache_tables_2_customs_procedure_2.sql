INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  customs_procedure_cd,
  requested_procedure_cd,
  additional_procedure_cd,
  approved_fg,
  --dwh_valid_fg,
  dwh_src_file_name, 
  dwh_src_1_tmsp,  
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
)
select ct.*
 from (select * 
 from (   
 select distinct LPAD(case when trim(item_government_procedure_current_code)='' or trim(item_government_procedure_current_code)='NULL' then null 
   else item_government_procedure_current_code end , 2, '0') 
|| LPAD(case when trim(item_government_procedure_previous_code)='' or trim(item_government_procedure_previous_code)='NULL' then null 
   else item_government_procedure_previous_code end, 2, '0') 
|| LPAD(case when trim(item_government_procedure_current_code_special)='' or trim(item_government_procedure_current_code_special)='NULL' then null 
   else item_government_procedure_current_code_special end, 3, '0') as customs_procedure_cd, 
 LPAD(case when trim(item_government_procedure_current_code)='' or trim(item_government_procedure_current_code)='NULL' then null 
   else item_government_procedure_current_code end, 2, '0') 
|| LPAD(case when trim(item_government_procedure_previous_code)='' or trim(item_government_procedure_previous_code)='NULL' then null 
   else item_government_procedure_previous_code end, 2, '0') as requested_procedure_cd,
 LPAD(case when trim(item_government_procedure_current_code_special)='' or trim(item_government_procedure_current_code_special)='NULL' then null 
   else item_government_procedure_current_code_special end, 3, '0') as additional_procedure_cd ,
  0 as approved_fg,
  --1 as dwh_valid_fg,
  dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
 from etl.t_cache_ceva_2 
 where customs_procedure_cd !='NULL'
 union 
  select distinct LPAD(case when trim(item_government_procedure_current_code)='' or trim(item_government_procedure_current_code)='NULL' then null 
   else item_government_procedure_current_code end , 2, '0') 
|| LPAD(case when trim(item_government_procedure_previous_code)='' or trim(item_government_procedure_previous_code)='NULL' then null 
   else item_government_procedure_previous_code end, 2, '0') 
|| LPAD(case when trim(item_government_procedure_current_code_special)='' or trim(item_government_procedure_current_code_special)='NULL' then null 
   else item_government_procedure_current_code_special end, 3, '0') as customs_procedure_cd, 
 LPAD(case when trim(item_government_procedure_current_code)='' or trim(item_government_procedure_current_code)='NULL' then null 
   else item_government_procedure_current_code end, 2, '0') 
|| LPAD(case when trim(item_government_procedure_previous_code)='' or trim(item_government_procedure_previous_code)='NULL' then null 
   else item_government_procedure_previous_code end, 2, '0') as requested_procedure_cd,
 LPAD(case when trim(item_government_procedure_current_code_special)='' or trim(item_government_procedure_current_code_special)='NULL' then null 
   else item_government_procedure_current_code_special end, 3, '0') as additional_procedure_cd ,
  0 as approved_fg,
  --1 as dwh_valid_fg,
  dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
 from etl.t_cache_maersk_lgb_2
 where customs_procedure_cd !='NULL'
 union 
  select distinct LPAD(case when trim(item_government_procedure_current_code)='' or trim(item_government_procedure_current_code)='NULL' then null 
   else item_government_procedure_current_code end , 2, '0') 
|| LPAD(case when trim(item_government_procedure_previous_code)='' or trim(item_government_procedure_previous_code)='NULL' then null 
   else item_government_procedure_previous_code end, 2, '0') 
|| LPAD(case when trim(item_government_procedure_current_code_special)='' or trim(item_government_procedure_current_code_special)='NULL' then null 
   else item_government_procedure_current_code_special end, 3, '0') as customs_procedure_cd, 
 LPAD(case when trim(item_government_procedure_current_code)='' or trim(item_government_procedure_current_code)='NULL' then null 
   else item_government_procedure_current_code end, 2, '0') 
|| LPAD(case when trim(item_government_procedure_previous_code)='' or trim(item_government_procedure_previous_code)='NULL' then null 
   else item_government_procedure_previous_code end, 2, '0') as requested_procedure_cd,
 LPAD(case when trim(item_government_procedure_current_code_special)='' or trim(item_government_procedure_current_code_special)='NULL' then null 
   else item_government_procedure_current_code_special end, 3, '0') as additional_procedure_cd ,
  0 as approved_fg,
  --1 as dwh_valid_fg,
  dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
 from etl.t_cache_maersk_lukt_2 
 where customs_procedure_cd !='NULL'
   union
   select distinct
  cpc as customs_procedure_cd,
  cpc as requested_procedure_cd, 
  cpc as additional_procedure_cd, 
  0 as approved_fg,
  --1 as dwh_valid_fg,
  dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
  from etl.t_cache_cds_item_2
  where customs_procedure_cd !='NULL'
   ) 
   QUALIFY ROW_NUMBER() OVER(PARTITION BY customs_procedure_cd ORDER BY DWH_SRC_FILE_NAME) = 1
   ) ct;
