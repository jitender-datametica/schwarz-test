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
select ct.* from (
select
 'CTC_GB' as customs_classification_scheme_cd,
 lpad(substr(replace(CCNGN, ' ', ''), 1, 10), 10, '0') as customs_tariff_code_cd,
NULL as customs_tariff_code_descr,
1 as dwh_valid_fg,
dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
         from etl.t_cache_zgts_brimport_2 
        where CCNGN is not null) ct
   left join core_rel.t_customs_tariff_code_2 cfc
   on ct.customs_tariff_code_cd= cfc.customs_tariff_code_cd
   where cfc.customs_tariff_code_cd is null;
