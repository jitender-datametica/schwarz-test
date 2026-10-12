INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  customs_classification_scheme_cd,
  customs_tariff_code_cd,
  customs_tariff_code_descr,
  dwh_valid_fg,
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
select 
  'CTC_GB' as customs_classification_scheme_cd,
  LPAD(SUBSTR(REPLACE(item_commodity_code, ' ', ''), 1, 10), 10, '0') as customs_tariff_code_cd,
  NULL as customs_tariff_code_descr,
  1 as dwh_valid_fg,
  dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
   from etl.t_cache_ceva_1
   where item_commodity_code !='NULL'
   union 
   select 
  'CTC_GB' as customs_classification_scheme_cd,
  LPAD(SUBSTR(REPLACE(item_commodity_code, ' ', ''), 1, 10), 10, '0') as customs_tariff_code_cd,
  NULL as customs_tariff_code_descr,
  1 as dwh_valid_fg,
  dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
   from etl.t_cache_maersk_lgb_1
   where item_commodity_code !='NULL'
   union
   select 
  'CTC_GB' as customs_classification_scheme_cd,
  LPAD(SUBSTR(REPLACE(item_commodity_code, ' ', ''), 1, 10), 10, '0') as customs_tariff_code_cd,
  NULL as customs_tariff_code_descr,
  1 as dwh_valid_fg,
  dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
   from etl.t_cache_maersk_lukt_1
   where item_commodity_code !='NULL'
 union
 select 
  'CTC_GB' as customs_classification_scheme_cd,
  LPAD(SUBSTR(REPLACE(commodity_code, ' ', ''), 1, 10), 10, '0') as customs_tariff_code_cd,
  NULL as customs_tariff_code_descr, 
  1 as dwh_valid_fg,
  dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
  from etl.t_cache_cds_item_1
  where commodity_code !='NULL'
  union
  select 
  'CTC_GB' as customs_classification_scheme_cd,
  LPAD(SUBSTR(REPLACE(customs_tariff_number, ' ', ''), 1, 10), 10, '0') as customs_tariff_code_cd,
  NULL as customs_tariff_code_descr, 
  1 as dwh_valid_fg,
  dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
  from etl.t_cache_owim_1
  where customs_tariff_number !='NULL'
  union
  select 
  'CTC_GB' as customs_classification_scheme_cd,
  LPAD(SUBSTR(REPLACE(customs_tariff_number, ' ', ''), 1, 10), 10, '0') as customs_tariff_code_cd,
  NULL as customs_tariff_code_descr, 
  1 as dwh_valid_fg,
  dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
  from etl.t_cache_list_1
  where customs_tariff_number !='NULL' 
/*union 
select
 'CTC_GB' as customs_classification_scheme_cd,
 lpad(substr(replace(CCNGN, ' ', ''), 1, 10), 10, '0') as commodity_code,
NULL as customs_tariff_code_descr,
1 as dwh_valid_fg,
dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
         from etl.t_cache_zgts_brimport_1
        where CCNGN is not null */  
  ) 
   QUALIFY ROW_NUMBER() OVER(PARTITION BY customs_tariff_code_cd ORDER BY DWH_SRC_FILE_NAME) = 1
   ) ct
   left join core_rel.t_customs_tariff_code_1 cfc
   on ct.customs_tariff_code_cd= cfc.customs_tariff_code_cd
   where cfc.customs_tariff_code_cd is null;
